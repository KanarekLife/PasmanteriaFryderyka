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
<section class="tm-hometabcontent hb-animate-element left-to-right hb-in-viewport">
  <div class="tab-main-title">
		<div class="container">
			<h2 class="h1 products-section-title text-uppercase">polecane</h2>

		<div class="tabs">
			<ul id="home-page-tabs" class="nav nav-tabs clearfix">
						
			</ul>
		</div>
		</div>
	</div>

  <div class="container">
    <div class="tab-content">
      <div id="featureProduct" class="tm_productinner" tab-pane active>
        <section class="featured-products clearfix">
          <div id="spe_res">
            <div class="products">
              {include file="catalog/_partials/productlist.tpl" products=$products cssClass="featured_grid product_list grid row gridcount" productClass="col-xs-12 col-sm-6 col-md-4 col-lg-3"}
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>
</section>
