#!/bin/bash

if test -d prestashop; then
    echo "PrestaShop already installed"
    exit 0
fi

echo "Downloading PrestaShop..."
mkdir -p prestashop
cd prestashop
wget -O ps.zip https://github.com/PrestaShop/PrestaShop/releases/download/1.7.8.11/prestashop_1.7.8.11.zip
unzip ps.zip
rm ps.zip index.php Install_PrestaShop.html
unzip prestashop.zip
rm prestashop.zip
cd ..
chmod -R 777 prestashop