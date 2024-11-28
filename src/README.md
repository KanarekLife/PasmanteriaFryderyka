## How to run?

### From source in this repository

1. Create `.env` file.
Copy `.env.template` to `.env` and update secrets - you can also use the `generate_env.sh` script.

```bash
../scripts/generate_env.sh > .env
# or
../scripts/generate_env.sh mydomain.com > .env
# to define the domain for the SSL certificate
```
2. Run the development environment.
```bash
../scripts/run_dev.sh up # other commands: up, down, build
```

or

```bash
docker compose -f docker-compose.dev.yaml up
```

3. Import database from backup.
```bash
../scripts/run_dev.sh restore
```

### From scratch

<details><summary>More info</summary>

1. Download PrestaShop.

```bash
../scripts/download_prestashop.sh
```

2. Create `.env` file.

Copy `.env.template` to `.env` and update secrets - you can also use the `generate_env.sh` script. Remember to change the SMTP credentials afterwards.

```bash
../scripts/generate_env.sh > .env
# or
../scripts/generate_env.sh mydomain.com > .env
# to define the domain for the SSL certificate
```

The `DOMAIN` variable is used to generate the SSL certificate and `PRESTASHOP_URL` is the address for Prestashop redirects. It most likely should be the same as `DOMAIN` with port prefix.

3. Run the development environment.

```bash
../scripts/run_dev.sh up # other commands: up, down, build
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

</details>

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


## Migrate Preastashop to another domain

1. Backup the database.
```bash
../scripts/run_dev.sh backup
```

2. Update the `DOMAIN` variable in the `.env` file. This is used to generate the SSL certificate.
   
3. Update the `PRESTASHOP_URL` variable in the `.env` file. This is the address for Prestashop redirects. It most likely should be the same as `DOMAIN` with port prefix.

4. Fully restart the environment.

```bash
../scripts/run_dev.sh down
../scripts/run_dev.sh up
```

5. Update database from the backup.

```bash
../scripts/run_dev.sh restore
```

## Discount, variants and out of stock products.

1. discounts and variants

10% discount on 'zapiecia-broszki' products, but priority is given to the 5 PLN discount
on individual products from this category, it is the only one active.
```
 [domain]/zapiecia-broszki/1311-ozdobna-przypinka-z-drewna-myszka-0656700163725.html
 [domain]/zapiecia-broszki/1310-ozdobna-przypinka-z-drewna-ptaszek-9565367514052.html
 [domain]/zapiecia-broszki/1308-ozdobna-przypinka-z-drewna-slonik-2188916489229.html
 [domain]/zapiecia-broszki/1309-ozdobna-przypinka-z-drewna-wiewiorka-3681744882121.html
```

20% discount on the category beads-wooden, in which the products are listed.
```
 [domain]/koraliki-drewniane/1307-koraliki-drewniane-buzki-14mm-5-sztuk-9605397813078.html
 [domain]/koraliki-drewniane/1306-koraliki-drewniane-buzki-20mm-5-sztuk-2905564128457.html
```

The products listed above also have variants (combinations), 
two categories of variants, and a different number of options in each category.

2. stock
There are 10 pieces of each product including each variant except those which are out of stock:

```
 [domain]/wloczka-100-akryl/12-wloczka-baby-yarnart-203-ciemny-fiolet-5665011950972.html
 [domain]/wloczka-100-akryl/11-wloczka-punch-etrofil-72106-4472677830799.html
 [domain]/wloczka-100-akryl/5-wloczka-punch-etrofil-72104-1452682180650.html
 [domain]/wloczka-100-akryl/6-wloczka-baby-yarnart-174-ostry-roz-5692192010799.html
 [domain]/wloczka-100-akryl/7-wloczka-adore-kolor-ecru-331-3085237449962.html
 [domain]/wloczka-100-akryl/8-wloczka-punch-etrofil-72107-2995147680330.html
 [domain]/wloczka-100-akryl/9-wloczka-baby-yarnart-195-szary-3131894076759.html
 [domain]/wloczka-100-akryl/10-wloczka-adore-kolor-bez-335-3363507332359.html
 [domain]/koraliki-drewniane/1306-koraliki-drewniane-buzki-20mm-5-sztuk-2905564128457.html
 [domain]/wloczka-100-akryl/3-wloczka-baby-yarnart-156-czerwony-5391184171460.html
 [domain]/wloczka-100-akryl/4-wloczka-adore-kolor-bialy-330-0605024598083.html
```
