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

require_once (AT_INCLUDE_PATH. 'lib/mysql_connect.inc.php');
require_once (AT_INCLUDE_PATH. 'config.inc.php');

class DBHelper {
    
    public function setUp() {
        global $db;
        $db = at_db_connect('localhost', '3306', 'root', '', 'atutor_test');
        at_db_select('atutor_test', $db);
        return $db;
    }
    
    public function truncate($tables) {
        foreach($tables as $table) {
            $sql = "TRUNCATE %s%s";
            queryDB($sql, array(TABLE_PREFIX, $table));
        }
    }
    
    public function seed_groups() {
        $sql = "INSERT INTO %sgroups_types (course_id,title) 
                VALUES(1,'Type 1'),(1,'Type 2'),(2,'Type 3')";
        queryDB($sql, array(TABLE_PREFIX));
        
        $sql = "INSERT INTO %sgroups (type_id, title, description, modules) 
                VALUES(1,'Type 1','Description 1','_standard/file_storage|_standard/forums|_standard/social|_standard/photos'),
                      (1,'Type 2','Description 2','_standard/file_storage|_standard/forums|_standard/social|_standard/photos'),
                      (2,'Type 3','Description 3','_standard/file_storage|_standard/forums|_standard/social|_standard/photos'),
                      (3,'Type 4','Description 4','_standard/file_storage|_standard/forums|_standard/social|_standard/photos')";
        queryDB($sql, array(TABLE_PREFIX));
        
        $tables_affected = array('groups_types', 'groups');
        return $tables_affected;
    }
    
    public function seed_instructor($login, $email, $first_name, $last_name) {
        $password = md5('password');
        $sql = "INSERT INTO `%smembers`(`login`, `password`, `email`, `website`, `first_name`, `second_name`, `last_name`, `dob`, `gender`, `address`, `postal`, `city`, `province`, `country`, `phone`, `status`, `preferences`, `language`, `inbox_notify`, `private_email`)
                VALUES('$login','$password', '$email', '', '$first_name', '', '$last_name', '1992-03-16', 'm', '', '', '', '', '', '', 3, '', 'en', '', '')";
        queryDB($sql, array(TABLE_PREFIX));
        return array('members');
    }
    
    public function seed_student($login, $email, $first_name, $last_name) {
        $password = md5('password');
        $sql = "INSERT INTO `%smembers`(`login`, `password`, `email`, `website`, `first_name`, `second_name`, `last_name`, `dob`, `gender`, `address`, `postal`, `city`, `province`, `country`, `phone`, `status`, `preferences`, `language`, `inbox_notify`, `private_email`)
                VALUES('$login', '$password', '$email', '', '$first_name', '', '$last_name', '1992-03-16', 'm', '', '', '', '', '', '', 2, '', 'en', '', '')";
        queryDB($sql, array(TABLE_PREFIX));
        return array('members');
    }
    
    public function seed_course(&$course_id) {
        $table1 = $this->seed_instructor('abhinav', 'abhinav@atutor.com', 'Abhinav', 'Koppula');
        $member_id = at_insert_id();
        
        $sql = "INSERT INTO `%scourses`(`member_id`, `cat_id`, `content_packaging`, `access`, `title`, `description`, `course_dir_name`, `notify`, `max_quota`, `max_file_size`, `hide`, `copyright`, `primary_language`, `rss`, `icon`, `home_links`, `main_links`, `side_menu`, `banner`, `home_view`) 
                VALUES($member_id, 0, 'top', 'public', 'CSE 101', 'Algorithms', '', 0, -2, -3, 0, '', 'en', 0, 'album3.png', 'mods/_standard/file_storage/index.php|mods/calendar/index.php|mods/_standard/directory/directory.php|mods/_standard/tracker/my_stats.php|mods/_standard/tests/my_tests.php|mods/_standard/blogs/index.php', 'mods/_standard/forums/forum/list.php|mods/_core/glossary/index.php|mods/_standard/file_storage/index.php|mods/_standard/social/index.php|mods/_standard/sitemap/sitemap.php|mods/_standard/photos/index.php|mods/calendar/index.php|mods/_standard/blogs/index.php', 'social|menu_menu|related_topics|users_online|glossary|search|poll|posts', '', 1)";
        queryDB($sql, array(TABLE_PREFIX));
        $course_id = at_insert_id();
        $table2 = array('courses');
        
        $sql = "INSERT INTO `%scourse_enrollment`(`member_id`, `course_id`, `approved`, `privileges`, `role`)
                VALUES (%d, %d, 'y', 0, 'instructor')";
        queryDB($sql, array(TABLE_PREFIX, $member_id, $course_id));
        $table3 = array('course_enrollment');
        
        $tables = array_merge($table1, $table2, $table3);
        return $tables;
    }
    
    public function enroll_student_into_course($student_id, $course_id) {
        $sql = "INSERT INTO `%scourse_enrollment`(`member_id`, `course_id`, `approved`, `privileges`, `role`)
                VALUES (%d, %d, 'y', 0, 'student')";
        queryDB($sql, array(TABLE_PREFIX, $student_id, $course_id));
        return array('course_enrollment');
    }
}
?>
