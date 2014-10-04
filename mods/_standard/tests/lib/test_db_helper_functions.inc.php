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

require_once 'test_custom_duration_functions.inc.php';

function create_edit_test($post_array, $tid) {
    if ($tid == 0) {
        create_test($post_array);
    } else {
        edit_test($post_array, $tid);
    }
}

function get_timed_test_duration($post_array) {
    if ($post_array['timed_test']) {
        $timed_test_duration = convert_hhmmss_to_duration($post_array['timed_test_hours'], $post_array['timed_test_minutes'], $post_array['timed_test_seconds']);
    } else {
        $timed_test_duration = 0;
    }
    return $timed_test_duration;
}

function get_start_date($post_array) {
    $day_start = intval($post_array['day_start']);
    $month_start = intval($post_array['month_start']);
    $year_start = intval($post_array['year_start']);
    $hour_start = intval($post_array['hour_start']);
    $min_start = intval($post_array['min_start']);
    if (strlen($month_start) == 1) {
        $month_start = "0$month_start";
    }
    if (strlen($day_start) == 1) {
        $day_start = "0$day_start";
    }
    if (strlen($hour_start) == 1) {
        $hour_start = "0$hour_start";
    }
    if (strlen($min_start) == 1) {
        $min_start = "0$min_start";
    }
    $start_date = "$year_start-$month_start-$day_start $hour_start:$min_start:00";
    return $start_date;
}

function get_end_date($post_array) {
    $day_end = intval($post_array['day_end']);
    $month_end = intval($post_array['month_end']);
    $year_end = intval($post_array['year_end']);
    $hour_end = intval($post_array['hour_end']);
    $min_end = intval($post_array['min_end']);
    if (strlen($month_end) == 1) {
        $month_end = "0$month_end";
    }
    if (strlen($day_end) == 1) {
        $day_end = "0$day_end";
    }
    if (strlen($hour_end) == 1) {
        $hour_end = "0$hour_end";
    }
    if (strlen($min_end) == 1) {
        $min_end = "0$min_end";
    }
    $end_date = "$year_end-$month_end-$day_end $hour_end:$min_end:00";
    return $end_date;
}

function create_test($post_array) {
    $timed_test_duration = get_timed_test_duration($post_array);
    $start_date = get_start_date($post_array);
    $end_date = get_end_date($post_array);

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
            timed_test_duration,
            timed_test_normal_mode,
            timed_test_intermediate_mode,
            timed_test_emergency_mode)" .
            "VALUES 
            (NULL, %d, '%s', '%s', %d, '%s', '%s', %d, %d, '%s', %d, %d, %d, '%s', '%s', %d, %d, %d, %d, %d, '', %d, %d, %d, %d, %d, %d, %d, %d, %d)";
    $result = queryDB($sql, array(
        TABLE_PREFIX,
        $_SESSION['course_id'],
        $post_array['title'],
        $post_array['description'],
        $post_array['format'],
        $start_date,
        $end_date,
        $post_array['order'],
        $post_array['num_questions'],
        $post_array['instructions'],
        $post_array['content_id'],
        $post_array['passscore'],
        $post_array['passpercent'],
        $post_array['passfeedback'],
        $post_array['failfeedback'],
        $post_array['result_release'],
        $post_array['random'],
        $post_array['difficulty'],
        $post_array['num_takes'],
        $post_array['anonymous'],
        $post_array['allow_guests'],
        $post_array['display'],
        $post_array['show_guest_form'],
        $post_array['remedial_content'],
        $post_array['timed_test'],
        $timed_test_duration,
        $post_array['timed_test_normal_mode'],
        $post_array['timed_test_intermediate_mode'],
        $post_array['timed_test_emergency_mode']));
    $tid = at_insert_id();
    return $tid;
}

function insert_custom_duration_fields($post_array, $tid) {
    foreach ($post_array as $key => $value) {
        if (substr($key, 0, strlen($key) - 1) == "custom_duration_type_") {
            $id = substr($key, -1);
            $type = $post_array["custom_duration_type_" . $id];
            $type_id = $post_array["custom_duration_options_" . $id];
            $custom_duration_hours = $post_array["custom_duration_hours_" . $id];
            $custom_duration_minutes = $post_array["custom_duration_minutes_" . $id];
            $custom_duration_seconds = $post_array["custom_duration_seconds_" . $id];
            $custom_duration = intval($custom_duration_hours) * 3600 + intval($custom_duration_minutes) * 60 + intval($custom_duration_seconds);

            $sql = "INSERT INTO %stests_custom_duration " .
                    "(id,
                      test_id,
                      type,
                      type_id,
                      custom_duration)" .
                    "VALUES (NULL, %d, '%s', %d, %d)";
            if ($tid && $type != -1 && $type_id != -1 && validate_type($type, $type_id)) {
                $result = queryDB($sql, array(TABLE_PREFIX, $tid, $type, $type_id, $custom_duration));
            }
        }
    }
}

function insert_test_for_groups($post_array, $tid) {
    if (isset($post_array['groups']) && $tid) {
        $sql = "INSERT INTO %stests_groups VALUES ";

        foreach ($post_array['groups'] as $group) {
            $group = intval($group);
            $sql .= "($tid, $group),";
        }
        $sql = substr($sql, 0, -1);

        $result = queryDB($sql, array(TABLE_PREFIX));
    }
}

function edit_test($post_array, $tid, $total_weight) {
    $timed_test_duration = get_timed_test_duration($post_array);
    $start_date = get_start_date($post_array);
    $end_date = get_end_date($post_array);

    $sql = "UPDATE %stests SET " .
            "title='%s', 
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
            timed_test_duration=%d,
            timed_test_normal_mode=%d,
            timed_test_intermediate_mode=%d,
            timed_test_emergency_mode=%d
            WHERE test_id=%d 
            AND course_id=%d";

    $result = queryDB($sql, array(
        TABLE_PREFIX,
        $post_array['title'],
        $post_array['description'],
        $post_array['format'],
        $start_date,
        $end_date,
        $post_array['order'],
        $post_array['num_questions'],
        $post_array['instructions'],
        $post_array['content_id'],
        $post_array['passscore'],
        $post_array['passpercent'],
        $post_array['passfeedback'],
        $post_array['failfeedback'],
        $post_array['result_release'],
        $post_array['random'],
        $post_array['difficulty'],
        $post_array['num_takes'],
        $post_array['anonymous'],
        $post_array['allow_guests'],
        $post_array['show_guest_form'],
        $total_weight,
        $post_array['display'],
        $post_array['remedial_content'],
        $post_array['timed_test'],
        $timed_test_duration,
        $post_array['timed_test_normal_mode'],
        $post_array['timed_test_intermediate_mode'],
        $post_array['timed_test_emergency_mode'],
        $tid,
        $_SESSION['course_id']));
}

function edit_custom_duration_fields($post_array, $tid) {
    $sql = "DELETE FROM %stests_custom_duration WHERE test_id=%d";
    $result = queryDB($sql, array(TABLE_PREFIX, $tid));
    insert_custom_duration_fields($post_array, $tid);
}

function edit_test_for_groups($post_array, $tid) {
    $sql = "DELETE FROM %stests_groups WHERE test_id=%d";
    $result = queryDB($sql, array(TABLE_PREFIX, $tid));

    insert_test_for_groups($post_array, $tid);
}

function check_duplicate_custom_duration($post_array) {
    $custom_group_array = array();
    $custom_student_array = array();
    
    foreach($post_array as $key => $value) {
        if(substr($key, 0, strlen($key)-1) == "custom_duration_type_") {
            $id = substr($key, -1);
            $type = $post_array["custom_duration_type_".$id];
            $type_id = $post_array["custom_duration_options_".$id];
            
            if($type == 'group') {
                $custom_group_students_array = array();
                $sql = "SELECT member_id FROM %sgroups_members WHERE group_id = %d";
                $member_rows = queryDB($sql, array(TABLE_PREFIX, $type_id));
                foreach($member_rows as $member_row) {
                    array_push($custom_group_students_array, $member_row['member_id']);
                }
                $map = array($type_id => $custom_group_students_array);
                array_push($custom_group_array, $map);
            } else if($type == 'student') {
                array_push($custom_student_array, $type_id);
            }
        }
    }
    
    $duplicate_fields = array();
    foreach($custom_group_array as $group_members_map) {
        foreach($group_members_map as $group_id => $group_members) {
            $common_students = array_intersect($group_members, $custom_student_array);
        
            if(count($common_students) > 0) {
                foreach($common_students as $student) {   
                    $sql = "SELECT title FROM %sgroups WHERE group_id = %d";
                    $grows = queryDB($sql, array(TABLE_PREFIX, $group_id));
                    $sql = "SELECT first_name, last_name FROM %smembers WHERE member_id = %d";
                    $srows = queryDB($sql, array(TABLE_PREFIX, $student));
                
                    $duplicate_message = $srows[0]['first_name'].' '.$srows[0]['last_name'].' in '.$grows[0]['title'];
                    array_push($duplicate_fields, $duplicate_message);
                }
            }
        }
    }
    return $duplicate_fields;
}
?>
