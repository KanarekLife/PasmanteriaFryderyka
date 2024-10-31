from seeder import (
    API_KEY,
    CATEGORIES_ENDPOINT,
    PRODUCTS_ENDPOINT,
)
import requests
import xml.etree.ElementTree as ET
from alive_progress import alive_bar
import os


def debug_print(s: str):
    if os.environ.get("DEBUG"):
        print(s)


def remove_all():
    session = requests.Session()
    session.headers.update({"Content-Type": "application/xml"})
    session.verify = False
    session.auth = requests.auth.HTTPBasicAuth(API_KEY, "")

    # Products
    products_xml = session.get(PRODUCTS_ENDPOINT).text
    root = ET.fromstring(products_xml)
    products = root.findall("products/product")
    with alive_bar(len(products), title="Deleting products") as bar:
        for product in products:
            id = product.attrib["id"]
            debug_print(f"Deleting product with id {id}")
            session.delete(f"{PRODUCTS_ENDPOINT}/{id}")
            bar()

    # Categories
    categories_xml = session.get(CATEGORIES_ENDPOINT).text
    root = ET.fromstring(categories_xml)
    categories = root.findall("categories/category")
    with alive_bar(len(categories) - 2, title="Deleting categories") as bar:
        for category in categories:
            id = category.attrib["id"]
            if int(id) == 1 or int(id) == 2:
                continue  # skip root and home category
            debug_print(f"Deleting category with id {id}")
            session.delete(f"{CATEGORIES_ENDPOINT}/{id}")
            bar()


if __name__ == "__main__":
    remove_all()
