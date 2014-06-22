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

$tid = intval($_POST['duplicate_tid']);
$duplicate_test_title = $addslashes($_POST['duplicate_test_title']);
$duplicate_test_title = validate_length($duplicate_test_title, 100);

//Duplicate test properties
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
          timed_test_duration) " .
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
    $row_tests['randomize_order'],
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
    $row_tests['guests'],
    $row_tests['display'],
    $row_tests['show_guest_form'],
    $row_tests['remedial_content'],
    $row_tests['timed_test'],
    $row_tests['timed_test_duration']));

$duplicate_tid = at_insert_id();

//Duplicate test questions
$sql = "SELECT * FROM %stests_questions_assoc WHERE test_id = %d";
$row_tests_questions = queryDB($sql, array(TABLE_PREFIX, $tid));

foreach($row_tests_questions as $row) {
    $sql = "INSERT INTO %stests_questions_assoc (test_id, question_id, weight, ordering, required) VALUES(%d, %d, %d, %d, %d)";
    $result = queryDB($sql, array(TABLE_PREFIX, $duplicate_tid, $row['question_id'], $row['weight'], $row['ordering'], $row['required']));
}

//Duplicate test groups
$sql = "SELECT * FROM %stests_groups WHERE test_id = %d";
$row_tests_groups = queryDB($sql, array(TABLE_PREFIX, $tid));

foreach($row_tests_groups as $row) {
    $sql = "INSERT INTO %stests_groups (test_id, group_id) VALUES(%d, %d)";
    $result = queryDB($sql, array(TABLE_PREFIX, $duplicate_tid, $row['group_id']));
}

//Duplicate test custom duration
$sql = "SELECT * FROM %stests_custom_duration WHERE test_id = %d";
$row_tests_custom_duration = queryDB($sql, array(TABLE_PREFIX, $tid));

foreach($row_tests_custom_duration as $row) {
    $sql = "INSERT INTO %stests_custom_duration(id, test_id, type, type_id, custom_duration) VALUES(NULL, %d, '%s', %d, %d)";
    $result = queryDB($sql, array(TABLE_PREFIX, $duplicate_tid, $row['type'], $row['type_id'], $row['custom_duration']));
}

if($duplicate_tid > 0) {
    $sql	= "SELECT *, UNIX_TIMESTAMP(start_date) AS us, UNIX_TIMESTAMP(end_date) AS ue FROM %stests WHERE test_id = %d AND course_id=%d ORDER BY start_date DESC";
    $rows_tests	= queryDB($sql, array(TABLE_PREFIX, $duplicate_tid, $_SESSION['course_id'] ));
    foreach($rows_tests as $row) {
        $htmlelement = '
        <tr onmousedown="document.form[\'t'.$row['test_id'].'\'].checked = true;rowselect(this);" id="r_'.$row['test_id'].'">
			<td><input type="radio" name="id" value="'.$row['test_id'].'" id="t'.$row['test_id'].'" /></td>
			<td><label for="t'.$row['test_id'].'">'.$row['title'].'</label></td>
			<td  class="hidecol700">';
				if ( ($row['us'] <= time()) && ($row['ue'] >= time() ) ) {
					$htmlelement.= '<strong>'._AT('ongoing').'</strong>';
				} else if ($row['ue'] < time() ) {
					$htmlelement.= '<strong>'._AT('expired').'</strong>';
				} else if ($row['us'] > time() ) {
					$htmlelement.= '<strong>'._AT('pending').'</strong>';
				}
        $htmlelement.= '</td><td>';
   
        $startend_date_format=_AT('startend_date_format'); 

				$htmlelement.= AT_date($startend_date_format, $row['start_date'], AT_DATE_MYSQL_DATETIME). ' ' ._AT('to_2').' ';
				$htmlelement.= AT_date($startend_date_format, $row['end_date'], AT_DATE_MYSQL_DATETIME).'</td>';
        $htmlelement.='<td  class="hidecol700">';
				if ($row['result_release'] == AT_RELEASE_IMMEDIATE) {
					$htmlelement.= _AT('release_immediate');
				} else if ($row['result_release'] == AT_RELEASE_MARKED) {
					$htmlelement.= _AT('release_marked');
				} else if ($row['result_release'] == AT_RELEASE_NEVER) {
					$htmlelement.= _AT('release_never');
				}
        $htmlelement.='</td><td>';
				//get # marked submissions
				$sql_sub = "SELECT COUNT(*) AS sub_cnt FROM %stests_results WHERE status=1 AND test_id=%d";
				$row_sub = queryDB($sql_sub, array(TABLE_PREFIX, $row['test_id']), TRUE);

        $htmlelement.=$row_sub['sub_cnt'].' '._AT('submissions').', ';

				//get # submissions
				$sql_sub = "SELECT COUNT(*) AS marked_cnt FROM %stests_results WHERE status=1 AND test_id=%d AND final_score=''";
				$row_sub = queryDB($sql_sub, array(TABLE_PREFIX, $row['test_id']), TRUE);

        $htmlelement.=$row_sub['marked_cnt'].' '._AT('unmarked');
        $htmlelement.='</td><td  class="hidecol480">';
    
				//get assigned groups
				$sql_sub = "SELECT G.title FROM %sgroups G INNER JOIN %stests_groups T USING (group_id) WHERE T.test_id=%d";
				$rows_groups	= queryDB($sql_sub, array(TABLE_PREFIX, TABLE_PREFIX, $row['test_id']));

                if(count($rows_groups) == 0){
					$htmlelement.= _AT('everyone');
				} else {
					$assigned_groups = '';
					foreach($rows_groups as $row_groups){
						$assigned_groups .= $row_groups['title'].', ';
					}
					$htmlelement.=substr($assigned_groups, 0, -2);
				}
        $htmlelement.='</td></tr>';
    }
    $return_message = array('result' => 'success', 'message' =>_AT('DUPLICATION_SUCCESSFUL'), 'htmlelement' => $htmlelement);
} else {
    $return_message = array('result' => 'error', 'message' =>_AT('DUPLICATION_UNSUCCESSFUL'));
}
echo json_encode($return_message);
?>