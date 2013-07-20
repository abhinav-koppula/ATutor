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
$names = array('Media Tag:', 'Width x Height:', 'Captions:', 'Transcripts:', 'Media source:');
?>
<table cellspacing="1" cellpadding="0" border="0" class="bodyline" summary="">
<?php
$id_counter = 1;

for($i = 0; $i<$num_media_terms; $i++) {
    $k=0; $start_id_counter = $id_counter;
    for($j = 0; $j<count($media_matches); $j++) {
        if($j == 1) {
            if(!empty($media_matches[$j][$i])) {
                $width_height = explode('|', $media_matches[$j][$i]);
                $width = $width_height[1];
                $height = $width_height[2];
            }
            else
            {
                $width = '';
                $height = '';
            }
        }
        if($j==2 || $j==4) continue;
    ?>
    <tr>
        <td align="left" class="row1"><strong><?php echo $names[$k]?></strong></td>
        <td align="left" class="row1">
        <?php
        if(substr($media_matches[$j][$k], -1, 1)== '|')
            $media_matches[$j][$k] = substr($media_matches[$j][$k], 0, -1);
        
        switch($k) {
            case 0: echo "<div id='media_tag_".$i."'>".$media_matches[$j][$i]."</div>";
                break;
            case 1: 
                if(empty($media_matches[$j][$k]))
                    echo '<input type="text" id="media_interface_'.$id_counter++.'" />x<input type="text" id="media_interface_'.$id_counter++.'" />';
                else
                    echo '<input type="text" id="media_interface_'.$id_counter++.'" value="'.$width.'" />x<input type="text" id="media_interface_'.$id_counter++.'" value="'.$height.'" />';
                break;
            default:
                if(empty($media_matches[$j][$i])) {
                    echo '<input type="text" id="media_interface_'.$id_counter.'"/>&nbsp;<input type="button" onclick="launchFileManager('.$id_counter++.');" value="Insert" />';
                }
                else {
                    echo '<input type="text" id="media_interface_'.$id_counter.'" value="'.$media_matches[$j][$i].'"/>&nbsp;<input type="button" onclick="launchFileManager('.$id_counter++.');" value="Change" />';
                }
                break;
        }
        $k++;
        ?>
        </td>
    </tr>
    <?php
    }
    $end_id_counter = $id_counter-1;
    ?>
    <tr>
        <td>
            <input type="button" value="Update" id="update_btn_<?php echo $i;?>" onclick="update_media_tags(<?php echo $i;?>,<?php echo $start_id_counter;?>,<?php echo $end_id_counter;?>)"/>
            <img src="<?php echo AT_BASE_HREF.'images/check.gif';?>" id="update_image_<?php echo $i;?>" style="display:none;" />
        </td>
    </tr>
    <tr><td>&nbsp;</td></tr>
    <?php
}
?>
</table>
    <script type="text/javascript">
    ATutor = ATutor || {};
    ATutor.mods = ATutor.mods || {};
    ATutor.mods.editor = ATutor.mods.editor || {};
    ATutor.mods.editor.content_path = "<?php if(isset($content_row['content_path'])) echo $content_row['content_path'] ?>";
    var launchFileManager = function (media_id) {
        window.open(ATutor.base_href + 'mods/_core/file_manager/index.php?framed=1&popup=1&cp=' + ATutor.mods.editor.content_path+'&miface='+ media_id, 'newWin1', 'menubar=0,scrollbars=1,resizable=1,width=640,height=490');
        return false;
    };
    var construct_new_media_tag = function(start_id, end_id) {
        newhtml = '[media';
        new_width = $('#media_interface_'+ start_id).val();
        new_height = $('#media_interface_'+ (start_id+1)).val();
        new_captions = $('#media_interface_'+ (start_id+2)).val();
        new_transcripts = $('#media_interface_'+ (start_id+3)).val();
        new_source = $('#media_interface_'+ (start_id+4)).val();
        
        if( !new_width && !new_height && !new_captions && !new_transcripts && new_source) //all except source field empty -- [media]src[/media]
            newhtml = newhtml+ ']'+ new_source + '[/media]';
        else if ( !new_width && !new_height && !new_transcripts && new_captions && new_source)            //[media captions=captions_file]src[/media]
            newhtml = newhtml + ' captions=' +new_captions + ']' + new_source + '[/media]';
        else if ( !new_width && !new_height && !new_captions && new_transcripts && new_source)            //[media transcripts=transcpripts_file]src[/media]
            newhtml = newhtml + ' transcripts=' +new_transcripts + ']' + new_source + '[/media]';
        else if (!new_transcripts && new_width && new_height && new_captions && new_source)               //[media|width|height|captions=captions_file]src[/media]
            newhtml = newhtml + '|' + new_width + '|' + new_height +'|captions=' + new_captions + ']' + new_source + '[/media]';
        else if (!new_captions && new_width && new_height && new_transcripts && new_source)               //[media|width|height|captions=captions_file]src[/media]
            newhtml = newhtml + '|' + new_width + '|' + new_height +'|transcripts=' + new_transcripts + ']' + new_source + '[/media]';
        else if (new_height && new_width && new_captions && new_transcripts && new_source)
            newhtml = newhtml + '|' + new_width + '|' + new_height +'|captions=' + new_captions + '|transcripts=' + new_transcripts + ']' + new_source + '[/media]';
        else {
            alert("There was an error detected. Please make sure that media source is not empty")
            return '##ERROR##';
        }
        
        return newhtml;
    };
    var update_media_tags = function (media_tag_id, start_id, end_id) {
        var old_media_tag = $('#media_tag_'+media_tag_id).html();

        newhtml='';
        newhtml = construct_new_media_tag(start_id, end_id);
        
        if(newhtml != '##ERROR##') {
            old_text = document.form.body_text.value;
            index = (old_text.lastIndexOf(old_media_tag));

            new_text = old_text.substring(0, index)+ newhtml + old_text.substring(index+old_media_tag.length);
        
            document.form.body_text.value = new_text;
            $('#media_tag_'+media_tag_id).html(newhtml);
            $('#update_image_'+media_tag_id).fadeIn().fadeOut(4000);
        }
    };

    </script>
    
    
</div>