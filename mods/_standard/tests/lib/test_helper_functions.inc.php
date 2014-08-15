<?php
/************************************************************************/
/* ATutor                                                               */
/************************************************************************/
/* Copyright (c) 2002-2014                                              */
/* Inclusive Design Institute                                           */
/* http://atutor.ca                                                     */
/* This program is free software. You can redistribute it and/or        */
/* modify it under the terms of the GNU General Public License          */
/* as published by the Free Software Foundation.                        */
/************************************************************************/
// $Id$


function check_missing_fields($post_array, $custom_group_array) {
    $missing_fields = array();
    push_if_not_empty($missing_fields, check_missing_title($post_array));
    push_if_not_empty($missing_fields, check_missing_num_questions($post_array));
    push_if_not_empty($missing_fields, check_missing_timed_test_duration($post_array));
    push_if_not_empty($missing_fields, check_negative_timed_test_duration($post_array));
    $custom_student_array = array();
    
    foreach($post_array as $key => $value)
    {
        if(substr($key, 0, strlen($key)-1) == "custom_duration_type_") {
            $id = substr($key, -1);
            $type = $post_array["custom_duration_type_".$id];
            $type_id = $post_array["custom_duration_options_".$id];
            
            if($type == 'student') {
                array_push($custom_student_array, $type_id);
            }
            
            push_if_not_empty($missing_fields, check_missing_custom_timed_test_duration($post_array, $id));
            push_if_not_empty($missing_fields, check_negative_custom_timed_test_duration($post_array, $id));
        }
    }
    push_if_not_empty($missing_fields, check_duplicate_custom_duration($custom_group_array, $custom_student_array));
    push_if_not_empty($missing_fields, check_percentage_score($post_array));
    push_if_not_empty($missing_fields, check_points_score($post_array));
    
    return $missing_fields;
}

function push_if_not_empty(&$missing_fields, $var) {
    if(!empty($var)) {
        array_push($missing_fields, $var);
    }
}

function check_missing_title($post_array) {
    $missing_field = '';
    if ($post_array['title'] == '') {
        $missing_field = 'title';
    }
    return $missing_field;
}

function check_missing_num_questions($post_array) {
    $missing_field = '';
    if ($post_array['random'] && !$post_array['num_questions']) {
        $missing_field = 'num_questions_per_test';
    }
    return $missing_field;
}

function check_missing_timed_test_duration($post_array) {
    $missing_field = '';
    if($post_array['timed_test']) {
        if(!$post_array['timed_test_hours'] && !$post_array['timed_test_minutes'] && !$post_array['timed_test_seconds']) {
            $missing_field = 'timed_test_duration_zero';
        }
    }
    return $missing_field;
}

function check_negative_timed_test_duration($post_array) {
    $missing_field = '';
    if($post_array['timed_test']) {
        if($post_array['timed_test_hours'] < 0 || $post_array['timed_test_minutes'] < 0 || $post_array['timed_test_seconds'] < 0 ) {
            $missing_field = 'timed_test_duration_negative';
        }
    }
    return $missing_field;
}

function check_missing_custom_timed_test_duration($post_array, $id) {
    $missing_field = '';
    $type = $post_array["custom_duration_type_".$id];
    $type_id = $post_array["custom_duration_options_".$id];
    $custom_duration_hours = $post_array["custom_duration_hours_".$id];
    $custom_duration_minutes = $post_array["custom_duration_minutes_".$id];
    $custom_duration_seconds = $post_array["custom_duration_seconds_".$id];
    if($type != -1 && $type_id != -1 && ($custom_duration_hours == 0  && $custom_duration_minutes == 0 && $custom_duration_seconds == 0)) {
        $missing_field = 'test_custom_duration_zero';
    }
    return $missing_field;
}

function check_negative_custom_timed_test_duration($post_array, $id) {
    $missing_field = '';
    $type = $post_array["custom_duration_type_".$id];
    $type_id = $post_array["custom_duration_options_".$id];
    $custom_duration_hours = $post_array["custom_duration_hours_".$id];
    $custom_duration_minutes = $post_array["custom_duration_minutes_".$id];
    $custom_duration_seconds = $post_array["custom_duration_seconds_".$id];
    if($type != -1 && $type_id != -1 && ($custom_duration_hours < 0  || $custom_duration_minutes < 0 || $custom_duration_seconds < 0)) {
        $missing_field = 'test_custom_duration_negative';
    }
    return $missing_field;
}

function check_duplicate_custom_duration($custom_group_array, $custom_student_array) {
    $missing_field = '';
    $common_students = array_intersect($custom_group_array, $custom_student_array);
    if(count($common_students) > 0) {
        $missing_field = 'duplicate_custom_duration';
    }
    return $missing_field;
}

function check_percentage_score($post_array) {
    $missing_field = '';
    if ($post_array['pass_score']==1 && !$post_array['passpercent']) {
        $missing_field = 'percentage_score';
    }
    return $missing_field;
}

function check_points_score($post_array) {
    $missing_field = '';
    if ($post_array['pass_score']==2 && !$post_array['passscore']) {
        $missing_field = 'points_score';
    }
    return $missing_field;
}

?>
