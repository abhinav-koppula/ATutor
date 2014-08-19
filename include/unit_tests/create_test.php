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

define('AT_INCLUDE_PATH' , '../../include/');
require_once (AT_INCLUDE_PATH. '../mods/_standard/tests/lib/test_helper_functions.inc.php');

class CreateTest extends PHPUnit_Framework_TestCase {
    
    protected $post_array;
    
    protected function setUp() {
        $this->post_array = array();
        $this->post_array['title'] = 'Test Title';
        $this->post_array['description'] = 'Test Description';
        $this->post_array['num_takes'] = 1;
        $this->post_array['format'] = 0;
        $this->post_array['anonymous'] = 0;
        $this->post_array['allow_guests'] = 0;
        $this->post_array['display'] = 0;
        $this->post_array['remedial_content'] = 0;
        $this->post_array['pass_score'] = 0;
        $this->post_array['passfeedback'] = '';
        $this->post_array['failfeedback'] = '';
        $this->post_array['result_release'] = 0;
        $this->post_array['random'] = 0; 
        $this->post_array['timed_test'] = 0;
        $this->post_array['custom_duration_type_0'] = 'group';
        $this->post_array['custom_duration_options_0'] = -1;
        $this->post_array['custom_duration_hours_0'] = 0;
        $this->post_array['custom_duration_minutes_0'] = 0;
        $this->post_array['custom_duration_seconds_0'] = 0;
        $this->post_array['day_start'] = 15;
        $this->post_array['month_start'] = 8;
        $this->post_array['year_start'] = 2014;
        $this->post_array['hour_start'] = 12;
        $this->post_array['min_start'] = 0;
        $this->post_array['day_end'] = 15;
        $this->post_array['month_end'] = 8;
        $this->post_array['year_end'] = 2014;
        $this->post_array['hour_end'] = 12;
        $this->post_array['min_end'] = 0;
        $this->post_array['instructions'] = '';
        $this->post_array['submit'] = 'Save';
    }
    
    public function test_check_missing_fields() {
        /* Functional Test to check all validations 
         * Missing Fields = title, timed test duration, negative timed test custom duration, duplicate custom duration, percentage score
         */
        $this->post_array['title'] = '';
        $this->post_array['timed_test'] = 1;
        $this->post_array['timed_test_hours'] = 0;
        $this->post_array['timed_test_minutes'] = 0;
        $this->post_array['timed_test_seconds'] = 0;
        $this->post_array['custom_duration_type_0'] = 'group';
        $this->post_array['custom_duration_options_0'] = 1;
        $this->post_array['custom_duration_hours_0'] = 1;
        $this->post_array['custom_duration_minutes_0'] = 30;
        $this->post_array['custom_duration_seconds_0'] = 0;
        $this->post_array['custom_duration_type_1'] = 'student';
        $this->post_array['custom_duration_options_1'] = 1;
        $this->post_array['custom_duration_hours_1'] = 2;
        $this->post_array['custom_duration_minutes_1'] = 0;
        $this->post_array['custom_duration_seconds_1'] = 0;
        $this->post_array['custom_duration_type_2'] = 'group';
        $this->post_array['custom_duration_options_2'] = 3;
        $this->post_array['custom_duration_hours_2'] = -1;
        $this->post_array['custom_duration_minutes_2'] = -30;
        $this->post_array['custom_duration_seconds_2'] = 0;
        $this->post_array['pass_score'] = 1;
        $this->post_array['passpercent'] = 0;
        $custom_group_array = [1,2,3];
        
        $expected = ['title', 'timed_test_duration_zero', 'test_custom_duration_negative', 'duplicate_custom_duration', 'percentage_score'];
        $actual = check_missing_fields($this->post_array, $custom_group_array);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_push_if_not_empty() {
        $missing_fields = array();
        $expected = ['test for empty'];
        push_if_not_empty($missing_fields, 'test for empty');
        $this->assertEquals($expected, $missing_fields);
    }
    
    public function test_check_missing_title() {
        $this->post_array['title'] = '';
        
        $expected = 'title';
        $actual = check_missing_title($this->post_array);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_missing_num_questions() {
        $this->post_array['random'] = 1;
        $this->post_array['num_questions'] = '';
        
        $expected = 'num_questions_per_test';
        $actual = check_missing_num_questions($this->post_array);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_missing_timed_test_duration() {
        $this->post_array['timed_test'] = 1;
        $this->post_array['timed_test_hours'] = 0;
        $this->post_array['timed_test_minutes'] = 0;
        $this->post_array['timed_test_seconds'] = 0;
        
        $expected = 'timed_test_duration_zero';
        $actual = check_missing_timed_test_duration($this->post_array);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_negative_timed_test_duration() {
        $this->post_array['timed_test'] = 1;
        $this->post_array['timed_test_hours'] = -5;
        $this->post_array['timed_test_minutes'] = -3;
        $this->post_array['timed_test_seconds'] = 45;
        
        $expected = 'timed_test_duration_negative';
        $actual = check_negative_timed_test_duration($this->post_array);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_missing_custom_timed_test_duration() {
        $id = 0;
        $this->post_array['custom_duration_options_'.$id] = 'group';
        
        $expected = 'test_custom_duration_zero';
        $actual = check_missing_custom_timed_test_duration($this->post_array, $id);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_negative_custom_timed_test_duration() {
        $id = 0;
        $this->post_array['custom_duration_options_'.$id] = 'group';
        $this->post_array['custom_duration_hours_0'] = -3;
        $this->post_array['custom_duration_minutes_0'] = -2;
        $this->post_array['custom_duration_seconds_0'] = 0;
        
        $expected = 'test_custom_duration_negative';
        $actual = check_negative_custom_timed_test_duration($this->post_array, $id);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_duplicate_custom_duration() {
        $custom_group_array = [1,2,3];
        $custom_student_array = [2,4,5];
        
        $expected = 'duplicate_custom_duration';
        $actual = check_duplicate_custom_duration($custom_group_array, $custom_student_array);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_percentage_score() {
        $this->post_array['pass_score'] = 1;
        $this->post_array['passpercent'] = 0;
        
        $expected = 'percentage_score';
        $actual = check_percentage_score($this->post_array);
        $this->assertEquals($expected, $actual);
    }
    
    public function test_check_points_score() {
        $this->post_array['pass_score'] = 2;
        $this->post_array['passscore'] = '';
        
        $expected = 'points_score';
        $actual = check_points_score($this->post_array);
        $this->assertEquals($expected, $actual);
    }
}
?>
