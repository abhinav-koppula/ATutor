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

function get_all_students()
{
    global $system_courses;
    $course_id = $_SESSION['course_id'];
    $instructor_id = $system_courses[$course_id]['member_id'];
    //show students enrolled
    $sql = "SELECT CE.member_id, CE.privileges, CE.approved, M.login, M.first_name, M.second_name, M.last_name, M.email 
            FROM ".TABLE_PREFIX."course_enrollment CE INNER JOIN ".TABLE_PREFIX."members M USING (member_id)
            WHERE CE.course_id=$course_id AND approved='y' AND M.member_id<>$instructor_id AND CE.privileges=0  
            ORDER BY M.first_name ASC, M.last_name ASC";
    $students = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, $course_id, $instructor_id));
    
    return $students;
}

function get_student_options() {
    $students = get_all_students();
    $options = "";
    if(count($students) > 0) {
        foreach($students as $student) {
            $options.="<option value='".$student['member_id']."' name='".$student['member_id']."' >".$student['first_name']."&nbsp".$student['last_name']." </option>";
        }
    } else {
        $options.="<optgroup label='"._AT('none_found')."'></optgroup>";
    }
    return $options;
}

function get_group_options()
{
    //show groups
            $sql    = "SELECT * FROM %sgroups_types WHERE course_id=%d ORDER BY title";
            $rows_groups = queryDB($sql, array(TABLE_PREFIX, $_SESSION['course_id']));
            $options = "";
            if(count($rows_groups) > 0){
                foreach($rows_groups as $row){
                    //$options.="<optgroup label = '".$row['title']."'>";
                    
                    $sql    = "SELECT * FROM %sgroups WHERE type_id=%d ORDER BY title";
                    $g_result = queryDB($sql, array(TABLE_PREFIX, $row['type_id']));
                    
                    foreach($g_result as $grow){
                        $options.="<option value='".$grow['group_id']."' name='groups[".$grow['group_id']."]' >".$grow['title']."</option>";
                    }
                }
            } 
            return $options;
}

function validate_type($type, $type_id)
{
    if($type == 'group') {
        $sql    = "SELECT * FROM %sgroups_types WHERE course_id=%d ORDER BY title";
        $rows_groups = queryDB($sql, array(TABLE_PREFIX, $_SESSION['course_id']));
        foreach($rows_groups as $row)
        {
            $sql    = "SELECT * FROM %sgroups WHERE type_id=%d";
            $g_result = queryDB($sql, array(TABLE_PREFIX, $row['type_id']));
            foreach($g_result as $grow) {
                if($grow['group_id'] == $type_id) {
                    return true;
                }
            }
        }
    } else if($type == 'student') {
        $students = get_all_students();
        foreach($students as $student)
        {
            if($student['member_id'] == $type_id) {
                return true;
            }
        }
    }
    return false;
}

function convert_hhmmss_to_duration($hours, $mins, $secs)
{
    return intval($hours) * 3600 + intval($mins) * 60 + intval($secs);
}

function convert_duration_to_hhmmss($duration, &$hours, &$mins, &$secs)
{
    $hours = (int)($duration/3600);
    $mins = (int)(($duration % 3600)/60);
    $secs = ($duration)%60;
}
?>