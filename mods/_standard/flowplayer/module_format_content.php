<?php
// input string. DO NOT CHANGE.
global $_input, $_content_base_href;

// Output for flowplayer module.
// Note: The properly functioning of flowplayer requires flash to be installed. 
// The conversion performed by this module converts the [media] tag into flowplayer class
// only when the flash is installed, otherwise, the [media] tag is converted into a plain 
// <a> link.
$media_replace = array();
$media_matches = array();
$flowplayerholder_class = "player";  // style class used to play flowplayer medias
$flowplayerholder_def = '$f("*.'.$flowplayerholder_class.'"';   // javascript definition for atutor.flowplayerholder 
$caption_init = "
    captions: {
            url: '".AT_BASE_HREF."mods/_standard/flowplayer/flowplayer.captions-3.2.9.swf',
            // pointer to a content plugin
            captionTarget: 'content'
        },
        content: {
            url: '".AT_BASE_HREF."mods/_standard/flowplayer/flowplayer.content-3.2.8.swf',
            bottom: 25,
            width: '80%',
            height:40,
            backgroundColor: '#000000',
            backgroundGradient: 'low',
            borderRadius: 4,
            border: 0,
            style: {
                'body': {
                fontSize: '14',
                fontFamily: 'Arial',
                textAlign: 'center',
                color: '#FFFFFF'
                }
            }
        }
";
// .flv
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt)*\]([.\w\d]+[^\s\"]+)\.flv\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);

if (isset($_SESSION['flash']) && $_SESSION['flash'] == "yes") {
	$media_replace[] = "<div>\n".
	                   "  <div id=\"##DIVID##\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" ></div>\n".
                           "  <script type=\"text/javascript\">
                               \$f(\"##DIVID##\", {
                                src: '".AT_BASE_HREF."mods/_standard/flowplayer/flowplayer-3.2.16.swf',
                                SeamlessTabbing: false
                                }, {
                                plugins: {
                                controls: {
                                autoHide: false,
          
                                tooltips: {
                                    buttons: true
                                    }
                                },
                                ##CAPTION_CODE##
                                },
                                clip: {
                                url: \"##MEDIA1##.flv\",
                                scaling: 'fit',
                                autoPlay: false,
                                baseUrl: \"".AT_BASE_HREF."get.php/".$_content_base_href."\",
                                autoBuffering: true,
                                ##CAPTIONS##
                                }
                                });
                              </script>\n".
	                   "</div>\n";
} else {
	$media_replace[] = "<div>\n".
	                   "  <a href=\"##MEDIA1##.flv\">##MEDIA1##.flv</a>\n".
	                   "</div>\n";
}

// .mp4
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt)*\]([.\w\d]+[^\s\"]+)\.mp4\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);
//$media_replace[] ="<a class=\"".$flowplayerholder_class."\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" href=\"".AT_BASE_HREF."get.php/".$_content_base_href."##MEDIA1##.mp4\"></a>";
if (isset($_SESSION['flash']) && $_SESSION['flash'] == "yes") {
	$media_replace[] = "<div>\n".
	                   "  <div id=\"##DIVID##\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" ></div>\n".
                           "  <script type=\"text/javascript\">
                               \$f(\"##DIVID##\", {
                                src: '".AT_BASE_HREF."mods/_standard/flowplayer/flowplayer-3.2.16.swf',
                                SeamlessTabbing: false
                                }, {
                                plugins: {
                                controls: {
                                autoHide: false,
          
                                tooltips: {
                                    buttons: true
                                    }
                                },
                                ##CAPTION_CODE##
                                },
                                clip: {
                                url: \"##MEDIA1##.mp4\",
                                scaling: 'fit',
                                autoPlay: false,
                                baseUrl: \"".AT_BASE_HREF."get.php/".$_content_base_href."\",
                                autoBuffering: true,
                                ##CAPTIONS##
                                }
                                });
                              </script>\n".
	                   "</div>\n";
} else {
	$media_replace[] = "<div>\n".
	                   "  <a href=\"##MEDIA1##.mp4\">##MEDIA1##.mp4</a>\n".
	                   "</div>\n";
}

//// .mov
//preg_match_all("#\[media[0-9a-z\|]*\]([.\w\d]+[^\s\"]+)\.mov\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);
//$media_replace[] ="<a class=\"".$flowplayerholder_class."\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" href=\"".AT_BASE_HREF."get.php/".$_content_base_href."##MEDIA1##.mov\"></a>";
////$media_replace[] ="<a class=\"".$flowplayerholder_class."\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" href=\"".AT_BASE_HREF."get.php/".$_content_base_href."##MEDIA1##.mov\"></a>";

//// .mp3
//preg_match_all("#\[media[0-9a-z\|]*\](.+[^\s\"]+)\.mp3\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);
//$media_replace[] ="<a class=\"".$flowplayerholder_class."\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" href=\"".AT_BASE_HREF."get.php/".$_content_base_href."##MEDIA1##.mp3\"></a>";

// Executing the replace
$holder_counter = 0;
for ($i=0;$i<count($media_replace);$i++){
	foreach($media_matches[$i] as $media)
	{
                $player_id = $flowplayerholder_class.$holder_counter++;
		//find width and height for each matched media
		if (preg_match("/\[media\|([0-9]*)\|([0-9]*)\]*/", $media[0], $matches)) 
		{
			$width = $matches[1];
			$height = $matches[2];
		}
		else
		{
			$width = DEFAULT_VIDEO_PLAYER_WIDTH;
			$height = DEFAULT_VIDEO_PLAYER_HEIGHT;
		}
		
		//replace media tags with embedded media for each media tag
		$media_input = $media_replace[$i];
                
                if((!empty($media[1])) && (preg_match("/captions=([.\w\d]+[^\s\"]+\.srt)/", $media[1], $matches)))
                {
                    $media_input = str_replace("##CAPTION_CODE##", $caption_init, $media_input);
                    $media_input = str_replace("##CAPTIONS##", 'captionUrl:"'.$matches[1].'"', $media_input);
                }
                else
                {
                    $media_input = str_replace("##CAPTION_CODE##", '', $media_input);
                    $media_input = str_replace("##CAPTIONS##", '', $media_input);
                }
                
                $media_input = str_replace("##DIVID##", $player_id, $media_input);
		$media_input = str_replace("##WIDTH##","$width",$media_input);
		$media_input = str_replace("##HEIGHT##","$height",$media_input);
		$media_input = str_replace("##MEDIA1##","$media[2]",$media_input);
		$media_input = str_replace("##MEDIA2##","$media[3]",$media_input);
		$_input = str_replace($media[0],$media_input,$_input);
	}
}

// Include the javascript only if:
// 1. $flowplayerholder_class is used but not defined
// 2. exclude from export common cartridge or content package
/*if (strpos($_input, $flowplayerholder_class) 
    && !strpos($_input, $flowplayerholder_def)
    && !strpos($_SERVER['PHP_SELF'], "ims_export.php"))
{
	$_input .= '<script type="text/javascript">
'.$flowplayerholder_def.', "'.AT_BASE_HREF.'mods/_standard/flowplayer/flowplayer-3.2.4.swf", { 
  clip: { 
  autoPlay: false,
  baseUrl: \''.AT_BASE_HREF.'get.php/'.$_content_base_href.'\'},
  plugins:  { 
    controls: { 
      buttons:true, 
      play: true,  
      scrubber: true, 
      autoHide:false
    }         
  }
});
</script>'."\n";
}*/
?>