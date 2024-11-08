<?php
/* Smarty version 3.1.48, created on 2024-11-07 12:12:01
  from '/app/prestashop/themes/classic/templates/_partials/helpers.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.48',
  'unifunc' => 'content_672ca081cfd873_09749182',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    'b937a8f07af4044221a1a67c0496e38ca5b0750f' => 
    array (
      0 => '/app/prestashop/themes/classic/templates/_partials/helpers.tpl',
      1 => 1702485415,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_672ca081cfd873_09749182 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->smarty->ext->_tplFunction->registerTplFunctions($_smarty_tpl, array (
  'renderLogo' => 
  array (
    'compiled_filepath' => '/app/prestashop/var/cache/dev/smarty/compile/classiclayouts_layout_full_width_tpl/b9/37/a8/b937a8f07af4044221a1a67c0496e38ca5b0750f_2.file.helpers.tpl.php',
    'uid' => 'b937a8f07af4044221a1a67c0496e38ca5b0750f',
    'call_name' => 'smarty_template_function_renderLogo_1829063170672ca081cf3501_36139512',
  ),
));
?> 

<?php }
/* smarty_template_function_renderLogo_1829063170672ca081cf3501_36139512 */
if (!function_exists('smarty_template_function_renderLogo_1829063170672ca081cf3501_36139512')) {
function smarty_template_function_renderLogo_1829063170672ca081cf3501_36139512(Smarty_Internal_Template $_smarty_tpl,$params) {
foreach ($params as $key => $value) {
$_smarty_tpl->tpl_vars[$key] = new Smarty_Variable($value, $_smarty_tpl->isRenderingCache);
}
?>

  <a href="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['urls']->value['pages']['index'], ENT_QUOTES, 'UTF-8');?>
">
    <img
      class="logo img-fluid"
      src="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['shop']->value['logo_details']['src'], ENT_QUOTES, 'UTF-8');?>
"
      alt="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['shop']->value['name'], ENT_QUOTES, 'UTF-8');?>
"
      width="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['shop']->value['logo_details']['width'], ENT_QUOTES, 'UTF-8');?>
"
      height="<?php echo htmlspecialchars($_smarty_tpl->tpl_vars['shop']->value['logo_details']['height'], ENT_QUOTES, 'UTF-8');?>
">
  </a>
<?php
}}
/*/ smarty_template_function_renderLogo_1829063170672ca081cf3501_36139512 */
}
