import logging
import time
from typing import Callable, Any, Literal
import random

from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.remote.webelement import WebElement


PAGE_LOAD_TIMEOUT = 10
PRESTA_SHOP_URL = "https://localhost:8443/"

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s")


def get_driver() -> webdriver.Remote:
    return webdriver.Firefox()


def wait_for(driver: webdriver.Remote,
             selector: str | WebElement | Callable[[Any], WebElement | Literal[False]],
             by: str = By.CSS_SELECTOR,
             timeout: int = PAGE_LOAD_TIMEOUT):
    """ Wait for an element to be visible on the page """

    if issubclass(type(selector), str):
        predicate = EC.element_to_be_clickable((by, selector))
    elif issubclass(type(selector), WebElement):
        predicate = EC.element_to_be_clickable(selector)
    elif issubclass(type(selector), Callable):
        predicate: Callable[[Any], WebElement | Literal[False]] = selector
    else:
        raise ValueError('Selector should be a string, WebElement or a callable')

    try:
        element = WebDriverWait(driver, timeout).until(predicate)
    except TimeoutException as e:
        message = f'Element "{selector}" not found on the page'
        logger.error(message)
        raise TimeoutError(message) from e
    return element


class FunctionalTest:
    def __init__(self, driver: webdriver.Remote):
        self.driver = driver
        self.ordered_products = {}
        self.ordered_products_count = 0
        self.order_number = None
    
    def enter_category(self, category_id: int):
        top_menu = wait_for(self.driver, 'ul#top-menu')
        categories = top_menu.find_elements(By.CSS_SELECTOR, 'li.category.level-1')
        category = categories[category_id]
        category.click()
        wait_for(self.driver, 'section#main')

    def order_product(self, product_id: int, quantity: int):
        product = wait_for(self.driver, f'ul.products > li:nth-of-type({product_id + 1}) > article.product-miniature')
        product.click()

        product_name = wait_for(self.driver, 'h1:has(+.product-prices)').text
        logger.info('Adding product "%s" x %d to the cart', product_name, quantity)
        self.ordered_products[product_name] = quantity

        quantity_element = wait_for(self.driver, 'input#quantity_wanted')
        assert quantity_element.get_attribute('value') == '1', 'Initially quantity should be 1'

        for _ in range(quantity - 1):
            wait_for(self.driver, '.qty .bootstrap-touchspin-up').click()
        
        assert quantity_element.get_attribute('value') == str(quantity), 'Quantity should be updated'

        wait_for(self.driver, '.add-to-cart').click()
        self.ordered_products_count += quantity
        
        cart_predicate = lambda driver: driver.find_element(By.CSS_SELECTOR, 'span.cart-products-count').text == str(self.ordered_products_count)
        wait_for(self.driver, cart_predicate)

        self.driver.back()
    
    def run_all_tests(self):
        tests_start_time = time.time()

        logger.info('Running all tests')
        driver.get(PRESTA_SHOP_URL)

        self.test_add_10_items_to_the_cart()
        self.test_search_for_a_product_and_add_to_cart()
        self.test_remove_3_products_from_the_cart()
        self.test_register_a_new_account()
        self.test_execute_order()
        self.test_select_carrier()
        self.test_select_payment_method()
        self.test_check_order_status()
        self.test_download_vat_invoice()

        logger.info('All tests passed')
        tests_end_time = time.time()
        logger.info(f'Tests took {tests_end_time - tests_start_time:.2f} seconds')

    def test_add_10_items_to_the_cart(self):
        logger.info('Step 1 - Adding 10 items to the cart')

        QUANTITIES_TO_ORDER = [2, 3, 1, 4, 5, 2, 3, 1, 4, 5]

        logger.info('Entering the first category')
        self.enter_category(0)

        logger.info('Adding 5 items from the first category')
        assert wait_for(self.driver, 'span.cart-products-count').text == '0', 'Initially cart should be empty'

        for i in range(5):
            self.order_product(i, QUANTITIES_TO_ORDER[i - 1])

        logger.info('Entering the second category')
        self.enter_category(1)

        logger.info('Adding 5 items from the second category')
        for i in range(5, 10):
            self.order_product(i, QUANTITIES_TO_ORDER[i - 1])

        # TODO: maybe verify the cart contents?

    def test_search_for_a_product_and_add_to_cart(self):
        logger.info('Step 2 - Searching for a product by name and adding a random product to the cart from among those found')

        SEARCH_QUERY = 'oczy'

        logger.info('Searching for "%s"', SEARCH_QUERY)
        search_input = wait_for(self.driver, '#search_widget input[name="s"]')
        search_input.send_keys(SEARCH_QUERY)
        wait_for(self.driver, '#search_widget button').click()

        search_results = wait_for(self.driver, 'section#products')
        products = search_results.find_elements(By.CSS_SELECTOR, 'article.product-miniature')

        assert len(products) > 0, 'At least one product should be found'

        logger.info('Adding a random product from the search results to the cart')
        self.order_product(random.randrange(0, len(products)), 1)
    
    def test_remove_3_products_from_the_cart(self):
        logger.info('Step 3 - Removing 3 products from the cart')

        logger.info('Entering the cart')
        wait_for(self.driver, '#_desktop_cart').click()
        wait_for(self.driver, '.cart_block .checkout button').click()

        logger.info('Removing 3 products from the cart')
        for i in range(3):
            cart_items = wait_for(self.driver, 'ul.cart-items')
            products = cart_items.find_elements(By.CSS_SELECTOR, 'li.cart-item')
            product = products[0]
            product_name = product.find_element(By.CSS_SELECTOR, 'a.label').text
            quantity = self.ordered_products.pop(product_name)
            logger.info('Removing product "%s" x %d from the cart', product_name, quantity)
            self.ordered_products_count -= quantity
            remove_button = product.find_element(By.CSS_SELECTOR, 'a.remove-from-cart')
            remove_button.click()

            cart_predicate = lambda driver: driver.find_element(By.CSS_SELECTOR, 'span.cart-products-count').text == str(self.ordered_products_count)
            wait_for(self.driver, cart_predicate)

    def test_register_a_new_account(self):
        logger.info('Step 4 - Registering a new account')

        GENDER: Literal[1, 2] = 1
        FIRST_NAME = 'Chica'
        LAST_NAME = 'Chicken'
        EMAIL = 'chica.chicken@pizzaplex.com'
        PASSWORD = 'chica123'

        logger.info('Entering the registration page')

        wait_for(driver, '#_desktop_user_info').click()
        wait_for(driver, '.user-info').click()
        wait_for(driver, '.no-account').click()

        logger.info('Filling the registration form')
        
        logger.info('Gender: %s', GENDER)
        wait_for(driver, f'label[for="field-id_gender-{GENDER}"]').click()

        logger.info('First name: %s', FIRST_NAME)
        first_name_input = wait_for(driver, 'input#field-firstname')
        first_name_input.send_keys(FIRST_NAME)

        logger.info('Last name: %s', LAST_NAME)
        last_name_input = wait_for(driver, 'input#field-lastname')
        last_name_input.send_keys(LAST_NAME)

        logger.info('Email: %s', EMAIL)
        email_input = wait_for(driver, 'input#field-email')
        email_input.send_keys(EMAIL)

        logger.info('Password %s', PASSWORD)
        password_input = wait_for(driver, 'input#field-password')
        password_input.send_keys(PASSWORD)

        logger.info('Accepting the terms')
        wait_for(driver, 'label:has(input[name="customer_privacy"])').click()
        wait_for(driver, 'label:has(input[name="psgdpr"])').click()

        logger.info('Submitting the form')
        wait_for(driver, 'form#customer-form button[type="submit"]').click()

        logger.info('Verifying the registration')
        wait_for(driver, '#_desktop_user_info').click()
        assert wait_for(driver, '.user-info .account').text == f'{FIRST_NAME} {LAST_NAME}', 'Account name should be displayed'

    def test_execute_order(self):
        logger.info('Step 5 - Executing an order of the contents of the shopping cart')

        ADDRESS = "Freddy's Burger, Erazma z Zakroczymia 2A"
        POSTAL_CODE = '03-185'
        CITY = 'Warszawa'

        logger.info('Entering the cart')
        wait_for(driver, '#_desktop_cart').click()
        wait_for(driver, '.cart_block .checkout button').click()

        logger.info('Proceeding to the checkout')
        wait_for(driver, '.cart-summary .btn-primary').click()

        logger.info('Filling the address form')

        logger.info('Address: %s', ADDRESS)
        wait_for(driver, 'input#field-address1').send_keys(ADDRESS)

        logger.info('Postal code: %s', POSTAL_CODE)
        wait_for(driver, 'input#field-postcode').send_keys(POSTAL_CODE)

        logger.info('City: %s', CITY)
        wait_for(driver, 'input#field-city').send_keys(CITY)

        logger.info('Proceeding to the next step')
        wait_for(driver, 'button[name="confirm-addresses"]').click()

    def test_select_carrier(self):
        logger.info('Step 6 - Selection of one of two carriers')

        DELIVERY_OPTION = 2

        logger.info('Selecting the carrier nr %d', DELIVERY_OPTION)
        wait_for(driver, f'label.delivery-option-{DELIVERY_OPTION}').click()

        logger.info('Proceeding to the next step')
        wait_for(driver, 'button[name="confirmDeliveryOption"]').click()

    def test_select_payment_method(self):
        logger.info('Step 7 - Selecting the method of payment: on delivery')

        PAYMENT_OPTION = 3

        logger.info('Selecting the payment option nr %d', PAYMENT_OPTION)
        driver.find_element(By.CSS_SELECTOR, f'#payment-option-{PAYMENT_OPTION}-container input').click()

        logger.info('Accepting the terms')
        driver.find_element(By.CSS_SELECTOR, 'input[name="conditions_to_approve[terms-and-conditions]"]').click()

        logger.info('Step 8 - Approval of the order')
        POSITIVE_CONFIRMATION = 'twoje zamówienie zostało potwierdzone'

        wait_for(driver, '#payment-confirmation button').click()

        confirmation_predicate = lambda driver: POSITIVE_CONFIRMATION in driver.find_element(By.CSS_SELECTOR, '#content-hook_order_confirmation .card-title').text.lower()
        wait_for(driver, confirmation_predicate)

        self.order_number = wait_for(driver, '#order-reference-value').text.split()[-1]

    def test_check_order_status(self):
        logger.info('Step 9 - Checking the status of the order')

        logger.info('Entering the account')
        wait_for(driver, '#_desktop_user_info').click()
        wait_for(driver, 'a.account').click()

        logger.info('Entering the order history')
        wait_for(driver, '#history-link').click()

        logger.info('Checking the status of the last order')
        last_order_number = wait_for(driver, 'table.table tbody th').text
        assert last_order_number == self.order_number, 'The last order should be the one just placed'

        status = wait_for(driver, 'table.table tbody span.label').text
        logger.info('Order status: %s', status)

        wait_for(driver, '.order-actions a').click()

    def test_download_vat_invoice():
        logger.info('Downloading the VAT invoice')
        
        pass    # TODO


if __name__ == '__main__':
    with get_driver() as driver:
        test = FunctionalTest(driver)
        test.run_all_tests()