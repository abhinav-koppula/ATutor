<?php
/****************************************************************/
/* ATutor                                                       */
/****************************************************************/
/* Copyright (c) 2002-2014                                      */
/* Inclusive Design Institute                                   */
/* http://atutor.ca                                             */
/*                                                              */
/* This program is free software. You can redistribute it and/or*/
/* modify it under the terms of the GNU General Public License  */
/* as published by the Free Software Foundation.                */
/****************************************************************/
// $Id$

$page = 'tests';
define('AT_INCLUDE_PATH', '../../../include/');
require(AT_INCLUDE_PATH.'vitals.inc.php');
require(AT_INCLUDE_PATH.'../mods/_standard/tests/lib/test_result_functions.inc.php');
require(AT_INCLUDE_PATH.'../mods/_standard/tests/lib/test_custom_duration_functions.inc.php');
$_custom_head .= '<script type="text/javascript" src="'.AT_BASE_HREF.'mods/_standard/tests/js/tests.js"></script>';

authenticate(AT_PRIV_TESTS);
tool_origin();

$tid = intval($_REQUEST['tid']);

if (isset($_POST['cancel'])) {
    $msg->addFeedback('CANCELLED');
        $return_url = $_SESSION['tool_origin']['url'];
        tool_origin('off');
		header('Location: '.$return_url);
		exit;
} else if (isset($_POST['submit'])) {
    $missing_fields                = array();
    $_POST['title']                = trim($_POST['title']);
    $_POST['description']          = trim($_POST['description']);
    $_POST['passfeedback']         = trim($_POST['passfeedback']);
    $_POST['failfeedback']         = trim($_POST['failfeedback']);
    $_POST['num_questions']        = intval($_POST['num_questions']);
    $_POST['num_takes']            = intval($_POST['num_takes']);
    $_POST['content_id']           = intval($_POST['content_id']);
    $_POST['passpercent']          = intval($_POST['passpercent']);
    $_POST['passscore']            = intval($_POST['passscore']);
    $_POST['anonymous']            = intval($_POST['anonymous']);
    $_POST['allow_guests']         = $_POST['allow_guests'] ? 1 : 0;
    $_POST['show_guest_form']      = $_POST['show_guest_form'] ? 1 : 0;
    $_POST['instructions']         = $addslashes(trim($_POST['instructions']));
    $_POST['display']              = intval($_POST['display']);
    $_POST['remedial_content']     = intval($_POST['remedial_content']);
    $_POST['timed_test']           = intval($_POST['timed_test']);

    // currently these options are ignored for tests:
    $_POST['result_release']       = intval($_POST['result_release']); 
    $_POST['format']               = intval($_POST['format']);
    $_POST['order']                = 1;  //intval($_POST['order']);
    $_POST['difficulty']           = 0;  //intval($_POST['difficulty']);     /* avman */
        
    if ($_POST['title'] == '') {
        $missing_fields[] = _AT('title');
    }

    if ($_POST['random'] && !$_POST['num_questions']) {
        $missing_fields[] = _AT('num_questions_per_test');
    }

    if($_POST['timed_test']) {
        if(!$_POST['timed_test_hours'] && !$_POST['timed_test_minutes'] && !$_POST['timed_test_seconds']) {
            $missing_fields[] = _AT('timed_test_duration_zero');
        }
        
        if($_POST['timed_test_hours'] < 0 || $_POST['timed_test_minutes'] < 0 || $_POST['timed_test_seconds'] < 0 ) {
            $missing_fields[] = _AT('timed_test_duration_negative');
        }
        
    }
    
    $custom_student_array = array();
    $custom_group_array = array();
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
            
            if($type == 'group') {
                $sql = "SELECT member_id FROM %sgroups_members WHERE group_id = %d";
                $member_rows = queryDB($sql, array(TABLE_PREFIX, $type_id));
                foreach($member_rows as $member_row) {
                    array_push($custom_group_array, $member_row['member_id']);
                }
            } else if($type == 'student') {
                array_push($custom_student_array, $type_id);
            }
            
            if($type != -1 && $type_id != -1 && ($custom_duration_hours == 0  && $custom_duration_minutes == 0 && $custom_duration_seconds == 0) )
            $missing_fields[] = _AT('test_custom_duration_zero');
            
            if($type != -1 && $type_id != -1 && ($custom_duration_hours < 0  || $custom_duration_minutes < 0 || $custom_duration_seconds < 0) )
            $missing_fields[] = _AT('test_custom_duration_negative');
        }
    }
    $common_students = array_intersect($custom_group_array, $custom_student_array);
    if(count($common_students) > 0) {
        $missing_fields[] = _AT('duplicate_custom_duration');
    }
    
    if ($_POST['pass_score']==1 && !$_POST['passpercent']) {
        $missing_fields[] = _AT('percentage_score');
    }

    if ($_POST['pass_score']==2 && !$_POST['passscore']) {
        $missing_fields[] = _AT('points_score');
    }
    
    /* 
     * If test is anonymous and have submissions, then we don't permit changes.
     * This addresses the following issue: http://www.atutor.ca/atutor/mantis/view.php?id=3268
     * TODO:    Add an extra column in test_results to remember the state of anonymous submissions.
     *            make changes accordingly on line 255 as well.
     */
    $sql = "SELECT t.test_id, anonymous FROM %stests_results r NATURAL JOIN %stests t WHERE r.test_id = t.test_id AND r.test_id=%d";
    $row_anonymous    = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, $tid));

    if(count($row_anonymous) > 0){
        //If there are submission(s) for this test, anonymous field will not be altered.
        $_POST['anonymous'] = $row_anonymous[0]['anonymous'];
    }
    
    if ($missing_fields) {
        $missing_fields = implode(', ', $missing_fields);
        $msg->addError(array('EMPTY_FIELDS', $missing_fields));
    }

    $day_start    = intval($_POST['day_start']);
    $month_start  = intval($_POST['month_start']);
    $year_start   = intval($_POST['year_start']);
    $hour_start   = intval($_POST['hour_start']);
    $min_start    = intval($_POST['min_start']);

    $day_end      = intval($_POST['day_end']);
    $month_end    = intval($_POST['month_end']);
    $year_end     = intval($_POST['year_end']);
    $hour_end     = intval($_POST['hour_end']);
    $min_end      = intval($_POST['min_end']);

    if (!checkdate($month_start, $day_start, $year_start)) {
        $msg->addError('START_DATE_INVALID');
    }

    if (!checkdate($month_end, $day_end, $year_end)) {
        $msg->addError('END_DATE_INVALID');
    }

    if (mktime($hour_end,   $min_end,   0, $month_end,   $day_end,   $year_end) < 
        mktime($hour_start, $min_start, 0, $month_start, $day_start, $year_start)) {
            $msg->addError('END_DATE_INVALID');
    }

    if (!$msg->containsErrors()) {
                    
        if ($_POST['timed_test']) {
            $timed_test_duration = convert_hhmmss_to_duration($_POST['timed_test_hours'], $_POST['timed_test_minutes'], $_POST['timed_test_seconds']);
        } else {
            $timed_test_duration = 0;
        }
            
        if (strlen($month_start) == 1){
            $month_start = "0$month_start";
        }
        if (strlen($day_start) == 1){
            $day_start = "0$day_start";
        }
        if (strlen($hour_start) == 1){
            $hour_start = "0$hour_start";
        }
        if (strlen($min_start) == 1){
            $min_start = "0$min_start";
        }
        if (strlen($month_end) == 1){
            $month_end = "0$month_end";
        }
        if (strlen($day_end) == 1){
            $day_end = "0$day_end";
        }
        if (strlen($hour_end) == 1){
            $hour_end = "0$hour_end";
        }
        if (strlen($min_end) == 1){
            $min_end = "0$min_end";
        }

        $start_date = "$year_start-$month_start-$day_start $hour_start:$min_start:00";
        $end_date    = "$year_end-$month_end-$day_end $hour_end:$min_end:00";

        //If title exceeded database defined length, truncate it.
        $_POST['title'] = validate_length($_POST['title'], 100);
        
        //create test page
        if($tid == 0) {
            $sql = "INSERT INTO %stests " .
                    "(test_id,
                    course_id,
                    title,
                    description,
                    format,
                    start_date,
                    end_date,
                    randomize_order,
                    num_questions,
                    instructions,
                    content_id,
                    passscore,
                    passpercent,
                    passfeedback,
                    failfeedback,
                    result_release,
                    random,
                    difficulty,
                    num_takes,
                    anonymous,
                    out_of,
                    guests,
                    display,
                    show_guest_form,
                    remedial_content,
                    timed_test,
                    timed_test_duration)" .
                    "VALUES 
                    (NULL, %d, '%s', '%s', %d, '%s', '%s', %d, %d, '%s', %d, %d, %d, '%s', '%s', %d, %d, %d, %d, %d, '', %d, %d, %d, %d, %d, %d)";
            
            $result = queryDB($sql, array(
                    TABLE_PREFIX,
                    $_SESSION[course_id],
                    $_POST['title'],
                    $_POST['description'],
                    $_POST['format'],
                    $start_date,
                    $end_date,
                    $_POST['order'],
                    $_POST['num_questions'],
                    $_POST['instructions'],
                    $_POST['content_id'],
                    $_POST['passscore'],
                    $_POST['passpercent'],
                    $_POST['passfeedback'],
                    $_POST['failfeedback'],
                    $_POST['result_release'],
                    $_POST['random'],
                    $_POST['difficulty'],
                    $_POST['num_takes'],
                    $_POST['anonymous'],
                    $_POST['allow_guests'],
                    $_POST['display'],
                    $_POST['show_guest_form'],
                    $_POST['remedial_content'],
                    $_POST['timed_test'],
                    $timed_test_duration));
            $tid = at_insert_id();
        
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
                
                    $sql =  "INSERT INTO %stests_custom_duration ".
                            "(id,
                              test_id,
                            type,
                            type_id,
                            custom_duration)".
                            "VALUES (NULL, %d, '%s', %d, %d)";
                    if($tid && $type != -1 && $type_id!=-1 && validate_type($type, $type_id)) { 
                        $result = queryDB($sql, array(TABLE_PREFIX, $tid, $type, $type_id, $custom_duration));
                    }
                }
            }
        
            if (isset($_POST['groups']) && $tid) {

                $sql = "INSERT INTO %stests_groups VALUES ";
            
                foreach ($_POST['groups'] as $group) {
                    $group = intval($group);
                    $sql .= "($tid, $group),";
                }
                $sql = substr($sql, 0, -1);

                $result = queryDB($sql, array(TABLE_PREFIX));
            }

            $msg->addFeedback('ACTION_COMPLETED_SUCCESSFULLY');
            header('Location: index.php');
            exit;
        } else { //edit test page
            // just to make sure we own this test:
            $sql    = "SELECT * FROM %stests WHERE test_id=%d AND course_id=%d";
            $row_tests    = queryDB($sql, array(TABLE_PREFIX, $tid, $_SESSION['course_id']), TRUE);
            if(count($row_tests) > 0){
                if ($_POST['random']) {
                    $total_weight = get_total_weight($tid, $_POST['num_questions']);
                } else {
                    $total_weight = get_total_weight($tid);
                }
            }
            $sql = "UPDATE %stests " . 
                   "SET title='%s', 
                        description='%s', 
                        format=%d, 
                        start_date='%s', 
                        end_date='%s', 
                        randomize_order=%d, 
                        num_questions=%d, 
                        instructions='%s', 
                        content_id=%d,  
                        passscore=%d, 
                        passpercent=%d, 
                        passfeedback='%s', 
                        failfeedback='%s', 
                        result_release=%d, 
                        random=%d, 
                        difficulty=%d, 
                        num_takes=%d, 
                        anonymous=%d, 
                        guests=%d, 
                        show_guest_form=%d,
                        out_of=%d, 
                        display=%d,
                        remedial_content=%d,
                        timed_test=%d,
                        timed_test_duration=%d
                    WHERE test_id=%d 
                    AND course_id=%d";
            
            $result = queryDB($sql, array(
                        TABLE_PREFIX,
                        $_POST['title'],
                        $_POST['description'],
                        $_POST['format'],
                        $start_date,
                        $end_date,
                        $_POST['randomize_order'],
                        $_POST['num_questions'],
                        $_POST['instructions'],
                        $_POST['content_id'],
                        $_POST['passscore'],
                        $_POST['passpercent'],
                        $_POST['passfeedback'],
                        $_POST['failfeedback'],
                        $_POST['result_release'],
                        $_POST['random'],
                        $_POST['difficulty'],
                        $_POST['num_takes'],
                        $_POST['anonymous'],
                        $_POST['allow_guests'],
                        $_POST['show_guest_form'],
                        $total_weight,
                        $_POST['display'],
                        $_POST['remedial_content'],
                        $_POST['timed_test'],
                        $timed_test_duration,
                        $tid,
                        $_SESSION['course_id']));
            
            $sql = "DELETE FROM %stests_custom_duration WHERE test_id=%d";
            $result = queryDB($sql, array(TABLE_PREFIX, $tid));
            
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
                
                    $sql =  "INSERT INTO %stests_custom_duration ".
                            "(id,
                              test_id,
                            type,
                            type_id,
                            custom_duration)".
                            "VALUES (NULL, %d, '%s', %d, %d)";
                    if($tid && $type != -1 && $type_id!=-1 && validate_type($type, $type_id)) { 
                        $result = queryDB($sql, array(TABLE_PREFIX, $tid, $type, $type_id, $custom_duration));
                    }
                }
            }
            
            $sql = "DELETE FROM %stests_groups WHERE test_id=%d";
            $result = queryDB($sql, array(TABLE_PREFIX, $tid));
            
            if (isset($_POST['groups'])) {
                $sql = "INSERT INTO %stests_groups VALUES ";
                foreach ($_POST['groups'] as $group) {
                    $group = intval($group);
                    $sql .= "($tid, $group),";
                }
                $sql = substr($sql, 0, -1);
                $result = queryDB($sql, array(TABLE_PREFIX));
            }
            
            $msg->addFeedback('ACTION_COMPLETED_SUCCESSFULLY');

            header('Location: index.php');
            exit;
        }
    }
}

if (isset($_POST['num_questions']) && ($_POST['num_questions'] === 0)) {
    $_POST['num_questions'] = '';
}

$onload = 'document.form.title.focus();';

require(AT_INCLUDE_PATH.'header.inc.php');

if ($tid>0 && !isset($_POST['submit'])) {
    $sql    = "SELECT *, DATE_FORMAT(start_date, '%%Y-%%m-%%d %%H:%%i:00') AS start_date, DATE_FORMAT(end_date, '%%Y-%%m-%%d %%H:%%i:00') AS end_date FROM %stests WHERE test_id=%d AND course_id=%d";
    $row    = queryDB($sql, array(TABLE_PREFIX, $tid, $_SESSION['course_id']), TRUE);
    
    if(count($row) == 0){
        $msg->printErrors('ITEM_NOT_FOUND');
        require (AT_INCLUDE_PATH.'footer.inc.php');
        exit;
    }

    $_POST    = $row;
    $_POST['allow_guests'] = $row['guests'];
    convert_duration_to_hhmmss($row['timed_test_duration'], $_POST['timed_test_hours'], $_POST['timed_test_minutes'], $_POST['timed_test_seconds']);
    
    $sql = "SELECT * FROM %stests_custom_duration WHERE test_id=%d";
    $rows = queryDB($sql, array(TABLE_PREFIX, $tid));
    if(count($rows) > 0) {
        $id = 0;
        foreach($rows as $row) {
            $_POST['custom_duration_type_'.$id] = $row['type'];
            $_POST['custom_duration_options_'.$id] = $row['type_id'];
            $hours = 0; $mins = 0; $secs = 0;
            convert_duration_to_hhmmss($row['custom_duration'], $hours, $mins, $secs);
            $_POST['custom_duration_hours_'.$id] = $hours;
            $_POST['custom_duration_minutes_'.$id] = $mins;
            $_POST['custom_duration_seconds_'.$id] = $secs;
            $id++;
        }
    }
} else {
    $_POST['start_date']   = $start_date;
    $_POST['end_date']     = $end_date;
}

$msg->printErrors();

$savant->assign('tid', $tid);

$savant->assign('day_start', $day_start);
$savant->assign('month_start', $month_start);
$savant->assign('year_start', $year_start);
$savant->assign('hour_start', $hour_start);
$savant->assign('min_start', $min_start);

$savant->assign('day_end', $day_end);
$savant->assign('month_end', $month_end);
$savant->assign('year_end', $year_end);
$savant->assign('hour_end', $hour_end);
$savant->assign('min_end', $min_end);

$savant->display('create_test.tmpl.php');

?>
<script type="text/javascript">
    ATutor.mods.tests.create_test.custom_duration_row_id = 0;
    
    ATutor.mods.tests.create_test.get_options = function(type) {
        console.log(type);
        if(type == 'group') {
            options = "<?php echo get_group_options(); ?>";
        } else if(type == 'student') {
            options = "<?php echo get_student_options(); ?>";
        }
        return options;
    }
    (function( $ ) {
        $.widget( "custom.combobox", {
            _create: function() {
                this.wrapper = $( "<span>" )
                .addClass( "custom-combobox" )
                .insertAfter( this.element );
 
                this.element.hide();
                this._createAutocomplete();
                this._createShowAllButton();
            },
 
            _createAutocomplete: function() {
                var selected = this.element.children( ":selected" ),
                value = selected.val() ? selected.text() : "";
 
                this.input = $( "<input>" )
                .appendTo( this.wrapper )
                .val( value )
                .attr( "title", "" )
                .addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
                .autocomplete({
                    delay: 0,
                    minLength: 0,
                    source: $.proxy( this, "_source" )
                })
                .tooltip({
                    tooltipClass: "ui-state-highlight"
                });
 
                this._on( this.input, {
                    autocompleteselect: function( event, ui ) {
                        ui.item.option.selected = true;
                        this._trigger( "select", event, {
                            item: ui.item.option
                        });
                        },
 
                    autocompletechange: "_removeIfInvalid"
                });
            },
 
            _createShowAllButton: function() {
                var input = this.input,
                wasOpen = false;
 
                $( "<a>" )
                .attr( "tabIndex", -1 )
                .attr( "title", "Show All Items" )
                .tooltip()
                .appendTo( this.wrapper )
                .button({
                    icons: {
                        primary: "ui-icon-triangle-1-s"
                    },
                    text: false
                })
                .removeClass( "ui-corner-all" )
                .addClass( "custom-combobox-toggle ui-corner-right" )
                .mousedown(function() {
                    wasOpen = input.autocomplete( "widget" ).is( ":visible" );
                })
                .click(function() {
                    input.focus();
 
                    // Close if already visible
                    if ( wasOpen ) {
                        return;
                    }
 
                    // Pass empty string as value to search for, displaying all results
                    input.autocomplete( "search", "" );
                });
            },
 
            _source: function( request, response ) {
                var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
                response( this.element.children( "option" ).map(function() {
                    var text = $( this ).text();
                    if ( this.value && ( !request.term || matcher.test(text) ) )
                    return {
                        label: text,
                        value: text,
                        option: this
                    };
                }) );
            },
 
            _removeIfInvalid: function( event, ui ) {
 
                // Selected an item, nothing to do
                if ( ui.item ) {
                    return;
                }
 
                // Search for a match (case-insensitive)
                var value = this.input.val(),
                valueLowerCase = value.toLowerCase(),
                valid = false;
                this.element.children( "option" ).each(function() {
                    if ( $( this ).text().toLowerCase() === valueLowerCase ) {
                        this.selected = valid = true;
                        return false;
                    }
                });
 
                // Found a match, nothing to do
                if ( valid ) {
                    return;
                }
 
                // Remove invalid value
                this.input
                .val( "" )
                .attr( "title", value + " didn't match any item" )
                .tooltip( "open" );
                this.element.val( "" );
                this._delay(function() {
                    this.input.tooltip( "close" ).attr( "title", "" );
                }, 2500 );
                this.input.data( "ui-autocomplete" ).term = "";
            },
 
            _destroy: function() {
                this.wrapper.remove();
                this.element.show();
            }
        });
    })( jQuery );
    
    $(document).ready(function(){
        $('#delete_custom_duration_row').click(function(){
            $('#custom_duration').find('.selected').remove();
        });
        $('#add_custom_duration_row').click(function(){ 
            ATutor.mods.tests.create_test.add_custom_duration_row(ATutor.mods.tests.create_test.custom_duration_row_id++);
        });
        
        ATutor.mods.tests.create_test.add_custom_duration_row(ATutor.mods.tests.create_test.custom_duration_row_id++);
        
    });
</script>
<?php require (AT_INCLUDE_PATH.'footer.inc.php'); ?>