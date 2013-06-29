<?php
// input string. DO NOT CHANGE.
global $_input, $_content_base_href;
$AT_BASE_HREF = AT_print(AT_BASE_HREF,'url.base');
$media_replace = array();
$media_matches = array();
$fluidplayerholder_class = "player";
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
                   "</div>\n";


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
?>