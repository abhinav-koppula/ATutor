<?php
// input string. DO NOT CHANGE.
global $_input, $_content_base_href;
$AT_BASE_HREF = AT_print(AT_BASE_HREF,'url.base');
$media_replace = array();
$media_matches = array();
$fluidplayerholder_class = "player";
$caption_init_flowplayer = ",
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
$caption_init = ",
    captions: [
    {
        src: '".AT_BASE_HREF."get.php/".$_content_base_href."##CAPTIONS##',
        type: 'text/vtt',
        srclang: 'en',
        label: 'English'
    }
    ]
    ";
$transcripts_init = ",
    transcripts: [
                        {
                            src: '".AT_BASE_HREF."get.php/".$_content_base_href."##TRANSCRIPTS##',
                            type: 'JSONcc',
                            srclang: 'en',
                            label: 'English'
                        }
                  ]
    ";                         
$transcripts_init_flowplayer = "
    var transcript_##DIVCLASS## = (function() {
    var json_##DIVCLASS## = null;
    $.ajax({
        'async': false,
        'global': false,
        'url': '".AT_BASE_HREF."get.php/".$_content_base_href."##TRANSCRIPTS##',
        'dataType': 'json',
        'success': function (data) {
        json_##DIVCLASS## = data;
    }
    });
    return json_##DIVCLASS##;
    })();
                               
    $.each(transcript_##DIVCLASS##, function(key, value){
    $.each(value, function(index, element) {
        intime_##DIVCLASS## = element.inTime.split(':');
        hh_##DIVCLASS## = intime_##DIVCLASS##[0];
        mm_##DIVCLASS## = intime_##DIVCLASS##[1];
        ss_##DIVCLASS## = intime_##DIVCLASS##[2];
        mss_##DIVCLASS## = Math.round((ss_##DIVCLASS##*10)/10)*1000;
        intime_##DIVCLASS## = (parseInt(hh_##DIVCLASS##)*60*60 + parseInt(mm_##DIVCLASS##)*60)*1000 + mss_##DIVCLASS##;
        
        item_##DIVCLASS## = '<span rel=\"'+intime_##DIVCLASS##+'\" >'+element.transcript+'</span>';
        $('###DIVCLASS##_chapters > #chapters-text').append(item_##DIVCLASS##+' ');
    });
    });      

    var cuepoints = [],seekpos = 0, // seek target when player is not loaded
    chapters = $('###DIVCLASS##_chapters > #chapters-text span');
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
$transcripts_init_cuepoint_code_flowplayer = "
    onCuepoint: [
        cuepoints,
        function(clip, cuepoint) {
            $('###DIVCLASS##_chapters > #chapters-text').children().removeClass('highlight');
            $('###DIVCLASS##_chapters > #chapters-text').find('span[rel=\"'+cuepoint.time+'\"]').addClass('highlight');
            var item = $('###DIVCLASS##_chapters > #chapters-text').find('span[rel=\"'+cuepoint.time+'\"]');
            var offset = item.position().top;
            var parent = item.parent();
            var pos = parent.scrollTop();
            
            parent.animate({scrollTop: pos+offset},1000);
        }
    ],
";
$transcripts_init_cuepoint_seeking_code_flowplayer = "
    \$f.each(chapters, function () {
    var pos = parseInt(this.getAttribute('rel'), 10) / 1000;
    var rel = pos*1000;
    
    this.onclick = function () {
        if (!player_##DIVCLASS##.isLoaded()) {
            player_##DIVCLASS##.play();
            seekpos = pos;
        } else {
            player_##DIVCLASS##.seek(player_##DIVCLASS##.isPaused() && pos === 0 ? 1 : pos);
        }
        $(this).siblings().removeClass('highlight');
        $(this).addClass('highlight');        
    };
    });
";
// .mp4
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.vtt\|?)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json)*\]([.\w\d]+[^\s\"]+)\.mp4\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);
$media_replace[] = "<div>\n".
                   
                   "    <div class='##DIVCLASS## fl-videoPlayer' style='height:##HEIGHT##px;'></div>\n".
                   "    <script type='text/javascript'>
                        $(document).ready(function() {
                            fluid_1_5.videoPlayer('.##DIVCLASS##',  {
                            videoTitle: 'Mammals',
                            video: {
                                sources: [
                                {
                                    src: '".AT_BASE_HREF."get.php/".$_content_base_href."##MEDIA1##.mp4',
                                    type: 'video/mp4'
                                }
                                ]
                                ##CAPTION_CODE##
                                ##TRANSCRIPTS_CODE##
                            },
                            model: {
                                currentTracks: {
                                    captions: [0],
                                    transcripts: [0]
                                }
                                ##DISPLAY_CAPTIONS##
                                ##DISPLAY_TRANSCRIPTS##
                            },
                            templates: { 
                                videoPlayer: { 
                                    href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/videoPlayer_template.html' 
                                }, 
                                menuButton: { 
                                    href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/menuButton_template.html' 
                                } 
                            } 
                            });
                             fluid_1_5.demands('fluid.videoPlayer.controllers', 'fluid.videoPlayer', { 
                                options: { 
                                    templates: { 
                                        controllers: { 
                                            href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/videoPlayer_controllers_template.html'
                                        } 
                                    } 
                                } 
                            }); 
                        });
                        </script>\n".
                        "<h2 class='box' style='width:200px;'>
                              <span>Shortcuts</span>
                              <a href='#' class='flowplayer_shortcuts_link' title='Show Keyboard Shortcuts' onclick = 'show_flowplayer_shortcuts(this);return false;'></a>
                              <div class='box' style='display:none;'>
                                <ul class='social_side_menu'>
                                    <li>Play/Pause: Spacebar Key</li>
                                    <li>Forward/Backward: Shift + Left/Right Key</li>
                                    <li>Volume Up: Shift + Up Key</li>
                                    <li>Volume Down: Shift + Down Key</li>
                                    <li>Transcripts Toggle: Shift + t key</li>
                                    <li>Fullscreen Toggle: Shift + f key</li>
                                </ul>
                              </div>
                        </h2>\n".
                   "</div>\n";

// .webm
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.vtt\|?)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json)*\]([.\w\d]+[^\s\"]+)\.webm\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);
$media_replace[] = "<div>\n".
                   
                   "    <div class='##DIVCLASS## fl-videoPlayer' style='height:##HEIGHT##px;'></div>\n".
                   "    <script type='text/javascript'>
                        $(document).ready(function() {
                            fluid_1_5.videoPlayer('.##DIVCLASS##',  {
                            videoTitle: 'Mammals',
                            video: {
                                sources: [
                                {
                                    src: '".AT_BASE_HREF."get.php/".$_content_base_href."##MEDIA1##.webm',
                                    type: 'video/webm'
                                }
                                ]
                                ##CAPTION_CODE##
                                ##TRANSCRIPTS_CODE##
                            },
                            model: {
                                currentTracks: {
                                    captions: [0],
                                    transcripts: [0]
                                }
                                ##DISPLAY_CAPTIONS##
                                ##DISPLAY_TRANSCRIPTS##
                            },
                            templates: { 
                                videoPlayer: { 
                                    href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/videoPlayer_template.html' 
                                }, 
                                menuButton: { 
                                    href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/menuButton_template.html' 
                                } 
                            } 
                            });
                             fluid_1_5.demands('fluid.videoPlayer.controllers', 'fluid.videoPlayer', { 
                                options: { 
                                    templates: { 
                                        controllers: { 
                                            href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/videoPlayer_controllers_template.html'
                                        } 
                                    } 
                                } 
                            }); 
                        });
                        </script>\n".
                        "<h2 class='box' style='width:200px;'>
                              <span>Shortcuts</span>
                              <a href='#' class='flowplayer_shortcuts_link' title='Show Keyboard Shortcuts' onclick = 'show_flowplayer_shortcuts(this);return false;'></a>
                              <div class='box' style='display:none;'>
                                <ul class='social_side_menu'>
                                    <li>Play/Pause: Spacebar Key</li>
                                    <li>Forward/Backward: Shift + Left/Right Key</li>
                                    <li>Volume Up: Shift + Up Key</li>
                                    <li>Volume Down: Shift + Down Key</li>
                                    <li>Transcripts Toggle: Shift + t key</li>
                                    <li>Fullscreen Toggle: Shift + f key</li>
                                </ul>
                              </div>
                        </h2>\n".
                   "</div>\n";

// .flv
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt\|?)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json)*\]([.\w\d]+[^\s\"]+)\.flv\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);

if (isset($_SESSION['flash']) && $_SESSION['flash'] == "yes") {
	$media_replace[] = "<div>\n".
	                   "  <div id=\"##DIVID##\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;float:left;\" ></div>\n".
                           "  <div>".
                           "<div id='##DIVID##_transcript-shortcut' class = 'transcript-shortcut' style='float:left;display: ##DISPLAY_TRANSCRIPT_SHORTCUT##;'>
                            <ul style='margin-bottom:0px;'>
		      		<li>
                                    <a href='#' onclick='show_transcripts(\"##DIVID##\");return false;'>
                                    <img src='".AT_BASE_HREF."mods/_standard/flowplayer/images/transcript.png' style='height:26px;width:26px' alt='Show Transcripts' title='Show Transcripts' class='shortcut_icon'><!-- Show transcripts -->
                                    </a>
                                </li>
		      	    </ul>
                            </div>".
                           "  <div id='##DIVID##_chapters' class = 'chapters' style = 'height:##HEIGHT##px; display: ##DISPLAY_TRANSCRIPTS_FLOWPLAYER##'>
                               <div id = '##DIVID##_transcript_controls' class = 'transcript-controls'><button type='button' class='close-button' title='Hide Transcripts' onclick='show_transcripts(\"##DIVID##\");return false;' ></button></div>
                               <div id='chapters-text' class = 'chapters-text' ></div>
                              </div>".
                           "  <script type=\"text/javascript\">
                               $(document).ready(function(){

                               ##TRANSCRIPTS_CODE_FLOWPLAYER##
                               
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
                                        case 84: show_transcripts(\"##DIVID##\");
                                        break;
                                    }
                                },
                                plugins: {
                                controls: {
                                autoHide: false,
          
                                tooltips: {
                                    buttons: true
                                    }
                                }
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
                                    <li>Transcripts Toggle: T key</li>
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

$holder_counter = 0;
for ($i=0;$i<count($media_replace);$i++){
	foreach($media_matches[$i] as $media)
	{
                $player_id = $fluidplayerholder_class.$holder_counter++;
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
                
                if((!empty($media[1])) && (preg_match("/captions=([.\w\d]+[^\s\"]+\.vtt)/", $media[1], $matches)))
                {
                    $media_input = str_replace("##CAPTION_CODE##", $caption_init, $media_input);
                    $media_input = str_replace("##CAPTIONS##", $matches[1], $media_input);
                    
                    if($_SESSION['prefs']['PREF_USE_CAPTIONS'] == 1)
                        $media_input = str_replace("##DISPLAY_CAPTIONS##", ',displayCaptions: true', $media_input);
                    else if($_SESSION['prefs']['PREF_USE_CAPTIONS'] == 0)
                        $media_input = str_replace("##DISPLAY_CAPTIONS##", '', $media_input);
                }
                else if((!empty($media[1])) && (preg_match("/captions=([.\w\d]+[^\s\"]+\.srt)/", $media[1], $matches)))
                {
                    $media_input = str_replace("##CAPTION_CODE##", $caption_init_flowplayer, $media_input);
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
                    $media_input = str_replace("##DISPLAY_CAPTIONS##", '', $media_input);
                }
                
                if((!empty($media[2])) && (preg_match("/transcripts=([.\w\d]+[^\s\"]+\.json)/", $media[2], $matches)))
                {
                    $media_input = str_replace("##TRANSCRIPTS_CODE##", $transcripts_init, $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CODE_FLOWPLAYER##", $transcripts_init_flowplayer, $media_input);
                        
                    $media_input = str_replace("##TRANSCRIPTS##", $matches[1], $media_input);
                        
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_CODE##", $transcripts_init_cuepoint_code_flowplayer, $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_SEEKING##", $transcripts_init_cuepoint_seeking_code_flowplayer, $media_input);
                    
                    if($_SESSION['prefs']['PREF_USE_TRANSCRIPTS'] == 1) {
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", ',displayTranscripts: true', $media_input);
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS_FLOWPLAYER##", 'block', $media_input);
                        $media_input = str_replace("##DISPLAY_TRANSCRIPT_SHORTCUT##", 'none', $media_input);
                    }
                    else if($_SESSION['prefs']['PREF_USE_TRANSCRIPTS'] == 0) {
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", '', $media_input);
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS_FLOWPLAYER##", 'none', $media_input);
                        $media_input = str_replace("##DISPLAY_TRANSCRIPT_SHORTCUT##", 'block', $media_input);
                    }
                }
                else
                {
                    $media_input = str_replace("##TRANSCRIPTS_CODE##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CODE_FLOWPLAYER##", '', $media_input);
                    
                    $media_input = str_replace("##TRANSCRIPTS##", '', $media_input);
                    
                    $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", '', $media_input);
                    $media_input = str_replace("##DISPLAY_TRANSCRIPTS_FLOWPLAYER##", 'none', $media_input);
                    
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_CODE##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_SEEKING##", '', $media_input);
                    
                    $media_input = str_replace("##DISPLAY_TRANSCRIPT_SHORTCUT##", 'none', $media_input);
                }
                
                $media_input = str_replace("##DIVCLASS##", $player_id, $media_input);
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
    function show_transcripts(id)
    {
        console.log("#"+id+"_transcript-shortcut");
        $("#"+id+"_transcript-shortcut").toggle();
        $("#"+id+"_chapters").toggle();
    }
    </script>
';
?>