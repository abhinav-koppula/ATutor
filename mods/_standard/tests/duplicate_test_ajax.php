<?php

/* * ************************************************************* */
/* ATutor                                                       */
/* * ************************************************************* */
/* Copyright (c) 2002-2010                                      */
/* Inclusive Design Institute                                   */
/* http://atutor.ca                                             */
/*                                                              */
/* This program is free software. You can redistribute it and/or */
/* modify it under the terms of the GNU General Public License  */
/* as published by the Free Software Foundation.                */
/* * ************************************************************* */
// $Id$
define('AT_INCLUDE_PATH', '../../../include/');
require(AT_INCLUDE_PATH . 'vitals.inc.php');
require(AT_INCLUDE_PATH . '../mods/_standard/tests/lib/test_result_functions.inc.php');
require(AT_INCLUDE_PATH . '../mods/_standard/tests/classes/testQuestions.class.php');

$tid = $_POST['duplicate_tid'];
$duplicate_test_title = $_POST['duplicate_test_title'];

$sql = "SELECT * FROM %stests WHERE test_id=%d AND course_id=%d";
$row_tests = queryDB($sql, array(TABLE_PREFIX, $tid, $_SESSION['course_id']), TRUE);

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
    $duplicate_test_title,
    $row_tests['description'],
    $row_tests['format'],
    $row_tests['start_date'],
    $row_tests['end_date'],
    $row_tests['order'],
    $row_tests['num_questions'],
    $row_tests['instructions'],
    $row_tests['content_id'],
    $row_tests['passscore'],
    $row_tests['passpercent'],
    $row_tests['passfeedback'],
    $row_tests['failfeedback'],
    $row_tests['result_release'],
    $row_tests['random'],
    $row_tests['difficulty'],
    $row_tests['num_takes'],
    $row_tests['anonymous'],
    $row_tests['allow_guests'],
    $row_tests['display'],
    $row_tests['show_guest_form'],
    $row_tests['remedial_content'],
    $row_tests['timed_test'],
    $row_tests['timed_test_duration']));

if(at_insert_id() > 0) {
    echo _AT('DUPLICATION_SUCCESSFUL');
} else {
    echo _AT('DUPLICATION_UNSUCCESSFUL');
}
?>