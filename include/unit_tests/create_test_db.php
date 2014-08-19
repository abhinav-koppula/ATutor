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
require_once (AT_INCLUDE_PATH. 'unit_tests/classes/TestDBHelper.class.php');
require_once (AT_INCLUDE_PATH. '../mods/_standard/tests/lib/test_db_helper_functions.inc.php');

class CreateTestDb extends PHPUnit_Framework_TestCase {
    protected $post_array, $db_helper;
    public function setUp() {
        
        $this->db_helper = new DBHelper();
        $this->db_helper->setUp();
        
        $this->post_array = array();
        $this->post_array['title'] = 'Test Title';
        $this->post_array['description'] = 'Test Description';
        $this->post_array['format'] = 0;
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
        $this->post_array['order']  = 1;
        $this->post_array['num_questions'] = '';
        $this->post_array['instructions'] = 'Test Instructions';
        $this->post_array['content_id'] = '';
        $this->post_array['passscore'] = 0;
        $this->post_array['passpercent'] = 0;
        $this->post_array['passfeedback'] = 'Test Pass Feedback';
        $this->post_array['failfeedback'] = 'Test Fail Feedback';
        $this->post_array['result_release'] = 0;
        $this->post_array['random'] = 0;
        $this->post_array['difficulty']  = 0;
        $this->post_array['num_takes'] = 0;
        $this->post_array['anonymous'] = 0;
        $this->post_array['allow_guests'] = 0;
        $this->post_array['display'] = 0;
        $this->post_array['show_guest_form'] = 0;
        $this->post_array['remedial_content'] = 0;
        
        $this->post_array['timed_test'] = 1;
        $this->post_array['timed_test_hours'] = 1;
        $this->post_array['timed_test_minutes'] = 30;
        $this->post_array['timed_test_seconds'] = 0;
        
        $this->post_array['timed_test_normal_mode'] = '60';
        $this->post_array['timed_test_intermediate_mode'] = '30';
        $this->post_array['timed_test_emergency_mode'] = '10';
        
        $this->post_array['submit'] = 'Save';
        $this->post_array['pass_score'] = 0;
    }
    
    public function test_create_test() {
        $_SESSION['course_id'] = 1;
        $tables = array('tests');
        $insert_id = create_test($this->post_array);
        
        $sql = "SELECT * FROM %stests WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $insert_id));
        $expected_row = array(
                        'test_id' => '1', 
                        'course_id' => '1', 
                        'title' => 'Test Title', 
                        'format' => '0', 
                        'start_date' => '2014-08-15 12:00:00', 
                        'end_date' => '2014-08-15 12:00:00',
                        'randomize_order' => '1',
                        'num_questions' => '0',
                        'instructions' => 'Test Instructions',
                        'content_id' => '0',
                        'result_release' => '0',
                        'random' => '0',
                        'difficulty' => '0',
                        'num_takes' => '0',
                        'anonymous' => '0',
                        'out_of' => '',
                        'guests' => '0',
                        'display' => '0',
                        'description' => 'Test Description',
                        'passscore' => '0',
                        'passpercent' => '0',
                        'passfeedback' => 'Test Pass Feedback',
                        'failfeedback' => 'Test Fail Feedback',
                        'show_guest_form' => '0',
                        'remedial_content' => '0',
                        'timed_test' => '1',
                        'timed_test_duration' => '5400',
                        'timed_test_normal_mode' => '60',
                        'timed_test_intermediate_mode' => '30',
                        'timed_test_emergency_mode' => '10',
                        );
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    public  function test_insert_custom_duration_fields() {
        $_SESSION['course_id'] = 1;
        $id = 0;
        $tid = 1;
        $table1 = array('tests_custom_duration');
        $this->post_array['custom_duration_type_'.$id] = 'group';
        $this->post_array['custom_duration_options_'.$id] = '1';
        $this->post_array['custom_duration_hours_'.$id] = '1';
        $this->post_array['custom_duration_minutes_'.$id] = '30';
        $this->post_array['custom_duration_seconds_'.$id] = '20';
        
        $table2 = $this->db_helper->seed_groups();
        $tables = array_merge($table1, $table2);
        
        insert_custom_duration_fields($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_custom_duration WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        $expected_row = array(
                        'id' => '1',
                        'test_id' => $tid,
                        'type' => 'group',
                        'type_id' => '1',
                        'custom_duration' => '5420'
                        );
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    public function test_insert_test_for_groups() {
        $this->post_array['groups'] = array('1','2');
        $tid = 1;
        $tables = array('tests_groups');
        insert_test_for_groups($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_groups WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        $expected_row = array(
                        0=>array('test_id' => '1', 'group_id' => '1'),
                        1=>array('test_id' => '1', 'group_id' => '2')
                        );
        $this->assertEquals($expected_row, $actual_row);
        $this->db_helper->truncate($tables);
    }
    
    public function test_edit_test() {
        $_SESSION['course_id'] = 1;
        $tid = create_test($this->post_array);
        $tables = array('tests');
        //Setup parameters you want to modify
        $this->post_array['title'] = 'Updated Title';
        $this->post_array['description'] = 'Updated Description';
        
        edit_test($this->post_array, $tid, 10);
        $sql = "SELECT * FROM %stests WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        $expected_row = array(
                        'test_id' => '1', 
                        'course_id' => '1', 
                        'title' => 'Updated Title', 
                        'format' => '0', 
                        'start_date' => '2014-08-15 12:00:00', 
                        'end_date' => '2014-08-15 12:00:00',
                        'randomize_order' => '1',
                        'num_questions' => '0',
                        'instructions' => 'Test Instructions',
                        'content_id' => '0',
                        'result_release' => '0',
                        'random' => '0',
                        'difficulty' => '0',
                        'num_takes' => '0',
                        'anonymous' => '0',
                        'out_of' => '10',
                        'guests' => '0',
                        'display' => '0',
                        'description' => 'Updated Description',
                        'passscore' => '0',
                        'passpercent' => '0',
                        'passfeedback' => 'Test Pass Feedback',
                        'failfeedback' => 'Test Fail Feedback',
                        'show_guest_form' => '0',
                        'remedial_content' => '0',
                        'timed_test' => '1',
                        'timed_test_duration' => '5400',
                        'timed_test_normal_mode' => '60',
                        'timed_test_intermediate_mode' => '30',
                        'timed_test_emergency_mode' => '10',
                        );
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    public function test_edit_custom_duration_fields() {
        $_SESSION['course_id'] = 1;
        $id = 0;
        $tid = 1;
        $table1 = array('tests_custom_duration');
        $this->post_array['custom_duration_type_'.$id] = 'group';
        $this->post_array['custom_duration_options_'.$id] = '1';
        $this->post_array['custom_duration_hours_'.$id] = '1';
        $this->post_array['custom_duration_minutes_'.$id] = '30';
        $this->post_array['custom_duration_seconds_'.$id] = '20';
        $table2 = $this->db_helper->seed_groups();
        $tables = array_merge($table1, $table2);
        insert_custom_duration_fields($this->post_array, $tid);
        
        $this->post_array['custom_duration_type_'.$id] = 'group';
        $this->post_array['custom_duration_options_'.$id] = '1';
        $this->post_array['custom_duration_hours_'.$id] = '1';
        $this->post_array['custom_duration_minutes_'.$id] = '10';
        $this->post_array['custom_duration_seconds_'.$id] = '10';
        edit_custom_duration_fields($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_custom_duration WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        $expected_row = array(
                        'id' => '1',
                        'test_id' => $tid,
                        'type' => 'group',
                        'type_id' => '1',
                        'custom_duration' => '4210'
                        );
        //Unsetting 'id' as edit would do a delete followed by insert thus making id irrelevant
        unset($actual_row[0]['id']); unset($expected_row['id']);
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    public function test_edit_test_for_groups() {
        $this->post_array['groups'] = array('1','2');
        $tid = 1;
        $tables = array('tests_groups');
        insert_test_for_groups($this->post_array, $tid);
        $this->post_array['groups'] = array('3');
        edit_test_for_groups($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_groups WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        $expected_row = array(
                        0=>array('test_id' => '1', 'group_id' => '3')
                        );
        $this->assertEquals($expected_row, $actual_row);
        $this->db_helper->truncate($tables);
    }
}
?>
