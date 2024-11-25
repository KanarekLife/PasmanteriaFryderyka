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
<div class="footer-before container">
  <div class="container">
  </div>
</div>
<div class="footer-container">
  <div class="container">
    <div class="row footer">
      <div class="footerblock"></div>
      <div class="block-contact col-md-4 links wrapper hb-animate-element bottom-to-top hb-in-viewport">
        <h3 class="text-uppercase block-contact-title hidden-sm-down">Informacja o sklepie</h3>
        <div class="title clearfix hidden-md-up"
             data-target="#block-contact_list"
             data-toggle="collapse">
          <span class="h3">Informacja o sklepie</span>
          <span class="pull-xs-right">
            <span class="navbar-toggler collapse-icons">
              <i class="material-icons add"></i>
              <i class="material-icons remove"></i>
            </span>
          </span>
        </div>
        <ul id="block-contact_list"
            class="collapse">
          <li>
            <i class="address image"></i>
            <span class="contactdiv"> Twoja Pasmanteria Świat Włóczek<br>Fitznerów 2<br>41-100 Siemianowice
              Śl<br>Polska</span>
          </li>
          <li>
            <i class="contact image"></i>
            Zadzwoń do nas: <span>xxxxxxxxx</span>
          </li>
          <li>
            <i class="email image"></i>
            Napisz do nas: <span>freddy@fazbear.com</span>
          </li>
        </ul>
      </div>
      <div class="col-md-4 links block links hb-animate-element top-to-bottom hb-in-viewport">
        <h3 class="h3 hidden-md-down">Ważne </h3>
        <div class="title h3 block_title hidden-lg-up"
             data-target="#footer_sub_menu_65675"
             data-toggle="collapse">
          <span class="">Ważne </span>
          <span class="pull-xs-right">
            <span class="navbar-toggler collapse-icons">
              <i class="material-icons add"></i>
              <i class="material-icons remove"></i>
            </span>
          </span>
        </div>
        {hook h='displayLinkList'}
      </div>
      <div class="col-md-4 links block links hb-animate-element top-to-bottom hb-in-viewport">
        <h3 class="h3 hidden-md-down">Informacje</h3>
        <div class="title h3 block_title hidden-lg-up"
             data-target="#footer_sub_menu_7613"
             data-toggle="collapse">
          <span class="">Informacje</span>
          <span class="pull-xs-right">
            <span class="navbar-toggler collapse-icons">
              <i class="material-icons add"></i>
              <i class="material-icons remove"></i>
            </span>
          </span>
        </div>
        {hook h='displayInfoLinkList'}
      </div>
      <div class="block_newsletter col-lg-12 col-md-12 col-sm-12 hb-animate-element bottom-to-top hb-in-viewport">
        <p class="col-md-5 col-xs-12 title hidden-md-down">zapisz się do newslettera</p>

        <p class="block_title  title hidden-lg-up"
           data-target="#block_email_toggle"
           data-toggle="collapse">zapisz się do newslettera
          <span class="pull-xs-right">
            <span class="navbar-toggler collapse-icons">
              <i class="material-icons add"></i>
              <i class="material-icons remove"></i>
            </span>
          </span>
        </p>

        <div class="col-md-7 col-xs-12 block_content collapse"
             id="block_email_toggle">
          <form action="/#footer"
                method="post">
            <div class="col-xs-12">
              <div class="input-wrapper">
                <input name="email"
                       type="text"
                       value=""
                       placeholder="Twój adres Email..."
                       aria-labelledby="block-newsletter-label">
              </div>
              <input class="btn btn-primary pull-xs-right hidden-xs-down"
                     name="submitNewsletter"
                     type="submit"
                     value="Subskrybuj">
              <input class="btn btn-primary pull-xs-right hidden-sm-up"
                     name="submitNewsletter"
                     type="submit"
                     value="Tak">

              <input type="hidden"
                     name="action"
                     value="0">
              <div class="clearfix"></div>
            </div>
            <div class="col-xs-12 forcondition">
              <!--  <p>Możesz zrezygnować w każdej chwili. W tym celu należy odnaleźć szczegóły w naszej informacji prawnej.</p> -->
            </div>

          </form>
        </div>

      </div>
    </div>

    <div class="row footer-after1 hb-animate-element bottom-to-top hb-in-viewport">
      <div class="block-social">
        <ul>
          <div class="social_block">
            <li class="facebook"><a href="https://www.facebook.com/TwojaPasmanteria/"
                 target="_blank">Facebook</a></li>
          </div>
        </ul>
      </div>
    </div>
    <div class="col-md-12 forecopyright hb-animate-element bottom-to-top hb-in-viewport">
      <p class="copyright">
        <a class="_blank"
           href="http://www.prestashop.com"
           target="_blank"
           rel="nofollow">
          © 2024 - Ecommerce software by PrestaShop™
        </a>
      </p>
    </div>
    <div class="row footer-after hb-animate-element bottom-to-top hb-in-viewport">
      <div id="tmpaymentcmsblock"
           class="tmpaymentcmsblock container">
        <div class="payment">
          <p><a href="#"> <img alt="logo.png"
                   src="/img/custom/footer/discover.png"></a></p>
          <p><a href="#"> <img alt="logo.png"
                   src="/img/custom/footer/master.png"></a></p>
          <p><a href="#"> <img alt="logo.png"
                   src="/img/custom/footer/paypal.png"></a></p>
          <p><a href="#"> <img alt="logo.png"
                   src="/img/custom/footer/visa.png"></a></p>
        </div>
      </div>
    </div>
  </div>

  <a class="top_button"
     href="#"
     style="display: inline;">&nbsp;</a>
</div>