<?php
/****************************************************************/
/* ATutor														*/
/****************************************************************/
/* Copyright (c) 2002-2010                                      */
/* Inclusive Design Institute                                   */
/* http://atutor.ca												*/
/*                                                              */
/* This program is free software. You can redistribute it and/or*/
/* modify it under the terms of the GNU General Public License  */
/* as published by the Free Software Foundation.				*/
/****************************************************************/
// $Id$

if (!defined('AT_INCLUDE_PATH')) { exit; }


?>

<div class="row">
<?php
if ($num_media_terms == 0) {
    echo _AT('no_media_tags_found');
}
?>
<?php
foreach($media_url as $media) {
echo "
<script type='text/javascript' src='http://s3.www.universalsubtitles.org/embed.js'>
({
    video_url: '".AT_BASE_HREF."get.php/".$_content_base_href.$media."'
});
</script>
";
}
?>
		
</div>