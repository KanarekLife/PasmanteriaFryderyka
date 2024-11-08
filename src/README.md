## How to run?

#### From scratch

1. Download PrestaShop.

```bash
../scripts/download_prestashop.sh
```

2. Create `.env` file.

Copy `.env.template` to `.env` and update secrets - you can also use the `generate_env.sh` script.

```bash
../scripts/generate_env.sh > .env
# or
../scripts/generate_env.sh mydomain.com > .env
# to define the domain for the SSL certificate
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
> The development environment will mount the `./prestashop` directory to the container. Because of that, the performance on Windows can be very low. It's recommended to store the project on the WSL2 filesystem.

4. Install PrestaShop.

Follow the installation steps in your browser. By default, PrestaShop installer will be available at `https://localhost:8443/install`. 

5. Remove the `install` directory.

If you want to change the domain the shop is available at, you have to update it via the PrestaShop admin panel (Preferences -> SEO & URLs) and the `DOMAIN` variable in the `.env` file.

#### From source in this repository

> [!CAUTION]
> This method is not ready - we need a method to save the database and the files in the repository.

[HOW TO BACKUP AND IMPORT DATABASES]
create backup:
```bash
../scripts/backup_dev.sh create # dump all databases to /database-backup/ directory
```
import backup:
```bash
../scripts/backup_dev.sh import ./database-backup/all-db-backup-1731065240.sql # import databases from ./database-backup/all-db-backup-1731065240.sql
```
