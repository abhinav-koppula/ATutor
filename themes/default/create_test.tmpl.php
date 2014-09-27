<?php
/* * ****************************************************************** */
/* ATutor                                                               */
/* * ****************************************************************** */
/* Copyright (c) 2014                                                   */
/* Inclusive Design Institute                                           */
/* http://atutor.ca                                                     */
/* This program is free software. You can redistribute it and/or        */
/* modify it under the terms of the GNU General Public License          */
/* as published by the Free Software Foundation.                        */
/* * ****************************************************************** */
// $Id$                                         Author: Abhinav Koppula */
?>
<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post" name="form">
    <?php if($this->tid > 0): ?>
    <input type="hidden" name="tid" value="<?php echo $this->tid; ?>" />
    <?php endif; ?>        
<div class="input-form">
    <fieldset class="group_form">
    <?php if($this->tid > 0): ?>
    <legend class="group_form"><?php echo _AT('edit_test'); ?></legend>
    <?php else: ?>
    <legend class="group_form"><?php echo _AT('create_test'); ?></legend>
    <?php endif; ?>
    <div class="row">
        <span class="required" title="<?php echo _AT('required_field'); ?>">*</span><label for="title"><?php echo _AT('title'); ?></label><br />
        <input type="text" name="title" id="title" size="30" value="<?php echo $_POST['title']; ?>" />
    </div>

    <div class="row">
        <label for="description"><?php echo _AT('test_description'); ?></label><br />
        <textarea name="description" cols="35" rows="3" id="description"><?php echo htmlspecialchars($_POST['description']); ?></textarea>
    </div>

    <div class="row">
        <label for="num_t"><?php echo _AT('num_takes_test'); ?></label><br />
        <select name="num_takes" id="num_t">
            <option value="<?php echo AT_TESTS_TAKE_UNLIMITED; ?>" <?php if ($_POST['num_takes'] == AT_TESTS_TAKE_UNLIMITED) { echo ''; } ?>><?php echo _AT('unlimited'); ?></option>
            <?php echo $this->num_takes_options; ?>
        </select>
    </div>

    <?php
        echo generate_radio_button_options(array(   'section_name' => 'available_on_my_courses',
                                                    'radio_name' => 'format',
                                                    'radio_label_N' => _AT('no'),
                                                    'radio_label_Y' => _AT('yes')));

        // This addresses the following issue: http://www.atutor.ca/atutor/mantis/view.php?id=3268
        // Ref: line 64
        $sql = "SELECT t.test_id, anonymous FROM %stests_results r NATURAL JOIN %stests t WHERE r.test_id = t.test_id AND r.test_id=%d";
        $row_anon    = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, $this->tid));

        $anonymous_disabled = FALSE;
        if(count($row_anon) > 0){
            //If there are submission(s) for this test, anonymous field will not be altered.
            $anonymous_disabled = TRUE;
        }
        
        echo generate_radio_button_options(array(    'section_name' => 'anonymous_test',
                                                    'radio_name' => 'anonymous',
                                                    'radio_label_N' => _AT('no'),
                                                    'radio_label_Y' => _AT('yes'),
                                                    'disabled' => $anonymous_disabled));

        $allow_guests = generate_radio_button_options(array(    'radio_name' => 'allow_guests',
                                                                'radio_label_N' => _AT('no'),
                                                                'radio_label_Y' => _AT('yes'),
                                                                'disable_elements' => 'show_guest_form'));
        
        $y = ($_POST['show_guest_form'] == 1) ? 'checked="checked"' : '';
        $disable_show_guest_form = ($_POST['allow_guests'] == 1) ? '' : 'disabled="disabled"';
        $show_guest_form = sprintf('<br /><input type="checkbox" name="show_guest_form" id="show_guest_form" value="1" %s %s /><label for="show_guest_form">%s</label>', $y, $disable_show_guest_form, _AT('show_guest_form'));
        
        // Before rendering add a checkbox into the div after radio buttons
        echo str_replace("</div>", $show_guest_form."</div>", $allow_guests);

        echo generate_radio_button_options(array(   'radio_name' => 'display',
                                                    'radio_label_N' => _AT('all_questions_on_page'),
                                                    'radio_label_Y' => _AT('one_question_per_page')));
        
        echo generate_radio_button_options(array(   'radio_name' => 'remedial_content',
                                                    'radio_label_N' => _AT('remedial_content_hide'),
                                                    'radio_label_Y' => _AT('remedial_content_show')));
    ?>

    <div class="row">
        <?php echo _AT('pass_score'); ?><br />
        <input type="radio" name="pass_score" value="0" id="no" <?php if ($_POST['passpercent'] == 0 && $_POST['passscore'] == 0){echo 'checked="checked"';} ?> 
        onfocus="ATutor.mods.tests.disable_elements('both');" onclick="this.onfocus();" />

        <label for="no" title="<?php echo _AT('pass_score'). ': '. _AT('no_pass_score');  ?>"><?php echo _AT('no_pass_score'); ?></label><br />

        <input type="radio" name="pass_score" value="1" id="percentage"  <?php if ($_POST['passpercent'] <> 0){echo 'checked="checked"';} ?>
        onfocus="ATutor.mods.tests.disable_elements('points');" onclick="this.onfocus();" />

        <input type="text" name="passpercent" id="passpercent" size="2" value="<?php echo $_POST['passpercent']; ?>" 
         <?php if ($_POST['passpercent'] == 0){echo 'disabled="disabled"';} ?> /> 
        <label for="percentage" title="<?php echo _AT('pass_score'). ': '. _AT('percentage_score');  ?>"><?php  echo '% ' . _AT('percentage_score'); ?></label><br />

        <input type="radio" name="pass_score" value="2" id="points"  <?php if ($_POST['passscore'] <> 0){echo 'checked="checked"';} ?>
        onfocus="ATutor.mods.tests.disable_elements('percentage');" onclick="this.onfocus();" />

        <input type="text" name="passscore" id="passscore" size="2" value="<?php echo $_POST['passscore']; ?>" 
         <?php if ($_POST['passscore'] == 0){echo 'disabled="disabled"';} ?>/> 
        <label for="points" title="<?php echo _AT('pass_score'). ': '. _AT('points_score');  ?>"><?php  echo _AT('points_score'); ?></label>
    </div>

    <div class="row">
        <label for="passfeedback"><?php echo _AT('pass_feedback'); ?></label><br />
        <textarea name="passfeedback" cols="35" rows="1" id="passfeedback"><?php echo htmlspecialchars($_POST['passfeedback']); ?></textarea>
    </div>

    <div class="row">
        <label for="failfeedback"><?php echo _AT('fail_feedback'); ?></label><br />
        <textarea name="failfeedback" cols="35" rows="1" id="failfeedback"><?php echo htmlspecialchars($_POST['failfeedback']); ?></textarea>
    </div>

    <div class="row">
        <?php echo _AT('result_release'); ?><br />
        <?php 
            if ($_POST['result_release'] == AT_RELEASE_IMMEDIATE) {
                $check_marked = $check_never = '';
                $check_immediate = 'checked="checked"';

            } else if ($_POST['result_release'] == AT_RELEASE_MARKED) {
                $check_immediate = $check_never = '';
                $check_marked = 'checked="checked"';

            } else if ($_POST['result_release'] == AT_RELEASE_NEVER) {
                $check_immediate = $check_marked = '';
                $check_never = 'checked="checked"';
            }
        ?>
        <input type="radio" name="result_release" id="release1" value="<?php echo AT_RELEASE_IMMEDIATE; ?>" <?php echo $check_immediate; ?> /><label for="release1"><?php echo _AT('release_immediate'); ?></label><br />
        <input type="radio" name="result_release" id="release2" value="<?php echo AT_RELEASE_MARKED; ?>" <?php echo $check_marked; ?> /><label for="release2"><?php echo _AT('release_marked'); ?></label><br />
        <input type="radio" name="result_release" id="release3" value="<?php echo AT_RELEASE_NEVER; ?>" <?php echo $check_never; ?>/><label for="release3"><?php echo _AT('release_never'); ?></label>
    </div>

    <div class="row">
        <?php echo _AT('randomize_questions'); ?><br />
        <?php 
            if ($_POST['random'] == 1) {
                $y = 'checked="checked"';
                $n = $disabled = '';
            } else {
                $y = '';
                $n = 'checked="checked"';
                $disabled = 'disabled="disabled" ';
            }
        ?>
        <input type="radio" name="random" id="random" value="0" checked="checked" onfocus="ATutor.mods.tests.disable_elements('num_questions', true);" onclick="this.onfocus();" /><label for="random"><?php echo _AT('no'); ?></label>. <input type="radio" name="random" value="1" id="ry" onfocus="ATutor.mods.tests.disable_elements('num_questions', false);" onclick="this.onfocus();" <?php echo $y; ?> /><label for="ry"><?php echo _AT('yes'); ?></label>, <input type="text" name="num_questions" id="num_questions" size="2" value="<?php echo $_POST['num_questions']; ?>" <?php echo $disabled . $n; ?> /> <label for="num_questions"><?php echo _AT('num_questions_per_test'); ?></label>
    </div>

    <div class="row">
        <?php echo _AT('timed_test'); ?><br/>
        <?php 
            if ($_POST['timed_test'] == 1) {
                $y = 'checked="checked"';
                $n = $disabled = '';
            } else {
                $y = '';
                $n = 'checked="checked"';
                $disabled = 'disabled="disabled" ';
            }
            
            $timed_test_hours = (int)($_POST['timed_test_hours']);
            $timed_test_minutes = (int)($_POST['timed_test_minutes']);
            $timed_test_seconds = (int)($_POST['timed_test_seconds']);
        ?>
        <input type="radio" name="timed_test" id="timed_test_no" value="0" checked="checked" onfocus="ATutor.mods.tests.disable_elements('timed_test_duration', true);" onclick="this.onfocus();" />
        <label for="timed_test_no"><?php echo _AT('no'); ?></label>. 
        <input type="radio" name="timed_test" value="1" id="timed_test_yes" onfocus="ATutor.mods.tests.disable_elements('timed_test_duration', false);" onclick="this.onfocus();" <?php echo $y; ?> />
        <label for="timed_test_yes"><?php echo _AT('yes'); ?></label>, 
        
        <input type="text" name="timed_test_hours" id="timed_test_hours" size="2" value="<?php echo $timed_test_hours; ?>" <?php echo $disabled . $n; ?> /> 
        <label for="timed_test_hours"><?php echo _AT('hours'); ?></label>
        <input type="text" name="timed_test_minutes" id="timed_test_minutes" size="2" value="<?php echo $timed_test_minutes; ?>" <?php echo $disabled . $n; ?> /> 
        <label for="timed_test_minutes"><?php echo _AT('in_minutes'); ?></label>
        <input type="text" name="timed_test_seconds" id="timed_test_seconds" size="2" value="<?php echo $timed_test_seconds; ?>" <?php echo $disabled . $n; ?> /> 
        <label for="timed_test_seconds"><?php echo _AT('seconds'); ?></label>
    </div>
    
    <div class="row">
        <?php echo _AT('timed_test_modes'); ?><br/>
        <input type="text" name="timed_test_normal_mode" id="timed_test_normal_mode" size="2" value="<?php echo $_POST['timed_test_normal_mode'] ? $_POST['timed_test_normal_mode'] : 60; ?>" <?php echo $disabled . $n; ?> /> 
        <label for="timed_test_normal_mode"><?php echo _AT('timed_test_normal_mode'); ?></label>
        <input type="text" name="timed_test_intermediate_mode" id="timed_test_intermediate_mode" size="2" value="<?php echo $_POST['timed_test_intermediate_mode'] ? $_POST['timed_test_intermediate_mode'] : 30; ?>" <?php echo $disabled . $n; ?> /> 
        <label for="timed_test_intermediate_mode"><?php echo _AT('timed_test_intermediate_mode'); ?></label>
        <input type="text" name="timed_test_emergency_mode" id="timed_test_emergency_mode" size="2" value="<?php echo $_POST['timed_test_emergency_mode'] ? $_POST['timed_test_emergency_mode'] : 10; ?>" <?php echo $disabled . $n; ?> /> 
        <label for="timed_test_emergency_mode"><?php echo _AT('timed_test_emergency_mode'); ?></label>
    </div>
    
    <div class="row">
        <?php
        foreach($_POST as $key => $value)
        {
            if(substr($key, 0, strlen($key)-1) == "custom_duration_type_") {
                $id = substr($key, -1);
                $type = $_POST["custom_duration_type_".$id];
                $type_id = $_POST["custom_duration_options_".$id];
                $custom_duration_hours = $_POST["custom_duration_hours_".$id];
                $custom_duration_minutes = $_POST["custom_duration_minutes_".$id];
                $custom_duration_seconds = $_POST["custom_duration_seconds_".$id];
                $custom_duration = intval($custom_duration_hours) * 3600 + intval($custom_duration_minutes) * 60 + intval($custom_duration_seconds);
                echo '
                    <script type="text/javascript">
                    $(document).ready(function() {
                        ATutor.mods.tests.create_test.edit_custom_duration_row("'.$type.'", '.$type_id.', '.$custom_duration.');
                    });
                    </script>
                    ';
            }
        }
        ?>
        <table class="data" summary="" id="custom_duration">
            <thead>
                <tr>
                    <th scope="col"><?php echo _AT('type'); ?></th>
                    <th scope="col"><?php echo _AT('name'); ?></th>
                    <th scope="col"><?php echo _AT('custom_duration'); ?></th>
                    <th scope="col"></th>
                </tr>   
            </thead>
            <tfoot>
                <tr>
                    <td colspan="4">
                        <input type="button" name="add" value="<?php echo _AT('add'); ?>" id="add_custom_duration_row" />
                    </td>
                </tr>
            </tfoot>
            <tbody>
            </tbody>
        </table>
    </div>

    <div class="row">
        <?php echo _AT('start_date');  ?><br />
        <?php
            if(isset($_POST['submit'])) {
                $today_day  = intval($this->day_start);
                $today_mon  = intval($this->month_start);
                $today_year = intval($this->year_start);
                $today_hour = intval($this->hour_start);
                $today_min  = intval($this->min_start);
            } else {
                if($this->tid > 0) {
                    $today_day   = substr($_POST['start_date'], 8, 2);
                    $today_mon   = substr($_POST['start_date'], 5, 2);
                    $today_year  = substr($_POST['start_date'], 0, 4);
                    $today_hour  = substr($_POST['start_date'], 11, 2);
                    $today_min   = substr($_POST['start_date'], 14, 2);
                } else {
                    $today_day  = date('d');
                    $today_mon  = date('m');
                    $today_year = date('Y');
                    $today_hour = date('H');
                    $today_min  = 0;
                }
            }
            $name = '_start';
            require(AT_INCLUDE_PATH.'html/release_date.inc.php');

        ?>
    </div>

    <div class="row">
        <?php echo _AT('end_date');  ?><br />
        <?php
            if(isset($_POST['submit'])) {
                $today_day  = intval($this->day_end);
                $today_mon  = intval($this->month_end);
                $today_year = intval($this->year_end);
                $today_hour = intval($this->hour_end);
                $today_min  = intval($this->min_end);
            } else {
                if($this->tid > 0) {
                    $today_day   = substr($_POST['end_date'], 8, 2);
                    $today_mon   = substr($_POST['end_date'], 5, 2);
                    $today_year  = substr($_POST['end_date'], 0, 4);
                    $today_hour  = substr($_POST['end_date'], 11, 2);
                    $today_min   = substr($_POST['end_date'], 14, 2);
                } else {
                    $today_day  = date('d');
                    $today_mon  = date('m');
                    $today_year = date('Y');
                    $today_hour = date('H');
                    $today_min  = 0;
                }
            }
                    
            $name = '_end';
            require(AT_INCLUDE_PATH.'html/release_date.inc.php');
        ?>
    </div>

    <div class="row">
        <?php echo _AT('limit_to_group'); ?><br />
        <?php
            //show groups
            //get groups currently allowed
            $current_groups = array();

            $sql    = "SELECT group_id FROM %stests_groups WHERE test_id=%d";
            $rows_tgroups    = queryDB($sql, array(TABLE_PREFIX, $this->tid));
            
            foreach($rows_tgroups as $row){
                $current_groups[] = $row['group_id'];
            }

            //show groups
            $sql    = "SELECT * FROM %sgroups_types WHERE course_id=%d ORDER BY title";
            $rows_groups = queryDB($sql, array(TABLE_PREFIX, $_SESSION['course_id']));
            
            if(count($rows_groups) > 0){
                foreach($rows_groups as $row){
                    echo '<strong>'.$row['title'].'</strong><br />';

                    $sql    = "SELECT * FROM %sgroups WHERE type_id=%d ORDER BY title";
                    $g_result = queryDB($sql, array(TABLE_PREFIX, $row['type_id']));
                    
                    foreach($g_result as $grow){
                        echo '&nbsp;<label><input type="checkbox" value="'.$grow['group_id'].'" name="groups['.$grow['group_id'].']" '; 
                        if (is_array($current_groups) && in_array($grow['group_id'], $current_groups)) {
                            echo 'checked="checked"';
                        }
                        echo '/>'.$grow['title'].'</label><br />';
                    }
                }
            } else {
                echo _AT('none_found');
            }
        ?>
    </div>

    <div class="row">
        <label for="inst"><?php echo _AT('instructions'); ?></label><br />
        <textarea name="instructions" cols="35" rows="3" id="inst"><?php echo htmlspecialchars($_POST['instructions']); ?></textarea>
    </div>

    <div class="row buttons">
        <input type="submit" value="<?php echo _AT('save'); ?>" name="submit" accesskey="s" />
        <input type="submit" value="<?php echo _AT('cancel'); ?>" name="cancel" />
    </div>
    </fieldset>
</div>
</form>