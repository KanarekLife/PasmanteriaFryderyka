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

1. Create `.env` file. [See second step from upper section](#from-scratch)
2. Run the development environment. [See third step from upper section](#from-scratch)
3. Use [database import procedure.](#import/restore)

## Database export/import

#### Export/backup

Run below command to export database into db_backup folder:

```bash
../scripts/run_dev.sh backup
```

#### Import/restore

Run below command to import `backup.sql` file from db_backup folder:

```bash
../scripts/run_dev.sh restore
```
