## How to run?

#### From scratch

1. Download PrestaShop.

```bash
../scripts/download_prestashop.sh
```

2. Create `.env` file.

Copy `.env.template` to `.env`. Update secrets - you can use the `generate_secrets.sh` script.

```bash
../scripts/generate_secrets.sh
```
The `DOMAIN` variable is used to generate the SSL certificate.

3. Run the development environment.

```bash
../scripts/run_dev.sh run # other commands: start, build, stop
```
or 
```bash
docker compose -f docker-compose.dev.yaml up
```

> [!TIP]
> The development environment will mount the `./prestashop` directory to the container.

4. Install PrestaShop.

Follow the installation steps in your browser. By default, PrestaShop installer will be available at `https://localhost:8443/install`. 

5. Remove the `install` directory.

If you want to change the domain the shop is available at, you have to update it via the PrestaShop admin panel (Preferences -> SEO & URLs) and the `DOMAIN` variable in the `.env` file.

#### From source in this repository

> [!CAUTION]
> This method is not ready - we need a method to save the database and the files in the repository.
