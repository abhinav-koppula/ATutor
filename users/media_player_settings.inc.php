<legend><strong><?php echo _AT("flowplayer"); ?></strong></legend>  
<?php $AT_BASE_HREF = AT_print(AT_BASE_HREF,'url.base');?>

<div id="feedback" style="width:90%;">
    <?php echo _AT('prefs_set_mediaplayer'); ?>
</div>
<div class="row">
    <div id="player" style="height:400px; width:400px;"></div>
    <script type="text/javascript" src="<?php echo $AT_BASE_HREF ?>mods/_standard/flowplayer/flowsplayer-3.2.12.js"></script>
    <script type="text/javascript" src="<?php echo $AT_BASE_HREF ?>mods/_standard/flowplayer/farbtastic/farbtastic.js"></script>
    <link rel="stylesheet" href="<?php echo $AT_BASE_HREF ?>mods/_standard/flowplayer/farbtastic/farbtastic.css" type="text/css" />

    <script type="text/javascript" src="<?php echo $AT_BASE_HREF ?>mods/_standard/flowplayer/flowplayer-3.2.12.min.js"></script>
    <script type="text/javascript">
        // <![CDATA[
        window.onload = function() {
            
            $f("player", {
                src: "<?php echo $AT_BASE_HREF ?>mods/_standard/flowplayer/flowplayer-3.2.16.swf",
                SeamlessTabbing: true
            }, {
                canvas: { backgroundColor: $('#flowplayer_canvas').val() },
                plugins: {
                    controls: {
                        backgroundColor: $('#flowplayer_backgroundColor').val() ? $('#flowplayer_backgroundColor').val() : '#222222',
                        buttonColor: $('#flowplayer_buttonColor').val() ? $('#flowplayer_buttonColor').val() : '#ffffff', 
                        buttonOverColor: $('#flowplayer_buttonOverColor').val() ? $('#flowplayer_buttonOverColor').val() : '#ffffff', 
                        volumeColor: $('#flowplayer_volumeColor').val() ? $('#flowplayer_volumeColor').val() : '#ffffff',
                        volumeSliderColor: $('#flowplayer_volumeSliderColor').val() ? $('#flowplayer_volumeSliderColor').val() : '#ffffff',
                        backgroundGradient: $('#flowplayer_gradient').val()=='custom' ? [0.1, 0.2, 0.5] : $('#flowplayer_gradient').val(),
                        height: $('#flowplayer_height').val(),
                        autoHide: false,
                        tooltips: {
                            buttons: true
                        }
                    }
                },
                clip: {
                    scaling: "fit",
                    autoPlay: false,
                    autoBuffering: true
                }
            });
        };
        // ]]>
    </script>
</div>

<div class="row" style="float:left;">
    <div id="skinning_controls" class="clearfix">
        <div class="col">
            <div class="col last" style="margin-right: 12px;width:200px; float:left;">
                <h3>Controlbar&nbsp;colors</h3>
                <label><input type="radio" name="target" value="backgroundColor" checked=""> controlbar </label><br>
                <label><input type="radio" name="target" value="buttonColor"> buttons </label><br>
                <label><input type="radio" name="target" value="buttonOverColor"> mouseover </label><br>
                <label><input type="radio" name="target" value="volumeColor"> volume slider </label><br>
                <label><input type="radio" name="target" value="volumeSliderColor"> volume slider 2 </label><br>
                <label><input type="radio" name="target" value="canvas"> canvas </label>
                
                <?php
                
                if(isset($_POST['flowplayer_backgroundColor']))
                    $flowplayer_backgroundColor = $_POST['flowplayer_backgroundColor'];
                else if($_SESSION['prefs']['PREF_FLOWPLAYER_BGCOLOR'])
                    $flowplayer_backgroundColor = $_SESSION['prefs']['PREF_FLOWPLAYER_BGCOLOR'];
                else 
                    $flowplayer_backgroundColor = '';
                
                if(isset($_POST['flowplayer_buttonColor']))
                    $flowplayer_buttonColor = $_POST['flowplayer_buttonColor'];
                else if($_SESSION['prefs']['PREF_FLOWPLAYER_BTNCOLOR'])
                    $flowplayer_buttonColor = $_SESSION['prefs']['PREF_FLOWPLAYER_BTNCOLOR'];
                else 
                    $flowplayer_buttonColor = '';
                
                if(isset($_POST['flowplayer_buttonOverColor']))
                    $flowplayer_buttonOverColor = $_POST['flowplayer_buttonOverColor'];
                else if($_SESSION['prefs']['PREF_FLOWPLAYER_BTNOVERCOLOR'])
                    $flowplayer_buttonOverColor = $_SESSION['prefs']['PREF_FLOWPLAYER_BTNOVERCOLOR'];
                else 
                    $flowplayer_buttonOverColor = '';
                
                if(isset($_POST['flowplayer_volumeColor']))
                    $flowplayer_volumeColor = $_POST['flowplayer_volumeColor'];
                else if($_SESSION['prefs']['PREF_FLOWPLAYER_VOLCOLOR'])
                    $flowplayer_volumeColor = $_SESSION['prefs']['PREF_FLOWPLAYER_VOLCOLOR'];
                else 
                    $flowplayer_volumeColor = '';
                
                if(isset($_POST['flowplayer_volumeSliderColor']))
                    $flowplayer_volumeSliderColor = $_POST['flowplayer_volumeSliderColor'];
                else if($_SESSION['prefs']['PREF_FLOWPLAYER_VOLSLIDERCOLOR'])
                    $flowplayer_volumeSliderColor = $_SESSION['prefs']['PREF_FLOWPLAYER_VOLSLIDERCOLOR'];
                else 
                    $flowplayer_volumeSliderColor = '';
                
                if(isset($_POST['flowplayer_canvas']))
                    $flowplayer_canvas = $_POST['flowplayer_canvas'];
                else if($_SESSION['prefs']['PREF_FLOWPLAYER_CANVAS'])
                    $flowplayer_canvas = $_SESSION['prefs']['PREF_FLOWPLAYER_CANVAS'];
                else 
                    $flowplayer_canvas = '';
                ?>
                <input type="hidden" id = "flowplayer_backgroundColor" name="flowplayer_backgroundColor" value="<?php echo $flowplayer_backgroundColor; ?>" />
                <input type="hidden" id = "flowplayer_buttonColor" name="flowplayer_buttonColor" value="<?php echo $flowplayer_buttonColor; ?>" />
                <input type="hidden" id = "flowplayer_buttonOverColor" name="flowplayer_buttonOverColor" value="<?php echo $flowplayer_buttonOverColor; ?>" />
                <input type="hidden" id = "flowplayer_volumeColor" name="flowplayer_volumeColor" value="<?php echo $flowplayer_volumeColor; ?>" />
                <input type="hidden" id = "flowplayer_volumeSliderColor" name="flowplayer_volumeSliderColor" value="<?php echo $flowplayer_volumeSliderColor; ?>" />
                <input type="hidden" id = "flowplayer_canvas" name="flowplayer_canvas" value="<?php echo $flowplayer_canvas; ?>" />
            </div>
            <div id="picker" class="col" style="width:200px;height:200px;float:left">
                <div class="farbtastic">
                    <div class="color" style="background-color: rgb(255, 0, 51);"></div>
                    <div class="wheel"></div>
                    <div class="overlay"></div>
                    <div class="h-marker marker" style="left: 79px; top: 15px;"></div>
                    <div class="sl-marker marker" style="left: 56px; top: 108px;"></div>
                </div>
            </div>
            <div style="width:240px;float:left">
                <h3>Controlbar&nbsp;styling</h3>

                <p>
                    <label><span class="caps">BG</span> gradient <br>
                        <select name="flowplayer_gradient" id="flowplayer_gradient" >
                            <?php
				if (isset($_POST['flowplayer_gradient']))
					$selected_gradient = $_POST['flowplayer_gradient'];
				else if (isset($_SESSION['prefs']['PREF_FLOWPLAYER_GRADIENT']))
					$selected_gradient = $_SESSION['prefs']['PREF_FLOWPLAYER_GRADIENT'];
				else
					$selected_gradient = "";  // default
                            ?>
				<option value="medium" <?php if ($selected_gradient == "") echo 'selected="selected"'; ?>>medium</option>   
				<option value="low" <?php if ($selected_gradient == "low") echo 'selected="selected"'; ?>>low</option>   
				<option value="high" <?php if ($selected_gradient == "high") echo 'selected="selected"'; ?>>high</option>   
				<option value="custom" <?php if ($selected_gradient == "custom") echo 'selected="selected"'; ?>>[0.1, 0.2, 0.5]</option>   
				<option value="none" <?php if ($selected_gradient == "none") echo 'selected="selected"'; ?>>none</option>   
			</select>
                    </label>
                </p>
                <p>
                    <label>Height <br>
                        <select name="flowplayer_height" id="flowplayer_height">
                            <?php
				if (isset($_POST['flowplayer_height']))
					$selected_height = $_POST['flowplayer_height'];
				else if (isset($_SESSION['prefs']['PREF_FLOWPLAYER_HEIGHT']))
					$selected_height = $_SESSION['prefs']['PREF_FLOWPLAYER_HEIGHT'];
				else
					$selected_height = 24;  // default
                            ?>
                            <option value="20" <?php if ($selected_height == 20) echo 'selected="selected"'; ?>>20</option>
                            <option value="24" <?php if ($selected_height == 24) echo 'selected="selected"'; ?>>24 (default)</option>
                            <option value="32" <?php if ($selected_height == 32) echo 'selected="selected"'; ?>>32</option>
                            <option value="36" <?php if ($selected_height == 36) echo 'selected="selected"'; ?>>36</option>
                            <option value="42" <?php if ($selected_height == 42) echo 'selected="selected"'; ?>>42</option>
                        </select>
                    </label>
                </p>

            </div>
        </div>
    </div>
    <script>
        $('#picker').farbtastic(function(color) {
            var player = $f("player");
            if (player.isLoaded()) {

                var target = $(":input[name=target]:checked").val();
                $('#flowplayer_'+target).val(color);
                
                // adjust canvas bgcolor. uses undocumented API call. not stabilized yet
                if (target == 'canvas') {
                    player._api().fp_css("canvas", {backgroundColor: color});

                    // adjust controlbar coloring
                } else {

                    window.canvasColor = color;
                    player.getControls().css(target, color);
                }

            } else {
                player.load();
            }
        });
        $("#flowplayer_height").change(function() {
            $f().getControls().css("height", $(this).val());
        });
        $("#flowplayer_gradient").change(function() {
            var val = $(this).val();
            if (val == 'custom')
                val = [0.1, 0.2, 0.5];
            $f().getControls().css("backgroundGradient", val);
        });
    </script>
</div>

