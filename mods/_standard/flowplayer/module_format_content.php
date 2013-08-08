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
            ##DISPLAY_CAPTIONS##,
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
$transcripts_init = "
    var transcript_##DIVID## = (function() {
    var json_##DIVID## = null;
    $.ajax({
        'async': false,
        'global': false,
        'url': '".AT_BASE_HREF."get.php/".$_content_base_href."##TRANSCRIPTS##',
        'dataType': 'json',
        'success': function (data) {
        json_##DIVID## = data;
    }
    });
    return json_##DIVID##;
    })();
                               
    $.each(transcript_##DIVID##, function(key, value){
    $.each(value, function(index, element) {
        intime_##DIVID## = element.inTime.split(':');
        hh_##DIVID## = intime_##DIVID##[0];
        mm_##DIVID## = intime_##DIVID##[1];
        ss_##DIVID## = intime_##DIVID##[2];
        mss_##DIVID## = Math.round((ss_##DIVID##*10)/10)*1000;
        intime_##DIVID## = (parseInt(hh_##DIVID##)*60*60 + parseInt(mm_##DIVID##)*60)*1000 + mss_##DIVID##;
        
        item_##DIVID## = '<span rel=\"'+intime_##DIVID##+'\" >'+element.transcript+'</span>';
        $('###DIVID##_chapters > #chapters-text').append(item_##DIVID##+' ');
    });
    });      

    var cuepoints = [],seekpos = 0, // seek target when player is not loaded
    chapters = $('###DIVID##_chapters > #chapters-text span');
    i = 0;
    
    // collect cuepoints from rel attributes of chapter elements
    \$f.each(chapters, function () {
        cuepoints.push({
        time: parseInt(this.getAttribute('rel'), 10),
        index: i
    });
    i = i + 1;
    });
";
$transcripts_init_cuepoint_code = "
    onCuepoint: [
        cuepoints,
        function(clip, cuepoint) {
            $('###DIVID##_chapters > #chapters-text').children().removeClass('highlight');
            $('###DIVID##_chapters > #chapters-text').find('span[rel=\"'+cuepoint.time+'\"]').addClass('highlight');
            var item = $('###DIVID##_chapters > #chapters-text').find('span[rel=\"'+cuepoint.time+'\"]');
            var offset = item.position().top;
            var parent = item.parent();
            if (offset < 0 || offset > parent.height()) {
                if (offset < 0)
                offset = parent.scrollTop() + offset;
            parent.animate({ scrollTop: offset }, 300);
            }
        }
    ],
";
$transcripts_init_cuepoint_seeking_code = "
    \$f.each(chapters, function () {
    var pos = parseInt(this.getAttribute('rel'), 10) / 1000;
    this.onclick = function () {
        if (!player_##DIVID##.isLoaded()) {
            player_##DIVID##.play();
            seekpos = pos;
        } else {
            player_##DIVID##.seek(player_##DIVID##.isPaused() && pos === 0 ? 1 : pos);
        }
    };
    });
";
// .flv
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt\|?)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json)*\]([.\w\d]+[^\s\"]+)\.flv\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);

if (isset($_SESSION['flash']) && $_SESSION['flash'] == "yes") {
	$media_replace[] = "<div>\n".
	                   "  <div id=\"##DIVID##\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;;float:left;\" ></div>\n".
                           "  <div id='##DIVID##_chapters' class = 'chapters' style = 'height:##HEIGHT##px; display: ##DISPLAY_TRANSCRIPTS##'>
                               <div id='chapters-text' class = 'chapters-text' ></div>
                              </div>".
                           "  <script type=\"text/javascript\">
                               $(document).ready(function(){

                               ##TRANSCRIPTS_CODE##
                               
                               player_##DIVID## = \$f(\"##DIVID##\", {
                                src: '".AT_BASE_HREF."mods/_standard/flowplayer/flowplayer-3.2.16.swf',
                                SeamlessTabbing: false
                                }, {
                                onKeyPress: function(code) {
                                    switch(code) {
                                        case 70: this.toggleFullscreen();           //F key
                                        break;
                                        case 36: this.stop();this.play();           //Home key
                                        break;
                                        case 67: this.getPlugin('content').toggle();//C key
                                        break;
                                    }
                                },
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
                                ##TRANSCRIPTS_CUEPOINT_CODE##
                                ##CAPTIONS##
                                }
                                });
                                
                                ##TRANSCRIPTS_CUEPOINT_SEEKING##
                                });
                              </script>\n".
                              "<h2 class='box' style='width:200px;'>
                              <span>Shortcuts</span>
                              <a href='#' class='flowplayer_shortcuts_link' title='Show Keyboard Shortcuts' onclick = 'show_flowplayer_shortcuts(this);return false;'></a>
                              <div class='box' style='display:none;'>
                                <ul class='social_side_menu'>
                                    <li>Play/Pause: Spacebar Key</li>
                                    <li>Restart: Home Key</li>
                                    <li>Volume Up: Up Key</li>
                                    <li>Volume Down: Down Key</li>
                                    <li>Captions Toggle: C key</li>
                                    <li>Fullscreen: F key</li>
                                </ul>
                              </div>
                              </h2>\n".
	                   "</div>\n";
} else {
	$media_replace[] = "<div>\n".
	                   "  <a href=\"##MEDIA1##.flv\">##MEDIA1##.flv</a>\n".
	                   "</div>\n";
}

// .mp4
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt\|?)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json)*\]([.\w\d]+[^\s\"]+)\.mp4\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);
//$media_replace[] ="<a class=\"".$flowplayerholder_class."\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" href=\"".AT_BASE_HREF."get.php/".$_content_base_href."##MEDIA1##.mp4\"></a>";
if (isset($_SESSION['flash']) && $_SESSION['flash'] == "yes") {
	$media_replace[] = "<div>\n".
	                   "  <div id=\"##DIVID##\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;float:left;\" ></div>\n".
                           "  <div id='##DIVID##_chapters' class = 'chapters' style = 'height:##HEIGHT##px; display: ##DISPLAY_TRANSCRIPTS##'>
                               <div id='chapters-text' class = 'chapters-text' ></div>
                              </div>".
                           "  <script type=\"text/javascript\">
                               $(document).ready(function(){
                               
                               ##TRANSCRIPTS_CODE##
                               
                               player_##DIVID## = \$f(\"##DIVID##\", {
                                src: '".AT_BASE_HREF."mods/_standard/flowplayer/flowplayer-3.2.16.swf',
                                SeamlessTabbing: false
                                }, {
                                onKeyPress: function(code) {
                                    switch(code) {
                                        case 70: this.toggleFullscreen();           //F key
                                        break;
                                        case 36: this.stop();this.play();           //Home key
                                        break;
                                        case 67: this.getPlugin('content').toggle();//C key
                                        break;
                                    }
                                },
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
                                ##TRANSCRIPTS_CUEPOINT_CODE##
                                ##CAPTIONS##
                                }
                                });
                                
                                ##TRANSCRIPTS_CUEPOINT_SEEKING##
                                });
                              </script>\n".
                              "<h2 class='box' style='width:200px;'>
                              <span>Shortcuts</span>
                              <a href='#' class='flowplayer_shortcuts_link' title='Show Keyboard Shortcuts' onclick = 'show_flowplayer_shortcuts(this);return false;'></a>
                              <div class='box' style='display:none;'>
                                <ul class='social_side_menu'>
                                    <li>Play/Pause: Spacebar Key</li>
                                    <li>Restart: Home Key</li>
                                    <li>Volume Up: Up Key</li>
                                    <li>Volume Down: Down Key</li>
                                    <li>Captions Toggle: C key</li>
                                    <li>Fullscreen: F key</li>
                                </ul>
                              </div>\n
                              </h2>\n".
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
                    if($_SESSION['prefs']['PREF_USE_CAPTIONS'] == 1)
                        $media_input = str_replace("##DISPLAY_CAPTIONS##", 'display:"block"', $media_input);
                    else if($_SESSION['prefs']['PREF_USE_CAPTIONS'] == 0)
                        $media_input = str_replace("##DISPLAY_CAPTIONS##", 'display:"none"', $media_input);
                }
                else
                {
                    $media_input = str_replace("##CAPTION_CODE##", '', $media_input);
                    $media_input = str_replace("##CAPTIONS##", '', $media_input);
                }
                if((!empty($media[2])) && (preg_match("/transcripts=([.\w\d]+[^\s\"]+\.json)/", $media[2], $matches)))
                {
                    $media_input = str_replace("##TRANSCRIPTS_CODE##", $transcripts_init, $media_input);
                    $media_input = str_replace("##TRANSCRIPTS##", $matches[1], $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_CODE##", $transcripts_init_cuepoint_code, $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_SEEKING##", $transcripts_init_cuepoint_seeking_code, $media_input);
                    
                    if($_SESSION['prefs']['PREF_USE_TRANSCRIPTS'] == 1) 
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", 'block', $media_input);
                    else if($_SESSION['prefs']['PREF_USE_TRANSCRIPTS'] == 0) 
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", 'none', $media_input);
                }
                else
                {
                    $media_input = str_replace("##TRANSCRIPTS_CODE##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_CODE##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_SEEKING##", '', $media_input);
                    
                    $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", 'none', $media_input);
                }
                
                $media_input = str_replace("##DIVID##", $player_id, $media_input);
		$media_input = str_replace("##WIDTH##","$width",$media_input);
		$media_input = str_replace("##HEIGHT##","$height",$media_input);
		$media_input = str_replace("##MEDIA1##","$media[3]",$media_input);
		$media_input = str_replace("##MEDIA2##","$media[4]",$media_input);
		$_input = str_replace($media[0],$media_input,$_input);
	}
}
global $rtl;

$tree_collapse_icon = AT_BASE_HREF.find_image($rtl.'tree/tree_collapse.gif', '');
$tree_expand_icon = AT_BASE_HREF.find_image($rtl.'tree/tree_expand.gif', '');

$_input.='
    <script type="text/javascript">
    ATutor.course.collapse_icon = "'. AT_print($tree_collapse_icon, 'url.tree').'";
    ATutor.course.expand_icon = "'.AT_print($tree_expand_icon,  'url.tree').'";
        
    $(".flowplayer_shortcuts_link").html("<img src="+ATutor.course.expand_icon+" alt=\'Show Keyboard Shortcuts\' title=\'Show Keyboard Shortcuts\' class=\'shortcut_icon\' >");
    function show_flowplayer_shortcuts(id) {
    if($(id).find("img").attr("src") == ATutor.course.expand_icon) {
        $(id).find("img").attr({
            "src": ATutor.course.collapse_icon,
            "alt": "Hide Keyboard Shortcuts",
            "title": "Hide Keyboard Shortcuts"
            })
        $(id).attr("title", "Hide Keyboard Shortcuts");
    }
    else {
        $(id).find("img").attr({
            "src": ATutor.course.expand_icon,
            "alt": "Show Keyboard Shortcuts",
            "title": "Show Keyboard Shortcuts"
            })
        $(id).attr("title", "Show Keyboard Shortcuts");
    }
    ch = $(id).siblings(".box");
    ch.slideToggle();
    };
    </script>
';
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