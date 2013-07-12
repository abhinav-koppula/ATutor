<?php
// input string. DO NOT CHANGE.
global $_input, $_content_base_href;
$AT_BASE_HREF = AT_print(AT_BASE_HREF,'url.base');
$media_replace = array();
$media_matches = array();
$fluidplayerholder_class = "player";
$caption_init_flowplayer = "
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
                            templates: { 
                                videoPlayer: { 
                                    href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/videoPlayer_template.html' 
                                }, 
                                menuButton: { 
                                    href: '".$AT_BASE_HREF."mods/_standard/fluidplayer/html/menuButton_template.html' 
                                } 
                            } 
                            });
                             fluid_1_5.demands('fluid_1_5.videoPlayer.controllers', 'fluid_1_5.videoPlayer', { 
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
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json)*\]([.\w\d]+[^\s\"]+)\.flv\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);

if (isset($_SESSION['flash']) && $_SESSION['flash'] == "yes") {
	$media_replace[] = "<div>\n".
	                   "  <div class=\"##DIVCLASS##\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;\" ></div>\n".
                           "  <script type=\"text/javascript\">
                               \$f(\".##DIVCLASS##\", {
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
                                ##CAPTIONS##
                                }
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
                }
                else if((!empty($media[1])) && (preg_match("/captions=([.\w\d]+[^\s\"]+\.srt)/", $media[1], $matches)))
                {
                    $media_input = str_replace("##CAPTION_CODE##", $caption_init_flowplayer, $media_input);
                    $media_input = str_replace("##CAPTIONS##", 'captionUrl:"'.$matches[1].'"', $media_input);
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
                }
                else
                {
                    $media_input = str_replace("##TRANSCRIPTS_CODE##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS##", '', $media_input);
                }
                
                $media_input = str_replace("##DIVCLASS##", $player_id, $media_input);
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
?>