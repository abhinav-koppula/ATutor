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
    
    //Dummy post array is used in all edit functions to insert dummy data which is 
    //edited/updated by the incoming $edited_post_array parameter
    public static $dummy_post_array = array();
    
    public function setUp() {
        
        $this->db_helper = new DBHelper();
        $this->db_helper->setUp();
        
        $path = AT_INCLUDE_PATH ."/unit_tests/data/create_test_db/";
        $input_string = file_get_contents($path."dummy_post_array.json");
        CreateTestDb::$dummy_post_array = json_decode($input_string,true);
    }
    
    /**
    * @param $post_array
    * @param $expected_row
    * 
    * @dataProvider create_test_provider
    */
    public function test_create_test($post_array, $expected_row) {
        $this->post_array = $post_array;
        $_SESSION['course_id'] = 1;
        $tables = array('tests');
        $insert_id = create_test($this->post_array);
        
        $sql = "SELECT * FROM %stests WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $insert_id));
        
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    /**
    * @param $post_array
    * @param $expected_row
    *
    * @dataProvider insert_custom_duration_fields_provider
    */
    public  function test_insert_custom_duration_fields($post_array, $expected_row) {
        $this->post_array = $post_array;
        $_SESSION['course_id'] = 1;
        $tid = 1;
        $table1 = array('tests_custom_duration');
        $table2 = $this->db_helper->seed_groups();
        $tables = array_merge($table1, $table2);
        
        insert_custom_duration_fields($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_custom_duration WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    /**
    * @param $post_array
    * @param $expected_row
    *
    * @dataProvider insert_test_for_groups_provider
    */
    public function test_insert_test_for_groups($post_array, $expected_row) {
        $this->post_array = $post_array;
        $tid = 1;
        $tables = array('tests_groups');
        insert_test_for_groups($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_groups WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        
        $this->assertEquals($expected_row, $actual_row);
        $this->db_helper->truncate($tables);
    }
    
    /**
    * @param $edited_post_array
    * @param $expected_row
    *
    * @dataProvider edit_test_provider
    */
    public function test_edit_test($edited_post_array, $expected_row) {
        $_SESSION['course_id'] = 1;
        $this->post_array = CreateTestDb::$dummy_post_array;
        $tid = create_test($this->post_array);
        $tables = array('tests');
        
        //Setup parameters you want to modify
        $this->post_array = $edited_post_array;
        edit_test($this->post_array, $tid, 10);
        
        $sql = "SELECT * FROM %stests WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    /**
    * @param $edited_post_array
    * @param $expected_row
    *
    * @dataProvider edit_custom_duration_fields_provider
    */
    public function test_edit_custom_duration_fields($edited_post_array, $expected_row) {
        $_SESSION['course_id'] = 1;
        $tid = 1;
        $table1 = array('tests_custom_duration');
        $table2 = $this->db_helper->seed_groups();
        $tables = array_merge($table1, $table2);
        insert_custom_duration_fields(CreateTestDb::$dummy_post_array, $tid);
        
        $this->post_array = $edited_post_array;
        edit_custom_duration_fields($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_custom_duration WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        
        //Unsetting 'id' as edit would do a delete followed by insert thus making id irrelevant
        unset($actual_row[0]['id']); unset($expected_row['id']);
        $this->assertEquals($expected_row, $actual_row[0]);
        $this->db_helper->truncate($tables);
    }
    
    /**
    * @param $edited_post_array
    * @param $expected_row
    *
    * @dataProvider edit_test_for_groups_provider
    */
    public function test_edit_test_for_groups($edited_post_array, $expected_row) {
        $tid = 1;
        $tables = array('tests_groups');
        insert_test_for_groups(CreateTestDb::$dummy_post_array, $tid);
        $this->post_array = $edited_post_array;
        edit_test_for_groups($this->post_array, $tid);
        $sql = "SELECT * FROM %stests_groups WHERE test_id=%d";
        $actual_row = queryDB($sql, array(TABLE_PREFIX, $tid));
        
        $this->assertEquals($expected_row, $actual_row);
        $this->db_helper->truncate($tables);
    }
    
    public static function provider_helper($test_name) {
        $path = AT_INCLUDE_PATH ."/unit_tests/data/create_test_db/";
        $test_cases_string = file_get_contents($path.$test_name.".json");
        $test_cases = json_decode($test_cases_string, TRUE);
        
        $return_array = array();
        foreach($test_cases as $test_case) {
            $return_array[] = array($test_case['input'], $test_case['expected']);
        }
        
        return $return_array;
    }
    
    public static function create_test_provider() {
        return CreateTestDb::provider_helper('create_test');
    }
    
    public static function insert_custom_duration_fields_provider() {
        return CreateTestDb::provider_helper('insert_custom_duration_fields');
    }
    
    public static function insert_test_for_groups_provider() {
        return CreateTestDb::provider_helper('insert_test_for_groups');
    }
    
    public static function edit_test_provider() {
        return CreateTestDb::provider_helper('edit_test');
    }
    
    public static function edit_custom_duration_fields_provider() {
        return CreateTestDb::provider_helper('edit_custom_duration_fields');
    }
    
    public static function edit_test_for_groups_provider() {
        return CreateTestDb::provider_helper('edit_test_for_groups');
    }
    
}
?>
