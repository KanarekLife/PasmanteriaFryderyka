# Important information

Seeder does not check if the data is already in the shop, so to prevent bugs if you run the seeder multiple times, you should run `remover.py` before running the seeder.

# Usage

### Required env variables:

- `PRESTASHOP_API_KEY` - PrestaShop REST API key (the REST API must be enabled in the shop settings)

### Optional env variables:

- `SHOP_URL` - URL of the shop (default: `https://localhost:8443`)

To run the seeder, simply run `python3 seeder.py` with the required env variables set.
