# Usage

### Required env variables:

- `PRESTASHOP_API_KEY` - PrestaShop REST API key (the REST API must be enabled in the shop settings)

### Optional env variables:

- `MOZ_HEADLESS` - set it to any value to run the tests in headless mode

### Running the tests

To run the tests, simply run `python3 test.py` with the required env variables set.

### Test results

Test logs are printed to the console and saved to `test-run.log`.

If all tests pass, the script will exit with code 0. If any test fails, the script will exit with a non-zero code.