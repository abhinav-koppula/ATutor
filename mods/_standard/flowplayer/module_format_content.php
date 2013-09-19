<?php
// input string. DO NOT CHANGE.
global $_input, $_content_base_href;

// Output for flowplayer module.
// Note: The properly functioning of flowplayer requires flash to be installed. 
// The conversion performed by this module converts the [media] tag into flowplayer class
// only when the flash is installed, otherwise, the [media] tag is converted into a plain 
// <a> link.
require_once('language_file.inc.php');
$media_replace = array();
$media_matches = array();
$flowplayerholder_class = "player";  // style class used to play flowplayer medias
$flowplayerholder_def = '$f("*.'.$flowplayerholder_class.'"';   // javascript definition for atutor.flowplayerholder 
//captions initialization when captions are specified in media tag
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
//preparing array of transcripts
$transcripts_prepare = "
    if($('###DIVID##_transcript_languages option').length > 0)
    {
        $('###DIVID##_transcript_languages option').each(function()
        {
            ##DIVID##_transcripts.push(prepare_transcripts(this));
        });
    }
";
//initializing the first prepared transcript as the default one to be shown and others are initialized when the select options are changed
$transcripts_init = "
    if($('###DIVID##_transcript_languages option').length > 0)
    init_transcripts(\"##DIVID##\", ##DIVID##_transcripts, counter, player_##DIVID##);
                                
    $('###DIVID##_transcript_languages').change(function() {
        id=$(this).attr('id');
        counter = $('#'+id +' option:selected').attr('rel'); 
        init_transcripts(\"##DIVID##\", ##DIVID##_transcripts, counter, player_##DIVID##);
    });
";
//using flowplayer APIs to trigger events(seek control-bar and change highlighting) when cuepoints are reached
$transcripts_init_cuepoint_code = "
    onCuepoint: [
        ##DIVID##_cuepointsobj[counter],
        function(clip, cuepoint) {
            $('###DIVID##_chapters > #chapters-text').children().removeClass('highlight');
            $('###DIVID##_chapters > #chapters-text').find('span[rel=\"'+cuepoint.time+'\"]').addClass('highlight');
            var item = $('###DIVID##_chapters > #chapters-text').find('span[rel=\"'+cuepoint.time+'\"]');
            var offset = item.position().top;
            var parent = item.parent();
            var pos = parent.scrollTop();
            
            parent.animate({scrollTop: pos+offset},1000);
        }
    ],
";
//initializing display preferences variables
if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_BGCOLOR']) && ($_SESSION['prefs']['PREF_FLOWPLAYER_BGCOLOR'])!='')
    $bgcolor = $_SESSION['prefs']['PREF_FLOWPLAYER_BGCOLOR'];
else
    $bgcolor = '#222222';

if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_BTNCOLOR']) && ($_SESSION['prefs']['PREF_FLOWPLAYER_BTNCOLOR'])!='')
    $btncolor = $_SESSION['prefs']['PREF_FLOWPLAYER_BTNCOLOR'];
else
    $btncolor = '#ffffff';

if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_BTNOVERCOLOR']) && ($_SESSION['prefs']['PREF_FLOWPLAYER_BTNOVERCOLOR'])!='')
    $btnovercolor = $_SESSION['prefs']['PREF_FLOWPLAYER_BTNOVERCOLOR'];
else
    $btnovercolor = '#ffffff';

if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_VOLCOLOR']) && ($_SESSION['prefs']['PREF_FLOWPLAYER_VOLCOLOR'])!='')
    $volcolor = $_SESSION['prefs']['PREF_FLOWPLAYER_VOLCOLOR'];
else
    $volcolor = '#ffffff';

if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_VOLSLIDERCOLOR']) && ($_SESSION['prefs']['PREF_FLOWPLAYER_VOLSLIDERCOLOR'])!='')
    $volslidercolor = $_SESSION['prefs']['PREF_FLOWPLAYER_VOLSLIDERCOLOR'];
else
    $volslidercolor = '#ffffff';

if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_GRADIENT']) && ($_SESSION['prefs']['PREF_FLOWPLAYER_GRADIENT'])!='') {
    $gradient = $_SESSION['prefs']['PREF_FLOWPLAYER_GRADIENT'];
    if($gradient == 'custom')
        $gradient = "[0.1, 0.2, 0.5]";
}
else
    $gradient = 'medium';

if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_HEIGHT']))
    $cbar_height = $_SESSION['prefs']['PREF_FLOWPLAYER_HEIGHT'];
else
    $cbar_height = 24;

if(isset($_SESSION['prefs']['PREF_FLOWPLAYER_CANVAS']) && ($_SESSION['prefs']['PREF_FLOWPLAYER_CANVAS'])!='')
    $canvas = $_SESSION['prefs']['PREF_FLOWPLAYER_CANVAS'];
else
    $canvas = '#000000';

// .flv
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt\|?)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json[:a-z]*?)*\]([.\w\d]+[^\s\"]+)\.flv\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);

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
                           "  <div id='##DIVID##_chapters' class = 'chapters' style = 'height:##HEIGHT##px; display: ##DISPLAY_TRANSCRIPTS##'>
                               <div id = '##DIVID##_transcript_controls' class = 'transcript-controls'>
                                   <button type='button' class='close-button' title='Hide Transcripts' onclick='show_transcripts(\"##DIVID##\");return false;' ></button>
                                   <select id = '##DIVID##_transcript_languages' >##TRANSCRIPTS_OPTIONS##</select>
                               </div>
                               <div id='chapters-text' class = 'chapters-text' ></div>
                              </div>\n".
                           "  <script type=\"text/javascript\">
                               $(document).ready(function(){
                               var counter=0;
                               
                               ##DIVID##_transcripts = [];
                               ##DIVID##_cuepointsobj = [];
                               ##DIVID##_chaptersobj = [];
                               
                               ##TRANSCRIPTS_PREPARE##
                               
                               if($('###DIVID##_transcript_languages option').length > 0)
                               ##DIVID##_cuepointsobj = prepare_cuepoints(##DIVID##_transcripts);
                               
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
                                canvas: { backgroundColor: '". $canvas. "' },
                                plugins: {
                                controls: {
                                backgroundColor: '". $bgcolor ."',
                                buttonColor: '". $btncolor. "',
                                buttonOverColor: '". $btnovercolor. "',
                                volumeColor: '". $volcolor. "',
                                volumeSliderColor: '". $volslidercolor. "',
                                backgroundGradient: '". $gradient. "',
                                height: '". $cbar_height. "', 
                                
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
                                
                                ##TRANSCRIPTS_INIT##
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

// .mp4
preg_match_all("#\[media[0-9a-z\|]*([\s]?captions=[.\w\d]+[^\s\"]+\.srt\|?)*([\s]?transcripts=[.\w\d]+[^\s\"]+\.json[:a-z]*?)*\]([.\w\d]+[^\s\"]+)\.mp4\[/media\]#i",$_input,$media_matches[],PREG_SET_ORDER);
if (isset($_SESSION['flash']) && $_SESSION['flash'] == "yes") {
	$media_replace[] = "<div>\n".
	                   "  <div id=\"##DIVID##\" style=\"display:block;width:##WIDTH##px;height:##HEIGHT##px;float:left;\" ></div>\n".
                           "<div id='##DIVID##_transcript-shortcut' class = 'transcript-shortcut' style='float:left;display: ##DISPLAY_TRANSCRIPT_SHORTCUT##;'>
                            <ul style='margin-bottom:0px;'>
		      		<li>
                                    <a href='#' onclick='show_transcripts(\"##DIVID##\");return false;'>
                                    <img src='".AT_BASE_HREF."mods/_standard/flowplayer/images/transcript.png' style='height:26px;width:26px' alt='Show Transcripts' title='Show Transcripts' class='shortcut_icon'><!-- Show transcripts -->
                                    </a>
                                </li>
		      	    </ul>
                            </div>".
                           "  <div id = '##DIVID##_chapters' class = 'chapters' style = 'height:##HEIGHT##px; display: ##DISPLAY_TRANSCRIPTS##'>
                               <div id = '##DIVID##_transcript_controls' class = 'transcript-controls'>
                                   <button type='button' class='close-button' title='Hide Transcripts' onclick='show_transcripts(\"##DIVID##\");return false;' ></button>
                                   <select id = '##DIVID##_transcript_languages' >##TRANSCRIPTS_OPTIONS##</select>
                               </div>
                               <div id='chapters-text' class = 'chapters-text' ></div>
                              </div>\n".
                           "  <script type=\"text/javascript\">
                               $(document).ready(function(){
                               var counter=0;
                               
                               ##DIVID##_transcripts = [];
                               ##DIVID##_cuepointsobj = [];
                               ##DIVID##_chaptersobj = [];
                               
                               ##TRANSCRIPTS_PREPARE##
                               
                               if($('###DIVID##_transcript_languages option').length > 0)
                               ##DIVID##_cuepointsobj = prepare_cuepoints(##DIVID##_transcripts);
                               
                                
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
                                canvas: { backgroundColor: '". $canvas. "' },
                                plugins: {
                                controls: {
                                backgroundColor: '". $bgcolor ."',
                                buttonColor: '". $btncolor. "',
                                buttonOverColor: '". $btnovercolor. "',
                                volumeColor: '". $volcolor. "',
                                volumeSliderColor: '". $volslidercolor. "',
                                backgroundGradient: '". $gradient. "',
                                height: '". $cbar_height. "', 
                                    
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
                                
                                ##TRANSCRIPTS_INIT##
                               
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
                
                //initialize captions if captions are specified in the media tag
                if((!empty($media[1])) && (preg_match("/captions=([.\w\d]+[^\s\"]+\.srt)/", $media[1], $matches)))
                {
                    $media_input = str_replace("##CAPTION_CODE##", $caption_init, $media_input);
                    $media_input = str_replace("##CAPTIONS##", 'captionUrl:"'.$matches[1].'"', $media_input);
                    
                    //show captions by default if preference is set
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
                
                //initialize transcripts if transcripts are specified in the media tag
                if((!empty($media[2])) && (preg_match("/transcripts=([.\w\d]+[^\s\"]+\.json(:[a-z]*)*)/", $media[2], $matches)))
                {
                    //explode the matched string to retrieve all the multiple language transcripts specified
                    $transcripts = explode('|', $matches[1]);
                    $transcript_options="";
                    $transcript_counter=0;
                    foreach($transcripts as $transcript)
                    {
                        $file_lang = explode(':', $transcript);
                        $transcript_file = $file_lang[0];
                        $transcript_lang = $file_lang[1];
                        //use English if nothing is specified
                        if($transcript_lang=='')
                            $transcript_lang="en";
                        //populate the options of the select tag
                        $transcript_options.="<option name='".$transcript_file."' rel='".$transcript_counter."'>". $languageCodes[$transcript_lang] ."</option>";
                        $transcript_counter++;
                    }
                    
                    $media_input = str_replace("##TRANSCRIPTS_OPTIONS##", $transcript_options, $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_PREPARE##", $transcripts_prepare, $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_INIT##", $transcripts_init, $media_input);
                    
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_CODE##", $transcripts_init_cuepoint_code, $media_input);
                    
                    //show transcripts by default if preference is set
                    if($_SESSION['prefs']['PREF_USE_TRANSCRIPTS'] == 1) {
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", 'block', $media_input);
                        $media_input = str_replace("##DISPLAY_TRANSCRIPT_SHORTCUT##", 'none', $media_input);
                    }
                    else if($_SESSION['prefs']['PREF_USE_TRANSCRIPTS'] == 0) {
                        $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", 'none', $media_input);
                        $media_input = str_replace("##DISPLAY_TRANSCRIPT_SHORTCUT##", 'block', $media_input);
                    }
                }
                else
                {
                    $media_input = str_replace("##TRANSCRIPTS_OPTIONS##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_PREPARE##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_INIT##", '', $media_input);
                    $media_input = str_replace("##TRANSCRIPTS_CUEPOINT_CODE##", '', $media_input);
                    
                    
                    $media_input = str_replace("##DISPLAY_TRANSCRIPTS##", 'none', $media_input);
                    $media_input = str_replace("##DISPLAY_TRANSCRIPT_SHORTCUT##", 'none', $media_input);
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
    
    //toggle transcripts on clicking the shortcut
    function show_transcripts(id)
    {
        $("#"+id+"_transcript-shortcut").toggle();
        $("#"+id+"_chapters").toggle();
    }
    
    //get transcript file as json response
    function prepare_transcripts(id)
    {
        var transcript_file = $(id).attr("name");
        var transcript = (function() {
        var json_file = null;
        $.ajax({
            "async" : false,
            "global" : false,
            "url" : "'.AT_BASE_HREF.'get.php/'.$_content_base_href.'"+transcript_file,
            "dataType" : "json",
            "success" : function (data) {
                json_file = data;
            }
        });
        return json_file;
        })();
        
        return transcript;
    }
    
    //prepare cuepoints(times when events are triggered) for each transcript
    function prepare_cuepoints(transcriptobj)
    {
        var cuepointsobj=[];
        var cuepoints=[];
        $.each(transcriptobj, function(k, val) {
        $.each(val, function(key, value){
        $.each(value, function(index, element) {
            intime = element.inTime.split(":");
            hh = intime[0];
            mm = intime[1];
            ss = intime[2];
            mss = Math.round((ss*10)/10)*1000;
            intime = (parseInt(hh)*60*60 + parseInt(mm)*60)*1000 + mss;
            item = "<span rel=\'"+intime+"\'>"+element.transcript+"</span>";
            cuepoints.push({time:intime, text:item});
        });
        cuepointsobj.push(cuepoints);
        cuepoints = [];
        });
        });
        return cuepointsobj;
    }
    
    //seek the control-bar when transcript spans are clicked thus changing the highlighting as well
    function cuepoint_seeking(span_elem)
    {
        cuepoint = $(span_elem).attr("rel");
        pos = parseInt(cuepoint, 10) / 1000;
        
        parent = $(span_elem).parent().parent().attr("id").split("_");
        player = window["player_"+parent[0]];
        
        if (!player.isLoaded()) {
                player.play();
                seekpos = pos;
        } else {
                player.seek(player.isPaused() && pos === 0 ? 1 : pos);
        }
        $(span_elem).siblings().removeClass(\'highlight\');
        $(span_elem).addClass(\'highlight\');        
    }
    
    //initialize transcript spans when select options are changed
    function init_transcripts(divid, transcripts, counter, playerholder)
    {
        var transcript = transcripts[counter];
        
        $("#"+divid+"_chapters > #chapters-text").empty();
        $.each(transcript, function(key, value){
            $.each(value, function(index, element) {
                intime = element.inTime.split(":");
                hh = intime[0];
                mm = intime[1];
                ss = intime[2];
                mss = Math.round((ss*10)/10)*1000;
                intime = (parseInt(hh)*60*60 + parseInt(mm)*60)*1000 + mss;
        
                item = "<span rel=\'"+intime+"\' onclick = \"cuepoint_seeking(this)\" >"+element.transcript+"</span>";
                $("#"+divid+"_chapters > #chapters-text").append(item+" ");
            });
        });
    
    }
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