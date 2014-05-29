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

$tid = $_POST['tid'];
$post_gid = $_POST['gid'];
$member_id = $_SESSION['member_id'];
if(isset($_POST['test_timer_hidden']))
{
    $test_timer_hidden = $_POST['test_timer_hidden'];
} else {
    $test_timer_hidden = 0;
}

// insert
if (!isset($post_gid)) {

    $sql = 'SELECT result_id FROM %stests_results WHERE test_id=%d AND member_id=%d AND status=0';
    $row = queryDB($sql, array(TABLE_PREFIX, $tid, $member_id), TRUE);
    $result_id = $row['result_id'];
} else {

    $sql = 'INSERT INTO %stests_results VALUES (NULL, %d, %d, NOW(), "", 0, NOW(), 0, %d)';
    $result = queryDB($sql, array(TABLE_PREFIX, $tid, $post_gid, $test_timer_hidden));
    $result_id = at_insert_id();
}

//update test results with the timer if timed test and pos if test is of "single question per page" type
$sql = 'UPDATE %stests_results SET test_timer=%d WHERE result_id=%d AND test_id=%d';
queryDB($sql, array(TABLE_PREFIX, $test_timer_hidden, $result_id, $tid));

$final_score = 0;
$set_final_score = TRUE; // whether or not to save the final score in the results table.

$sql = "SELECT TQA.weight, TQA.question_id, TQ.type, TQ.answer_0, TQ.answer_1, TQ.answer_2, TQ.answer_3, TQ.answer_4, TQ.answer_5, TQ.answer_6, TQ.answer_7, TQ.answer_8, TQ.answer_9 FROM %stests_questions_assoc TQA INNER JOIN %stests_questions TQ USING (question_id) WHERE TQA.test_id=%d ORDER BY TQA.ordering, TQ.question_id";
$rows_questions = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, $tid));

foreach ($rows_questions as $row) {
    $row_question_id = $row['question_id'];
    if (isset($_POST['answers'][$row_question_id])) {
        $obj = TestQuestions::getQuestion($row['type']);
        $score = $obj->mark($row);
        // Note that $_POST['answers'][$row_question_id] is manipulated by $obj->mark
        // to concatenate multiple answers, so must use the $_POST value after the mark function.
        $answer_question_id = $_POST['answers'][$row_question_id];

        if (!isset($post_gid)) {
            $sql = 'UPDATE %stests_answers SET answer="%s", score="%s" WHERE result_id=%d AND question_id=%d';
            queryDB($sql, array(TABLE_PREFIX, $answer_question_id, $score, $result_id, $row_question_id));
        } else {
            $sql = 'INSERT INTO %stests_answers (result_id, question_id, member_id, answer, score, notes) VALUES (%d, %d, 0, "%s", "%s", "")';
            queryDB($sql, array(TABLE_PREFIX, $result_id, $row_question_id, $answer_question_id, $score));
        }

        // don't set final score if there is any unmarked answers and release option is set to "after all answers are marked"
        if (is_null($score)) {
            $set_empty_final_score = ($test_row['result_release'] == AT_RELEASE_MARKED);
        } else {
            $final_score += $score;
        }
    }
}

?>