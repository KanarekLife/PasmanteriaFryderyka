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

{if $homeslider.slides}
  <div class="container">
    <div class="flexslider"
         data-interval="4000"
         data-pause="true">

      <div class="loadingdiv"></div>
      <ul class="slides">
        <li class="slide flex-active-slide"
            style="width: 100%; float: left; margin-right: -100%; position: relative; opacity: 1; display: block; z-index: 2;">
          <a href="/szukaj?controller=search&s=gazzal+exclusive"
             title="">
            <img src="/img/custom/slider/gazzal_exclusive.jpg"
                 alt="ff52ee19ce63a010545b8df15f110fc1112c5669-exclusive 2"
                 title="exclusive"
                 draggable="false">
          </a>

        </li>
      </ul>
      <ol class="flex-control-nav flex-control-paging"></ol>
      <ul class="flex-direction-nav">
        <li class="flex-nav-prev"><a class="flex-prev flex-disabled"
             href="#"
             tabindex="-1">Previous</a></li>
        <li class="flex-nav-next"><a class="flex-next flex-disabled"
             href="#"
             tabindex="-1">Next</a></li>
      </ul>
    </div>


    <div id="tmsubbanner"
         class="hb-animate-element left-to-right hb-in-viewport">
      <ul>
        <li class="slide tmsubbanner-container">
          <a href="/search?controller=search&s=paper+yarn"
             title="paper yarn">
            <img src="/img/custom/slider/paper_yarn.jpg"
                 alt="paper yarn"
                 title="paper yarn">
          </a>
        </li>
        <li class="slide tmsubbanner-container">
          <a href="/szukaj?controller=search&s=baby+cotton"
             title="baby cotton">
            <img src="/img/custom/slider/baby_cotton.jpg"
                 alt="baby cotton"
                 title="baby cotton">
          </a>
        </li>
      </ul>
    </div>
    <div id="tmcmsblock">
      <div class="container">
        <div id="tmcmsbannerblock">
          <div class="container">
            <div class="cmsbanner">
              <div class="left_side hb-animate-element top-to-bottom hb-in-viewport">
                <div class="left_sub_image"><a
                     href="/search?controller=search&s=punch"> <img
                         src="/img/custom/slider/punch.jpg"
                         alt="bawełenka"
                         width="590"
                         height="253"></a>
                  <div class="bannercms-content1 full-banner">
                    <div class="banner-subtext"><a
                         href="/search?controller=search&s=punch">zobacz...</a></div>
                    <div class="banner-text1"><a
                         href="/search?controller=search&s=punch"><span
                              class="banner-subtext2">PUNCH&nbsp;&nbsp;</span></a></div>
                    <a href="/search?controller=search&s=punch">ETROFIL&nbsp;</a>
                  </div>
                </div>
              </div>
              <div class="right_side hb-animate-element bottom-to-top hb-in-viewport">
                <div class="right_top_image"><a href="/search?controller=search&s=teddy"> <img
                         src="/img/custom/slider/teddy.jpg"
                         alt="teddy"
                         width="590"
                         height="253"></a>
                  <div class="bannercms-content2 full-banner">
                    <div class="banner-subtext"><a
                         href="/search?controller=search&s=teddy">zobacz...</a></div>
                    <div class="banner-text1"><a
                         href="/search?controller=search&s=teddy">NOWOŚĆ&nbsp;TEDDY</a></div>
                    <a href="/search?controller=search&s=teddy">GAZZAL</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
{/if}

{*  
{if $homeslider.slides}
  <div id="carousel" data-ride="carousel" class="carousel slide" data-interval="{$homeslider.speed}" data-wrap="{(string)$homeslider.wrap}" data-pause="{$homeslider.pause}" data-touch="true">
    <ol class="carousel-indicators">
      {foreach from=$homeslider.slides item=slide key=idxSlide name='homeslider'}
      <li data-target="#carousel" data-slide-to="{$idxSlide}"{if $idxSlide == 0} class="active"{/if}></li>
      {/foreach}
    </ol>
    <ul class="carousel-inner" role="listbox" aria-label="{l s='Carousel container' d='Shop.Theme.Global'}">
      {foreach from=$homeslider.slides item=slide name='homeslider'}
        <li class="carousel-item {if $smarty.foreach.homeslider.first}active{/if}" role="option" aria-hidden="{if $smarty.foreach.homeslider.first}false{else}true{/if}">
          <a href="{$slide.url}">
            <figure>
              <img src="{$slide.image_url}" alt="{$slide.legend|escape}" loading="lazy" width="1110" height="340">
              {if $slide.title || $slide.description}
                <figcaption class="caption">
                  <h2 class="display-1 text-uppercase">{$slide.title}</h2>
                  <div class="caption-description">{$slide.description nofilter}</div>
                </figcaption>
              {/if}
            </figure>
          </a>
        </li>
      {/foreach}
    </ul>
    <div class="direction" aria-label="{l s='Carousel buttons' d='Shop.Theme.Global'}">
      <a class="left carousel-control" href="#carousel" role="button" data-slide="prev" aria-label="{l s='Previous' d='Shop.Theme.Global'}">
        <span class="icon-prev hidden-xs" aria-hidden="true">
          <i class="material-icons">&#xE5CB;</i>
        </span>
      </a>
      <a class="right carousel-control" href="#carousel" role="button" data-slide="next" aria-label="{l s='Next' d='Shop.Theme.Global'}">
        <span class="icon-next" aria-hidden="true">
          <i class="material-icons">&#xE5CC;</i>
        </span>
      </a>
    </div>
  </div>
{/if} *}