import requests
from pathlib import Path
import json
import os
import urllib3
import xml.etree.ElementTree as ET
import random
from jinja2 import Environment, FileSystemLoader
from alive_progress import alive_bar

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


DATA_DIR = Path(__file__).parent.parent / "data"
DATA_JSON_FILENAME = "data.json"
XML_TEMPLATES_DIRNAME = Path(__file__).parent / "xml_templates"

API_KEY = os.environ["PRESTASHOP_API_KEY"]

IP_PORT = "https://localhost:8443"
PRODUCTS_ENDPOINT = f"{IP_PORT}/api/products"
CATEGORIES_ENDPOINT = f"{IP_PORT}/api/categories"
STOCK_ENDPOINT = f"{IP_PORT}/api/stock_availables"
PRODUCTS_IMAGES_ENDPOINT = f"{IP_PORT}/api/images/products"

STOCK_DEFAULT_QUANTITY = 10
PRODUCT_PER_CATEGORY_LIMIT = 99
NUMBER_OF_UNAVAILABLE_PRODUCTS = 10


def debug_print(s: str):
    if os.environ.get("DEBUG"):
        print(s)


class ShopItem:
    jinja_env = Environment(loader=FileSystemLoader(XML_TEMPLATES_DIRNAME))

    def __init__(self):
        self.id = None

    def set_id(self, id: int):
        self.id = id


class Category(ShopItem):
    def __init__(self, name: str):
        super().__init__()
        self.name = name

    def to_xml(self):
        template = ShopItem.jinja_env.get_template("category_template.xml")
        return template.render(name=self.name)

    def set_id_from_response(self, xml_response: str):
        root = ET.fromstring(xml_response)
        self.set_id(int(root.find("category/id").text))


class Subcategory(Category):
    def __init__(self, name: str, parent: Category):
        super().__init__(name)
        self.name = name
        self.parent = parent

    def to_xml(self):
        template = ShopItem.jinja_env.get_template("subcategory_template.xml")
        return template.render(name=self.name, parent_id=self.parent.id)


class Product(ShopItem):
    def __init__(self, product_json: dict, category: Category):
        super().__init__()
        self.category = category

        self.name = product_json["name"]
        self.price = product_json["price"]
        self.images_paths = list(
            map(
                lambda image: Path(__file__).parent.parent / image["local_path"],
                product_json["images"],
            )
        )
        self.description = product_json["description"]
        self.ean13 = "".join([str(random.randint(0, 9)) for _ in range(13)])

    def to_xml(self):
        template = ShopItem.jinja_env.get_template("product_template.xml")
        return template.render(
            ean13=self.ean13,
            category_id=self.category.id,
            name=self.name,
            description=self.description,
            price=self.price,
        )

    def set_id_from_response(self, xml_response: str):
        root = ET.fromstring(xml_response)
        self.set_id(int(root.find("product/id").text))


class Seeder:
    def __init__(self, data_dir: Path):
        self.__data_json_file = data_dir / DATA_JSON_FILENAME
        self.__session = requests.Session()
        self.__session.verify = False
        self.__session.auth = requests.auth.HTTPBasicAuth(API_KEY, "")

    def patch_stock(self, product_id: int, stock: int):
        stock_xml = self.__session.get(
            f"{STOCK_ENDPOINT}?filter[id_product]={product_id}&display=full"
        ).text
        root = ET.fromstring(stock_xml)
        stock_id = int(root.find("stock_availables/stock_available/id").text)
        template = ShopItem.jinja_env.get_template("stock_template.xml")
        patch_xml = template.render(
            stock_id=stock_id, product_id=product_id, stock=stock
        )
        response = self.__session.put(f"{STOCK_ENDPOINT}/{stock_id}", data=patch_xml)
        if not response.ok:
            print(
                f"Failed to update stock for product {product_id} with {response.text}"
            )
        else:
            debug_print(f"Stock for product {product_id} updated to {stock}")

    def upload_images(self, product_id: int, images_paths: list[Path]):
        for image_path in images_paths:
            files = {"image": (image_path.name, open(image_path, "rb"), "image/jpeg")}
            response = self.__session.post(
                f"{PRODUCTS_IMAGES_ENDPOINT}/{product_id}",
                files=files,
            )
            if not response.ok:
                print(
                    f"Failed to upload image for product {product_id} with {response.text}"
                )
            else:
                debug_print(f"Image for product {product_id} uploaded")

    def create_category(self, name: str) -> Category:
        category = Category(name)
        category_xml = category.to_xml()
        response = self.__session.post(
            CATEGORIES_ENDPOINT,
            data=category_xml.encode("utf-8"),
        )
        if not response.ok:
            print(f"Failed to create category {category.name} with {response.text}")
            return None
        category.set_id_from_response(response.text)
        debug_print(f"Category {category.name} created")
        return category

    def create_subcategory(self, name: str, parent: Category) -> Subcategory:
        subcategory = Subcategory(name, parent)
        subcategory_xml = subcategory.to_xml()
        response = self.__session.post(
            CATEGORIES_ENDPOINT,
            data=subcategory_xml.encode("utf-8"),
        )
        if not response.ok:
            print(
                f"Failed to create subcategory {subcategory.name} with {response.text}"
            )
            return None
        subcategory.set_id_from_response(response.text)
        debug_print(f"Subcategory {subcategory.name} created")
        return subcategory

    def create_product(self, product_json: dict, category: Category) -> Product:
        product = Product(product_json, category)
        product_xml = product.to_xml()
        response = self.__session.post(
            PRODUCTS_ENDPOINT,
            data=product_xml.encode("utf-8"),
        )
        if not response.ok:
            print(f"Failed to create product {product.name} with {response.text}")
            return None
        product.set_id_from_response(response.text)
        debug_print(f"Product {product.name} created")
        self.patch_stock(product.id, STOCK_DEFAULT_QUANTITY)
        self.upload_images(product.id, product.images_paths)
        return product

    def read_and_seed(self, product_limit: int = 3) -> list[Product]:
        with open(self.__data_json_file, "r") as file:
            categories = json.load(file)

        total_products = sum(
            min(len(subcategory["products"]), product_limit)
            for category in categories.values()
            for subcategory in category["subcategories"].values()
        )
        products = []
        with alive_bar(total_products, title="Importing products") as bar:
            for category_name, category_data in categories.items():
                category = self.create_category(category_name)
                if category is None:
                    exit(1)
                for subcategory_name, subcategory_data in category_data[
                    "subcategories"
                ].items():
                    subcategory = self.create_subcategory(subcategory_name, category)
                    if subcategory is None:
                        exit(1)
                    for i, product in enumerate(subcategory_data["products"]):
                        if i == product_limit:
                            break
                        created_product = self.create_product(product, subcategory)
                        products.append(created_product)
                        bar()
        return products

    def zero_stock(self, products: list[Product]):
        with alive_bar(
            len(products), title="Setting stock of some products to 0"
        ) as bar:
            for product in products:
                self.patch_stock(product.id, 0)
                bar()


if __name__ == "__main__":
    seeder = Seeder(DATA_DIR)
    created_products = seeder.read_and_seed(product_limit=PRODUCT_PER_CATEGORY_LIMIT)
    seeder.zero_stock(created_products[:NUMBER_OF_UNAVAILABLE_PRODUCTS])
