<?php
/*******
 * doesn't allow this file to be loaded with a browser.
 */
if (!defined('AT_INCLUDE_PATH')) { exit; }

/******
 * this file must only be included within a Module obj
 */
if (!isset($this) || (isset($this) && (strtolower(get_class($this)) != 'module'))) { exit(__FILE__ . ' is not a Module'); }

/*******
 * assign the instructor and admin privileges to the constants.
 */
define('AT_ADMIN_PRIV_FLUIDPLAYER', $this->getAdminPrivilege());

$AT_BASE_HREF = AT_print(AT_BASE_HREF,'url.base');

global $_custom_head;
global $_custom_css;
global $_base_path;

$_custom_head .='
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/framework/fss/css/fss-layout.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/framework/fss/css/fss-text.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/components/uiOptions/css/fss/fss-theme-bw-uio.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/components/uiOptions/css/fss/fss-theme-wb-uio.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/components/uiOptions/css/fss/fss-theme-by-uio.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/components/uiOptions/css/fss/fss-theme-yb-uio.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/components/uiOptions/css/fss/fss-text-uio.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/components/uiOptions/css/FatPanelUIOptions.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/jquery-ui/css/ui-lightness/jquery-ui-1.8.14.custom.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/css/VideoPlayer.css" />
        <link rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/captionator/css/captions.css" />
        <!--[if lt IE 9]>
            <link  rel="stylesheet" type="text/css" href="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/css/ltie9.css" />
        <![endif]-->';
$_custom_head .='
        <!-- Fluid and jQuery Dependencies -->
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/infusion/MyInfusion.js"></script>
        <script language="javascript" type="text/javascript">
	//<!--
	jQuery.noConflict();
	//-->
	</script>
        <!-- Utils -->
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/jquery-ui/js/jquery.ui.button.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/captionator/js/captionator.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/mediaelement/js/mediaelement.js"></script>
        <!--[if lt IE 9]>
            <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/lib/html5shiv/js/html5shiv.js"></script>
        <![endif]-->
        <!-- VideoPlayer dependencies -->
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_framework.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_showHide.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_html5Captionator.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_controllers.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/ToggleButton.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/MenuButton.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_media.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_transcript.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_intervalEventsConductor.js"></script>
        <script type="text/javascript" src="'.$AT_BASE_HREF.'mods/_standard/fluidplayer/js/VideoPlayer_uiOptions.js"></script>'.
    "\n";

?>