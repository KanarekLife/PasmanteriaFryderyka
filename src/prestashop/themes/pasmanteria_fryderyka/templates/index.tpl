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
{extends file='page.tpl'}

{block name='page_content_container'}
  <section id="content"
           class="page-home">
    {block name='page_content_top'}{/block}

    {block name='page_content'}
      {block name='hook_home'}
        {$HOOK_HOME nofilter}
      {/block}
    {/block}

    <section class="brands hb-animate-element top-to-bottom container hb-in-viewport">
      <h2 class="h1 products-section-title text-uppercase">
        Marki
      </h2>
      <div class="products">
        <ul id="brand-carousel"
            class="tm-carousel product_list owl-carousel owl-theme"
            style="opacity: 1; display: block;">

          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=addi"
                   title="Addi">
                  <img src="/img/custom/index/addi.jpg"
                       alt="Addi">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=etrofil"
                   title="Etrofil">
                  <img src="/img/custom/index/etrofil.jpg"
                       alt="Etrofil">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=gazzal"
                   title="Gazzal">
                  <img src="/img/custom/index/gazzal.jpg"
                       alt="Gazzal">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=himalaya"
                   title="Himalaya">
                  <img src="/img/custom/index/himalaya.jpg"
                       alt="Himalaya">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=kartopu"
                   title="Kartopu">
                  <img src="/img/custom/index/kartopu.jpg"
                       alt="Kartopu">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=luna-art"
                   title="Luna Art ">
                  <img src="/img/custom/index/luna-art.jpg"
                       alt="Luna Art ">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=tricote"
                   title="Madame Tricote">
                  <img src="/img/custom/index/madame-tricote.jpg"
                       alt="Madame Tricote">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=pony"
                   title="PONY">
                  <img src="/img/custom/index/pony.jpg"
                       alt="PONY">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=prym"
                   title="PRYM">
                  <img src="/img/custom/index/prym.jpg"
                       alt="PRYM">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=skc"
                   title="SKC">
                  <img src="/img/custom/index/skc.jpg"
                       alt="SKC">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-item"
               style="width: 240px;">
            <li class="item">
              <div class="brand-image">
                <a href="/szukaj?controller=search&s=yarnart"
                   title="YarnArt">
                  <img src="/img/custom/index/yarnart.jpg"
                       alt="YarnArt">
                </a>
              </div>
            </li>
          </div>
          <div class="owl-controls clickable">
            <div class="owl-pagination">
              <div class="owl-page active"><span class=""></span></div>
              <div class="owl-page"><span class=""></span></div>
              <div class="owl-page"><span class=""></span></div>
            </div>
          </div>
        </ul>
      </div>
      <div class="customNavigation">
        <a class="btn prev brand_prev">&nbsp;</a>
        <a class="btn next brand_next">&nbsp;</a>
      </div>
    </section>

    <div id="tmservicecmsblock">
      <div class="servicecms container">

        <div id="tmservicecmsblock">
          <div class="servicecms container">
            <div class="footer_top_inner container">
              <div class="footerblock1 footerblock hb-animate-element left-to-right hb-in-viewport">
                <div class="image image1"></div>
                <div class="title">Darmowa dostawa</div>
                <div class="subtitle">&nbsp;powyżej 200 zł</div>
              </div>
              <div class="footerblock2 footerblock hb-animate-element bottom-to-top hb-in-viewport">
                <div class="image image2"></div>
                <div class="title">Gwarancja zwrotu pieniędzy</div>
                <div class="subtitle">do 14 dni</div>
              </div>
              <div class="footerblock3 footerblock hb-animate-element top-to-bottom hb-in-viewport">
                <div class="image image3"></div>
                <div class="title">Wsparcie telefoniczne&nbsp;</div>
                <div class="subtitle">pn - pt od 9.00-17.00&nbsp;</div>
              </div>
              <div class="footerblock4 footerblock hb-animate-element right-to-left hb-in-viewport">
                <div class="image image4"></div>
                <div class="title">Darmowy zwrot</div>
                <div class="subtitle">odstąpienie od umowy 14 dni&nbsp;</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
{/block}