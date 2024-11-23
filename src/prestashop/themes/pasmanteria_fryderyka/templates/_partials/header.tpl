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
{block name='header_banner'}
  <div class="header-banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  <nav class="header-nav">
    <div class="container">
      <div class="hidden-md-down">
      </div>
      <div class="hidden-lg-up text-xs-center mobile">
      </div>
    </div>
  </nav>
{/block}

{block name='header_top'}
  <div class="header-top">
    <div class="full-header">
      <div class="container">
        <div id="_desktop_logo" class="header_logo hidden-md-down">
          <div id="header_logo" class="container">
            {renderLogo}
          </div>
        </div>

        <div id="_desktop_cart">
          {hook h='displayShoppingCart'}
        </div>

        {hook h='displaySignIn'}

        {hook h='displaySearch'}
      </div>
    </div>
    <div class="menu_bg"></div>
  </div>

  <!-- TEST -->

  <div id="_desktop_top_menu" class="container_wb_megamenu container">
    <div class="wb-menu-vertical clearfix">
      <div class="menu-vertical">
        <a href="javascript:void(0);" class="close-menu-content"><span><i class="fa fa-times" aria-hidden="true"></i></span></a>
        {hook h='displayMainMenu'}
      </div>
    </div>
  </div>
{/block}
