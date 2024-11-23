{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
<section class="productscategory-products clearfix mt-3">
  <div id="spe_title_bottom">
    <h2 class="h1 products-section-title text-uppercase">{l s='%s other product in the same category:' sprintf=[$products|@count] d='Shop.Theme.Catalog'}</h2>
	</div>
  <div id="spa_res">
    <div class="products">
      <ul id="productscategory-carousel" class="tm-carousel product_list owl-carousel owl-theme">
        {foreach from=$products item=product key=position}
          <li class="owl-item">
            {include file="catalog/_partials/miniatures/product.tpl" product=$product position=$position productClasses="product-miniature"}
          </li>
        {/foreach}
        <div class="owl-controls clickable"><div class="owl-pagination"><div class="owl-page active"><span class=""></span></div><div class="owl-page"><span class=""></span></div><div class="owl-page"><span class=""></span></div><div class="owl-page"><span class=""></span></div></div></div>
      </ul>
      <div class="customNavigation">
				<a class="btn prev productscategory_prev">&nbsp;</a>
				<a class="btn next productscategory_next">&nbsp;</a>
			</div>
    </div>
  </div>
</section>
