<?php
/************************************************************************/
/* ATutor																*/
/************************************************************************/
/* Copyright (c) 2002-2005 by Greg Gay, Joel Kronenberg & Heidi Hazelton*/
/* Adaptive Technology Resource Centre / University of Toronto			*/
/* http://atutor.ca														*/
/*																		*/
/* This program is free software. You can redistribute it and/or		*/
/* modify it under the terms of the GNU General Public License			*/
/* as published by the Free Software Foundation.						*/
/************************************************************************/
// $Id: 

define('AT_INCLUDE_PATH', '../../include/');
require(AT_INCLUDE_PATH.'vitals.inc.php')
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd" />
<html lang="<?php echo $myLang->getCode(); ?>">
<head>
	<title><?php echo _AT('file_manager_frame'); ?></title>
	<meta http-equiv="Content-Type" content="text/html; <?php echo $myLang->getCharacterSet(); ?>" />
</head>


<frameset rows="50,*">

<frame src="preview_top.php?file=<?php echo urlencode($_GET['file']).SEP; ?>pathext=<?php echo urlencode($_GET['pathext']); ?>" scrolling=no marginwidth=0 marginheight=0 />
<frame src="../../get.php/<?php echo urldecode($_GET['file']); ?>" />

<noframes>
  <p><?php echo _AT('frame_contains'); ?><br />
  * <a href="tools/file_manager.php"><?php echo _AT('file_manager'); ?></a>
  </p>
</noframes>

</frameset>
</html>