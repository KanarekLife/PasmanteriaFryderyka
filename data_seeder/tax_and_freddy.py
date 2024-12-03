import requests
import os
import urllib3
import xml.etree.ElementTree as ET
from alive_progress import alive_bar
from pathlib import Path

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


class Fixer:
    def __init__(self, shop_url: str, api_key: str):
        self.__session = requests.Session()
        self.__session.verify = False
        self.__session.auth = requests.auth.HTTPBasicAuth(api_key, "")
        self.__shop_url = shop_url
        self.__products_endpoint = f"{self.__shop_url}/api/products"
        self.__products_images_endpoint = f"{self.__shop_url}/api/images/products"

    def fix(self):
        freddy_image_path = Path("freddy.jpg")
        all_products_xml = self.__session.get(self.__products_endpoint).text
        root = ET.fromstring(all_products_xml)
        products = root.findall("products/product")
        with alive_bar(len(products), title="Setting tax") as bar:
            for product in products:
                product_id = int(product.attrib["id"])
                # set tax
                product_xml = self.__session.get(f"{self.__products_endpoint}/{product_id}").text
                product_root = ET.fromstring(product_xml)
                product_root.find("product/id_tax_rules_group").text = "1"
                product_root.find("product/price").text = "{:.6f}".format(float(product_root.find("product/price").text) / 1.23) # 23% percent tax, we can only assign netto price, but in data we have brutto price
                product_root.find("product").remove(product_root.find("product/manufacturer_name"))
                product_root.find("product").remove(product_root.find("product/quantity"))
                product_root.find("product").remove(product_root.find("product/low_stock_threshold"))
                response = self.__session.put(f"{self.__products_endpoint}/{product_id}", data=ET.tostring(product_root))
                if not response.ok:
                    print(f"Failed to set product tax to 1 for product {product_id}")
                    print(response.text)
                # upload freddy image
                # check how many images are already uploaded
                product_images_xml = self.__session.get(f"{self.__products_images_endpoint}/{product_id}").text
                product_images_root = ET.fromstring(product_images_xml)
                images_len = len(product_images_root.findall("image/declination"))
                if images_len < 2:
                    print(f"Uploading Freddy for product {product_id}")
                    freddy_image_param = {"image": (freddy_image_path.name, open(freddy_image_path, "rb"), "image/jpeg")}
                    response = self.__session.post(
                        f"{self.__products_images_endpoint}/{product_id}",
                        files=freddy_image_param,
                    )
                    if not response.ok:
                        print(
                            f"Failed to upload image for product {product_id} with {response.text}"
                        )
                bar()


if __name__ == "__main__":
    SHOP_URL = os.environ["SHOP_URL"] if os.environ.get("SHOP_URL") is not None else "https://localhost:8443"
    API_KEY = os.environ["PRESTASHOP_API_KEY"]
    order_finisher = Fixer(SHOP_URL, API_KEY)
    order_finisher.fix()
