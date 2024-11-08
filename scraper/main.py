from alive_progress import alive_bar
import json
import lxml.html as html
from pathlib import Path
import requests

MAIN_URL = 'https://www.twojapasmanteria.pl'
MAX_PRODUCTS_PER_SUBCATEGORY = 250
DESTINATION_DIR = Path(__file__).parent / 'data'
DESTINATION_JSON_FILENAME = 'data.json'
DESTINATION_IMAGES_DIRNAME = 'images'


class Scraper:
    def __init__(self, destination_dir: Path):
        self.__destination_images_dir = destination_dir / DESTINATION_IMAGES_DIRNAME
        self.__destination_json_file = destination_dir / DESTINATION_JSON_FILENAME
        self.__session = requests.Session()
        self.__total_categories = 0
        self.__current_category = 0 
        self.__total_subcategories = 0
        self.__current_subcategory = 0
        self.__current_page = 0

    def get_whole_page(self, url: str):
        page = self.__session.get(url)
        root = html.fromstring(page.content)
        categories = self.get_categories(root)

        with open(self.__destination_json_file, 'w') as file:
            json.dump(categories, file, indent=4)

        return categories

    def get_categories(self, main_root: html.HtmlElement):
        category_elements: list[html.HtmlElement] = main_root.xpath('/html/body/main/header/div[3]/div/div/ul/li')

        # skip first element, because it's a link to the main page
        # also skip last element, because it's a link to the discount page
        category_elements = category_elements[1:-1]

        category_names: list[str] = [category_element.xpath('a/span/text()')[0].strip() for category_element in category_elements]
        category_links: list[str] = [category_element.xpath('a/@href') for category_element in category_elements]

        self.__total_categories = len(category_elements)
        self.__current_category = 1

        subcategories = []
        for category_element in category_elements:
            subcategories.append(self.get_subcategories(category_element))
            self.__current_category += 1

        categories = {}
        for category_name, category_link, subcategory in zip(category_names, category_links, subcategories):
            categories[category_name] = {
                'link': category_link,
                'subcategories': subcategory
            }

        return categories

    def get_subcategories(self, category_element: html.HtmlElement):
        subcategory_elements: list[html.HtmlElement] = category_element.xpath('ul/li/a')

        subcategory_names: list[str] = [subcategory_element.xpath('span/text()')[0].strip() for subcategory_element in subcategory_elements]
        subcategory_links: list[str] = [subcategory_element.attrib['href'] for subcategory_element in subcategory_elements]

        self.__total_subcategories = len(subcategory_elements)
        self.__current_subcategory = 1

        subcategories = {}
        for subcategory_name, subcategory_link in zip(subcategory_names, subcategory_links):
            products = []
            i = 0
            while len(products) < MAX_PRODUCTS_PER_SUBCATEGORY:
                i += 1
                self.__current_page = i
                prev_len = len(products)
                products.extend(
                    self.get_products(
                        f'{subcategory_link}?page={i}',
                        max_products=MAX_PRODUCTS_PER_SUBCATEGORY - len(products)
                    )
                )
                if prev_len == len(products):
                    break

            subcategories[subcategory_name] = {
                'link': subcategory_link,
                'products': products
            }
            self.__current_subcategory += 1

        return subcategories

    def get_products(self, subcategory_link: str, max_products: int):
        subcategory_page = self.__session.get(subcategory_link)
        subcategory_root = html.fromstring(subcategory_page.content)

        product_links: list[str] = subcategory_root.xpath('/html/body/main/section/div/div/div/section/section/div/div/div/ul/li/div/div/h3/a/@href')

        product_links = product_links[:max_products]

        products = []
        bar_title = f'{self.__current_category:02d}/{self.__total_categories:02d} - {self.__current_subcategory:02d}/{self.__total_subcategories:02d} - {self.__current_page:02d}'
        with alive_bar(len(product_links), title=bar_title) as bar:
            for product_link in product_links:
                products.append(self.get_product_details(product_link))
                bar()

        return products

    def get_product_details(self, product_link: str):
        product_page = self.__session.get(product_link)
        product_root: html.HtmlElement = html.fromstring(product_page.content)

        name = product_root.xpath('/html/body/main/section/div/div/div/section/div[1]/div[2]/h1/text()')[0].strip()
        price = float(product_root.xpath('/html/body/main/section/div/div/div/section/div[1]/div[2]/div[1]/div[1]/div/span/@content')[0])
        image_urls = product_root.xpath('/html/body/main/section/div/div/div/section/div[1]/div[1]/section/div[1]/div[2]/ul/li/img/@data-image-large-src')
        description = product_root.xpath('/html/body/main/section/div/div/div/section/div[1]/div[3]/div/div[1]/div')[0].text_content().strip()

        other_qualities_keys = product_root.xpath('/html/body/main/section/div/div/div/section/div[1]/div[3]/div/div[2]/section/dl/dt/text()')
        other_qualities_values = product_root.xpath('/html/body/main/section/div/div/div/section/div[1]/div[3]/div/div[2]/section/dl/dd/text()')
        other_qualities = dict(zip(other_qualities_keys, other_qualities_values))

        image_local_paths = []
        for image_url in image_urls:
            path = self.download_image(image_url)
            image_local_paths.append(path)

        images = [{'url': url, 'local_path': local_path} for url, local_path in zip(image_urls, image_local_paths)]

        return {
            'name': name,
            'price': price,
            'images': images,
            'description': description,
            'other_qualities': other_qualities
        }

    def download_image(self, url: str):
        self.__destination_images_dir.mkdir(parents=True, exist_ok=True)
        image_name = '_'.join(url.split('/')[-2:])
        image_path = self.__destination_images_dir / image_name

        if image_path.exists():
            return str(image_path)

        image = self.__session.get(url)
        with open(image_path, 'wb') as file:
            file.write(image.content)
        
        return str(image_path)


if __name__ == '__main__':
    scraper = Scraper(DESTINATION_DIR)
    scraper.get_whole_page(MAIN_URL)
