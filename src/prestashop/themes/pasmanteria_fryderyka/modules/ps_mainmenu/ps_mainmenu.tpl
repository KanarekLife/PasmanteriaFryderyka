{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
    {if $nodes|count}
      <ul class="menu-dropdown cat-drop-menu" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">
        {foreach from=$nodes item=node}
            <li class="{$node.type}{if $node.current} current {/if} level-{$node.depth} {if $node.children}wbCart parent{/if}" id="{$node.page_identifier}">
            {assign var=_counter value=$_counter+1}
              <a
                class=""
                href="{$node.url}" data-depth="{$depth}"
                {if $node.open_in_new_window} target="_blank" {/if}
              >
                {if $node.children|count}
                  {* Cannot use page identifier as we can have the same page several times *}
                  {assign var=_expand_id value=10|mt_rand:100000}
                  <span class="float-xs-right hidden-md-up">
                    <span data-target="#top_sub_menu_{$_expand_id}" data-toggle="collapse" class="navbar-toggler collapse-icons">
                      <i class="material-icons add">&#xE313;</i>
                      <i class="material-icons remove">&#xE316;</i>
                    </span>
                  </span>
                {/if}
                {$node.label}
              </a>
              {if $node.children|count}
                {menu nodes=$node.children depth=$node.depth parent=$node}
              {/if}
            </li>
        {/foreach}
      </ul>
    {/if}
{/function}

{function name="top_menu" nodes=[] depth=0 parent=null}
  <ul class="menu-content top-menu" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">
    {foreach from=$nodes item=node}
        <li class="{$node.type}{if $node.current} current {/if} level-{$node.depth} {if $node.children}wbCart parent{/if}" id="{$node.page_identifier}">
        {assign var=_counter value=$_counter+1}
          <a
            class=""
            href="{$node.url}" data-depth="{$depth}"
            {if $node.open_in_new_window} target="_blank" {/if}
          >
            {if $node.children|count}
              {* Cannot use page identifier as we can have the same page several times *}
              {assign var=_expand_id value=10|mt_rand:100000}
              <span class="float-xs-right hidden-md-up">
                <span data-target="#top_sub_menu_{$_expand_id}" data-toggle="collapse" class="navbar-toggler collapse-icons">
                  <i class="material-icons add">&#xE313;</i>
                  <i class="material-icons remove">&#xE316;</i>
                </span>
              </span>
            {/if}
            {$node.label}
          </a>
          {if $node.children|count}
            {menu nodes=$node.children depth=$node.depth parent=$node}
          {/if}
        </li>
    {/foreach}
  </ul>
{/function}

{top_menu nodes=$menu.children}

