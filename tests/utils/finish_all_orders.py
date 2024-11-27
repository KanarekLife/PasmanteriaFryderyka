import requests
import os
import urllib3
import xml.etree.ElementTree as ET
from alive_progress import alive_bar

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

XML_TEMPLATE = """<?xml version="1.0" encoding="UTF-8"?>
<prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
    <order_history>
        <id />
        <id_employee/>
        <id_order_state/>
        <id_order/>
        <date_add />
    </order_history>
</prestashop>
"""


class OrderFinisher:
    def __init__(self, shop_url: str, api_key: str):
        self.__session = requests.Session()
        self.__session.verify = False
        self.__session.auth = requests.auth.HTTPBasicAuth(api_key, "")
        self.__shop_url = shop_url
        self.__orders_endpoint = f"{self.__shop_url}/api/orders"
        self.__order_histories_endpoint = f"{self.__shop_url}/api/order_histories"

    def finish_orders(self):
        all_orders_xml = self.__session.get(self.__orders_endpoint).text
        root = ET.fromstring(all_orders_xml)
        orders = root.findall("orders/order")
        with alive_bar(len(orders), title="Setting orders state") as bar:
            for order in orders:
                order_id = int(order.attrib["id"])
                order_root = ET.fromstring(XML_TEMPLATE)
                order_root.find("order_history/id_employee").text = "1"
                order_root.find("order_history/id_order_state").text = "9"
                order_root.find("order_history/id_order").text = str(order_id)
                response = self.__session.post(f"{self.__order_histories_endpoint}", data=ET.tostring(order_root))
                if not response.ok:
                    print(f"Failed to set order state to 9 for order {order_id}")
                bar()


if __name__ == "__main__":
    SHOP_URL = os.environ["SHOP_URL"] if os.environ.get("SHOP_URL") is not None else "https://localhost:8443"
    API_KEY = os.environ["PRESTASHOP_API_KEY"]
    order_finisher = OrderFinisher(SHOP_URL, API_KEY)
    order_finisher.finish_orders()
