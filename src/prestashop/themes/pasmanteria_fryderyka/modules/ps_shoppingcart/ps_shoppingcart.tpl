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
<div id="_desktop_cart">
  <div class="blockcart cart-preview {if $cart.products_count > 0}active{else}inactive{/if}"
       data-refresh-url="{$refresh_url}">
    <div class="header blockcart-header dropdown js-dropdown">
      <a rel="nofollow"
         aria-label="{l s='Shopping cart link containing %nbProducts% product(s)' sprintf=['%nbProducts%' => $cart.products_count] d='Shop.Theme.Checkout'}"
         href="{$cart_url}"
         data-toggle="dropdown"
         aria-haspopup="true"
         aria-expanded="false">
        <span class="cart-products-count cart_des">{$cart.products_count}</span>
        <div id="bgimage"></div>
        <i class="cart material-icons hidden-md-down"></i>
        <span class="cart-title hidden-md-down">Koszyk</span>
        <i class="material-icons expand-more"></i>
      </a>
      <div class="cart_block block exclusive dropdown-menu">
        <div class="block_content">
          <div class="cart_block_list">
            {foreach from=$cart.products item=product}
              <div class="cart-item">
                <div class="cart-image">
                  <a href="{$product.url}">
                    <img src="{$product.cover.bySize.cart_default.url}"
                         alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                         loading="lazy"
                         data-full-size-image-url="{$product.cover.large.url}"
                         width="{$product.cover.bySize.cart_default.width}"
                         height="{$product.cover.bySize.cart_default.height}" />
                </div>
                <div class="cart-info">
                  <span class="product-quantity">{$product.quantity}&nbsp;x</span>
                  <span class="product-name"><a href="{$product.url}">{$product.name|truncate:7:'...'}</a></span>
                  <span class="product-price">{$product.price}&nbsp;zł</span>
                  <a class="remove-from-cart"
                     rel="nofollow"
                     href="{$product.remove_from_cart_url}"
                     data-link-action="delete-from-cart"
                     data-id-product="{$product.id}"
                     data-id-product-attribute="0"
                     data-id-customization="">
                    <i class="material-icons pull-xs-left">delete</i>
                  </a>
                </div>
              </div>
            {/foreach}
          </div>

          <div class="card cart-summary">
            <div class="card-block">
              <div class="cart-summary-line"
                   id="cart-subtotal-products">
                <span class="label js-subtotal">
                  {$cart.summary_string}
                </span>
                <span class="value">{$cart.subtotals.products.value}</span>
              </div>
              <div class="cart-summary-line"
                   id="cart-subtotal-shipping">
                <span class="label">
                  {$cart.subtotals.shipping.label}
                </span>
                <span class="value">{$cart.subtotals.shipping.value}</span>
                <div><small class="value"></small></div>
              </div>

            </div>

            <div class="card-block">
              <div class="cart-summary-line cart-total">
                <span class="label">Razem (brutto)</span>
                <span class="value">{$cart.totals.total_including_tax.value}</span>
              </div>

              {if $cart.subtotals.tax}
                <div class="cart-summary-line">
                  <small class="label">VAT (wliczony)</small>
                  <small class="value">{$cart.subtotals.tax.value}</small>
                </div>
              {/if}
            </div>
          </div>

          <div class="checkout card-block">
            <a rel="nofollow"
               href="{$cart_url}"
               class="viewcart">
              <button type="button"
                      class="btn btn-primary">Pokaż zawartość koszyka </button>
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>