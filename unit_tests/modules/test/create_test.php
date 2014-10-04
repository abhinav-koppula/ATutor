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
require_once (AT_INCLUDE_PATH. '../mods/_standard/tests/lib/test_helper_functions.inc.php');

class CreateTest extends PHPUnit_Framework_TestCase {
    
    protected $post_array;
    
    //Dummy post array is used in all tests except the functional test(test_check_missing_fields)
    public static $dummy_post_array = array();
    protected function setUp() {
        $path = AT_INCLUDE_PATH ."../unit_tests/modules/test/data/create_test/";
        $input_string = file_get_contents($path."dummy_post_array.json");
        CreateTest::$dummy_post_array = json_decode($input_string,true);
        $this->post_array = CreateTest::$dummy_post_array;
    }
    
    /**
    * @param $post_array
    * @param $custom_group_array
    * @param $expected_missing_fields
    *
    * @dataProvider check_missing_fields_provider
    */
    public function test_check_missing_fields($post_array, $custom_group_array, $expected_missing_fields) {       
        $actual_missing_fields = check_missing_fields($post_array, $custom_group_array);
        $this->assertEquals($expected_missing_fields, $actual_missing_fields);
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
    
    public static function provider_helper($test_name) {
        $path = AT_INCLUDE_PATH ."../unit_tests/modules/test/data/create_test/";
        $test_cases_string = file_get_contents($path.$test_name.".json");
        $test_cases = json_decode($test_cases_string, TRUE);
        
        $return_array = array();
        foreach($test_cases as $test_case) {
            $return_array[] = array($test_case['input'], $test_case['custom_group_array'], $test_case['expected']);
        }
        
        return $return_array;
    }
    
    public static function check_missing_fields_provider() {
        return CreateTest::provider_helper('check_missing_fields');
    }
}
?>
