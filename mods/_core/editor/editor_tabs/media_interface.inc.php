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

//gets list of all languages
function get_lang_options($counter, $lang)
{
    $languageCodes = array(
        "aa" => "Afar",
        "ab" => "Abkhazian",
        "ae" => "Avestan",
        "af" => "Afrikaans",
        "ak" => "Akan",
        "am" => "Amharic",
        "an" => "Aragonese",
        "ar" => "Arabic",
        "as" => "Assamese",
        "av" => "Avaric",
        "ay" => "Aymara",
        "az" => "Azerbaijani",
        "ba" => "Bashkir",
        "be" => "Belarusian",
        "bg" => "Bulgarian",
        "bh" => "Bihari",
        "bi" => "Bislama",
        "bm" => "Bambara",
        "bn" => "Bengali",
        "bo" => "Tibetan",
        "br" => "Breton",
        "bs" => "Bosnian",
        "ca" => "Catalan",
        "ce" => "Chechen",
        "ch" => "Chamorro",
        "co" => "Corsican",
        "cr" => "Cree",
        "cs" => "Czech",
        "cu" => "Church Slavic",
        "cv" => "Chuvash",
        "cy" => "Welsh",
        "da" => "Danish",
        "de" => "German",
        "dv" => "Divehi",
        "dz" => "Dzongkha",
        "ee" => "Ewe",
        "el" => "Greek",
        "en" => "English",
        "eo" => "Esperanto",
        "es" => "Spanish",
        "et" => "Estonian",
        "eu" => "Basque",
        "fa" => "Persian",
        "ff" => "Fulah",
        "fi" => "Finnish",
        "fj" => "Fijian",
        "fo" => "Faroese",
        "fr" => "French",
        "fy" => "Western Frisian",
        "ga" => "Irish",
        "gd" => "Scottish Gaelic",
        "gl" => "Galician",
        "gn" => "Guarani",
        "gu" => "Gujarati",
        "gv" => "Manx",
        "ha" => "Hausa",
        "he" => "Hebrew",
        "hi" => "Hindi",
        "ho" => "Hiri Motu",
        "hr" => "Croatian",
        "ht" => "Haitian",
        "hu" => "Hungarian",
        "hy" => "Armenian",
        "hz" => "Herero",
        "ia" => "Interlingua",
        "id" => "Indonesian",
        "ie" => "Interlingue",
        "ig" => "Igbo",
        "ii" => "Sichuan Yi",
        "ik" => "Inupiaq",
        "io" => "Ido",
        "is" => "Icelandic",
        "it" => "Italian",
        "iu" => "Inuktitut",
        "ja" => "Japanese",
        "jv" => "Javanese",
        "ka" => "Georgian",
        "kg" => "Kongo",
        "ki" => "Kikuyu",
        "kj" => "Kwanyama",
        "kk" => "Kazakh",
        "kl" => "Kalaallisut",
        "km" => "Khmer",
        "kn" => "Kannada",
        "ko" => "Korean",
        "kr" => "Kanuri",
        "ks" => "Kashmiri",
        "ku" => "Kurdish",
        "kv" => "Komi",
        "kw" => "Cornish",
        "ky" => "Kirghiz",
        "la" => "Latin",
        "lb" => "Luxembourgish",
        "lg" => "Ganda",
        "li" => "Limburgish",
        "ln" => "Lingala",
        "lo" => "Lao",
        "lt" => "Lithuanian",
        "lu" => "Luba-Katanga",
        "lv" => "Latvian",
        "mg" => "Malagasy",
        "mh" => "Marshallese",
        "mi" => "Maori",
        "mk" => "Macedonian",
        "ml" => "Malayalam",
        "mn" => "Mongolian",
        "mr" => "Marathi",
        "ms" => "Malay",
        "mt" => "Maltese",
        "my" => "Burmese",
        "na" => "Nauru",
        "nb" => "Norwegian Bokmal",
        "nd" => "North Ndebele",
        "ne" => "Nepali",
        "ng" => "Ndonga",
        "nl" => "Dutch",
        "nn" => "Norwegian Nynorsk",
        "no" => "Norwegian",
        "nr" => "South Ndebele",
        "nv" => "Navajo",
        "ny" => "Chichewa",
        "oc" => "Occitan",
        "oj" => "Ojibwa",
        "om" => "Oromo",
        "or" => "Oriya",
        "os" => "Ossetian",
        "pa" => "Panjabi",
        "pi" => "Pali",
        "pl" => "Polish",
        "ps" => "Pashto",
        "pt" => "Portuguese",
        "qu" => "Quechua",
        "rm" => "Raeto-Romance",
        "rn" => "Kirundi",
        "ro" => "Romanian",
        "ru" => "Russian",
        "rw" => "Kinyarwanda",
        "sa" => "Sanskrit",
        "sc" => "Sardinian",
        "sd" => "Sindhi",
        "se" => "Northern Sami",
        "sg" => "Sango",
        "si" => "Sinhala",
        "sk" => "Slovak",
        "sl" => "Slovenian",
        "sm" => "Samoan",
        "sn" => "Shona",
        "so" => "Somali",
        "sq" => "Albanian",
        "sr" => "Serbian",
        "ss" => "Swati",
        "st" => "Southern Sotho",
        "su" => "Sundanese",
        "sv" => "Swedish",
        "sw" => "Swahili",
        "ta" => "Tamil",
        "te" => "Telugu",
        "tg" => "Tajik",
        "th" => "Thai",
        "ti" => "Tigrinya",
        "tk" => "Turkmen",
        "tl" => "Tagalog",
        "tn" => "Tswana",
        "to" => "Tonga",
        "tr" => "Turkish",
        "ts" => "Tsonga",
        "tt" => "Tatar",
        "tw" => "Twi",
        "ty" => "Tahitian",
        "ug" => "Uighur",
        "uk" => "Ukrainian",
        "ur" => "Urdu",
        "uz" => "Uzbek",
        "ve" => "Venda",
        "vi" => "Vietnamese",
        "vo" => "Volapuk",
        "wa" => "Walloon",
        "wo" => "Wolof",
        "xh" => "Xhosa",
        "yi" => "Yiddish",
        "yo" => "Yoruba",
        "za" => "Zhuang",
        "zh" => "Chinese",
        "zu" => "Zulu"
    );
    //populates the list of all languages
    $select = "<select id='media_interface_".$counter."'>";
    $selected= "";
    foreach($languageCodes as $language=>$value)
    {
        if($language==$lang)
            $selected='selected';
        else
            $selected='';
        $select.="<option name='".$language."' ". $selected ." >". $value ."</option>";
    }
    $select.= "</select><br/>";
    return $select;
}
?>

<div class="row">
<?php
//check if there are no media tags present
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
//generate media interface options(width,height,captions,transcripts,media-source) for each media tag
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
        if(substr($media_matches[$j][$i], -1, 1)== '|')
            $media_matches[$j][$i] = substr($media_matches[$j][$i], 0, -1);
        
        switch($k) {
            case 0: echo "<div id='media_tag_".$i."'>".$media_matches[$j][$i]."</div>";
                break;
            case 1: 
                if(empty($media_matches[$j][$i]))
                    echo '<input type="text" id="media_interface_'.$id_counter++.'" />x<input type="text" id="media_interface_'.$id_counter++.'" />';
                else
                    echo '<input type="text" id="media_interface_'.$id_counter++.'" value="'.$width.'" />x<input type="text" id="media_interface_'.$id_counter++.'" value="'.$height.'" />';
                break;
            case 3:
                $transcripts_lang = explode('|',$media_matches[$j][$i]);
                if(empty($transcripts_lang))
                    echo '<input type="text" id="media_interface_'.$id_counter++.'" />x<input type="text" id="media_interface_'.$id_counter++.'" />';
                else
                {
                    foreach($transcripts_lang as $transcript)
                    {
                        $file_lang = explode(':', $transcript);
                        $transcript_file = $file_lang[0];
                        $transcript_lang = $file_lang[1];
                        if($transcript_lang=='')
                            $transcript_lang="en";
                        echo '<input type="text" id="media_interface_'.$id_counter.'" value="'.$transcript_file.'"/>&nbsp;<input type="button" onclick="launchFileManager('.$id_counter++.');" value="Change" />&nbsp;'. get_lang_options($id_counter++, $transcript_lang);
                    }
                }
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
    //launch file manager to insert/change any options
    var launchFileManager = function (media_id) {
        window.open(ATutor.base_href + 'mods/_core/file_manager/index.php?framed=1&popup=1&cp=' + ATutor.mods.editor.content_path+'&miface='+ media_id, 'newWin1', 'menubar=0,scrollbars=1,resizable=1,width=640,height=490');
        return false;
    };
    //constructs media tag using the newly specified options
    var construct_new_media_tag = function(start_id, end_id) {
        newhtml = '[media';
        new_width = $('#media_interface_'+ start_id).val();
        new_height = $('#media_interface_'+ (start_id+1)).val();
        new_captions = $('#media_interface_'+ (start_id+2)).val();
        new_transcripts = $('#media_interface_'+ (start_id+3)).val();
        if(new_transcripts)
        new_transcripts += ":"+$('#media_interface_'+ (start_id+4)+ ' option:selected').attr('name');
        id_counter=start_id+5;
        //loop for multiple transcripts
        while(id_counter < end_id)
        {
            name = $('#media_interface_'+ (id_counter)).val();
            val = $('#media_interface_'+ (id_counter+1) + ' option:selected').attr('name');
            if(name && val)
                new_transcripts+= "|" + name + ":" + val;
            id_counter+=2;
        }
        
        if(new_transcripts.charAt(0)=='|')
            new_transcripts = new_transcripts.substr(1);
        new_source = $('#media_interface_'+ (id_counter)).val();
        
        if( !new_width && !new_height && !new_captions && !new_transcripts && new_source)                 //all except source field empty -- [media]src[/media]
            newhtml = newhtml+ ']'+ new_source + '[/media]';
        else if( new_width && new_height && !new_captions && !new_transcripts && new_source)              //[media|width|height]src[/media]
            newhtml = newhtml+ '|' + new_width + '|' + new_height +']'+ new_source + '[/media]';
        else if ( !new_width && !new_height && !new_transcripts && new_captions && new_source)            //[media captions=captions_file]src[/media]
            newhtml = newhtml + ' captions=' +new_captions + ']' + new_source + '[/media]';
        else if ( !new_width && !new_height && !new_captions && new_transcripts && new_source)            //[media transcripts=transcpripts_file]src[/media]
            newhtml = newhtml + ' transcripts=' +new_transcripts + ']' + new_source + '[/media]';
        else if (!new_transcripts && new_width && new_height && new_captions && new_source)               //[media|width|height|captions=captions_file]src[/media]
            newhtml = newhtml + '|' + new_width + '|' + new_height +'|captions=' + new_captions + ']' + new_source + '[/media]';
        else if (!new_captions && new_width && new_height && new_transcripts && new_source)               //[media|width|height|captions=captions_file]src[/media]
            newhtml = newhtml + '|' + new_width + '|' + new_height +'|transcripts=' + new_transcripts + ']' + new_source + '[/media]';
        else if (new_height && new_width && new_captions && new_transcripts && new_source)                //[media|width|height|captions=captions_file|transcripts=transcripts_file1|transcripts_file2]src[/media]
            newhtml = newhtml + '|' + new_width + '|' + new_height +'|captions=' + new_captions + '|transcripts=' + new_transcripts + ']' + new_source + '[/media]';
        else {
            alert("There was an error detected. Please make sure that media source is not empty")
            return '##ERROR##';
        }
        
        return newhtml;
    };
    //updates media tag
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