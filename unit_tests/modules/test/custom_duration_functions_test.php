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

if (!defined('AT_INCLUDE_PATH')) {
    define('AT_INCLUDE_PATH', '../include/');
}
require_once ('classes/TestDBHelper.class.php');
require_once (AT_INCLUDE_PATH. '../mods/_standard/tests/lib/test_custom_duration_functions.inc.php');

class CustomDurationFunctionsTest extends PHPUnit_Framework_TestCase {
    protected $db_helper;
    
    public function setUp() {
        $this->db_helper = new DBHelper();
        $this->db_helper->setUp();
    }
    
    public function tearDown() {
        $this->db_helper->truncate_all();
    }
    
    public function test_validate_type_group() {
        /* Start setup for this test */
        $tables = $this->db_helper->seed_groups();
        $_SESSION['course_id'] = 1;
        /* End setup for this test */
        
        $expected = true;
        $actual = validate_type('group', 2);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_get_all_students() {
        /*Start setup for this test */
        $course_id = 0;
        $table1 = $this->db_helper->seed_course($course_id);
        $_SESSION['course_id'] = $course_id;
        global $system_courses;
        $system_courses = array();
        $rows = queryDB('SELECT * FROM %scourses ORDER BY title', array(TABLE_PREFIX));
        
        foreach($rows as $row) {
            $course = $row['course_id'];
            unset($row['course_id']);
            $system_courses[$course] = $row;
        }
        $student1 = $student2 = 0;
        $table2 = $this->db_helper->seed_student('student_abhinav', 'student_abhinav@atutor.com', 'Student', 'Abhinav', $student1);
        $expected_students[] = $student1;
        $this->db_helper->enroll_student_into_course($student1, $course_id);
        $table3 = $this->db_helper->seed_student('student_student', 'student_student@atutor.com', 'Student', 'Student', $student2);
        $expected_students[] = $student2;
        $table4 = $this->db_helper->enroll_student_into_course($student2, $course_id);
        $tables = array_merge($table1, $table2, $table3, $table4);
        /* End setup for this test */
        
        $students = get_all_students();
        foreach($students as $s) {
            $actual_students[] = $s['member_id'];
        }
        $this->assertEquals($expected_students, $actual_students);
    }
    
    public function test_convert_hhmmss_to_duration() {
        $hours = 1;
        $mins = 30;
        $secs = 45;
        $expected = (5440);
        $actual = convert_hhmmss_to_duration($hours, $mins, $secs);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_convert_duration_to_hhmmss() {
        $actual_hours = $actual_mins = $actual_secs = 0;
        convert_duration_to_hhmmss(5445, $actual_hours, $actual_mins, $actual_secs);
        $expected_hours = 1;
        $expected_mins = 30;
        $expected_secs = 45;
        $this->assertEquals($expected_hours, $actual_hours);
        $this->assertEquals($expected_mins, $actual_mins);
        $this->assertEquals($expected_secs, $actual_secs);
    }
    
}

?>
