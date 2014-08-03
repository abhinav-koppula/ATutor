<?php
/****************************************************************/
/* ATutor                                                       */
/****************************************************************/
/* Copyright (c) 2002-2010                                      */
/* Inclusive Design Institute                                   */
/* http://atutor.ca                                             */
/*                                                              */
/* This program is free software. You can redistribute it and/or*/
/* modify it under the terms of the GNU General Public License  */
/* as published by the Free Software Foundation.                */
/****************************************************************/
// $Id$
define('AT_INCLUDE_PATH', '../../../include/');
require(AT_INCLUDE_PATH.'vitals.inc.php');
require(AT_INCLUDE_PATH.'../mods/_standard/tests/lib/test_result_functions.inc.php');
require(AT_INCLUDE_PATH.'../mods/_standard/tests/classes/testQuestions.class.php');

$course_id = $_SESSION['course_id'];
$member_id = $_SESSION['member_id'];
$enroll = $_SESSION['enroll'];

$tid = intval($_REQUEST['tid']);
$gid = $addslashes($_REQUEST['gid']);
$cid = $addslashes($_REQUEST['cid']);
$cid_url = SEP.'cid='.$cid;

//make sure max attempts not reached, and still on going
$sql = 'SELECT *, UNIX_TIMESTAMP(start_date) AS start_date, UNIX_TIMESTAMP(end_date) AS end_date FROM %stests WHERE test_id=%d AND course_id=%d';
$test_row = queryDB($sql, array(TABLE_PREFIX, $tid, $course_id), TRUE);


/* check to make sure we can access this test: */
if (!$test_row['guests'] && ($enroll == AT_ENROLL_NO || $enroll == AT_ENROLL_ALUMNUS)) {
    require(AT_INCLUDE_PATH.'header.inc.php');
    $msg->printInfos('NOT_ENROLLED');
    require(AT_INCLUDE_PATH.'footer.inc.php');
    exit;
}

if (!$test_row['guests'] && !authenticate_test($tid)) {
    header('Location: '.url_rewrite('mods/_standard/tests/my_tests.php', AT_PRETTY_URL_IS_HEADER));
    exit;
}

// checks one/all questions per page, and forward user to the correct one
if ($test_row['display']) {
    header('Location: '.url_rewrite('mods/_standard/tests/take_test_q.php?tid='.$tid.$cid_url, AT_PRETTY_URL_IS_HEADER));
} 

$out_of = $test_row['out_of'];

$sql = 'SELECT COUNT(*) AS cnt FROM %stests_results WHERE status=1 AND test_id=%d AND member_id=%d';
$takes= queryDB($sql, array(TABLE_PREFIX, $tid, $member_id), TRUE);

if ( (($test_row['start_date'] > time()) || ($test_row['end_date'] < time())) || 
   ( ($test_row['num_takes'] != AT_TESTS_TAKE_UNLIMITED) && ($takes['cnt'] >= $test_row['num_takes']) )  ) {
    require(AT_INCLUDE_PATH.'header.inc.php');
    $msg->printInfos('MAX_ATTEMPTS');
    
    require(AT_INCLUDE_PATH.'footer.inc.php');
    exit;
}

if (isset($_POST['submit'])) {
    $post_gid = $_POST['gid'];
    $test_completion_time = $_POST['test_timer_hidden'];
    
    // insert
    if (!isset($post_gid)) {

        $sql = 'SELECT result_id FROM %stests_results WHERE test_id=%d AND member_id=%d AND status=0';
        $row    = queryDB($sql, array(TABLE_PREFIX, $tid, $member_id), TRUE);
        $result_id = $row['result_id'];

    } else {

        $sql = 'INSERT INTO %stests_results VALUES (NULL, %d, %d, NOW(), "", 0, NOW(), 0, %d)';
        $result = queryDB($sql, array(TABLE_PREFIX, $tid, $post_gid, $test_completion_time));
        $result_id = at_insert_id();
    }

    $final_score     = 0;
    $set_final_score = TRUE; // whether or not to save the final score in the results table.

    $sql    = "SELECT TQA.weight, TQA.question_id, TQ.type, TQ.answer_0, TQ.answer_1, TQ.answer_2, TQ.answer_3, TQ.answer_4, TQ.answer_5, TQ.answer_6, TQ.answer_7, TQ.answer_8, TQ.answer_9 FROM %stests_questions_assoc TQA INNER JOIN %stests_questions TQ USING (question_id) WHERE TQA.test_id=%d ORDER BY TQA.ordering, TQ.question_id";
    $rows_questions    = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, $tid));

    foreach($rows_questions as $row){
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

    // update the final score
    // update status to complate to fix refresh test issue.

    $sql = 'UPDATE %stests_results SET final_score=%s, date_taken=date_taken, status=1, end_time=NOW(), test_timer=%d WHERE result_id=%d';
    $result    = queryDB($sql, array(TABLE_PREFIX, ($set_empty_final_score) ? 'NULL' : $final_score, $test_completion_time, $result_id));

    $msg->addFeedback('ACTION_COMPLETED_SUCCESSFULLY');
    if ((!$enroll && !isset($cid)) || $test_row['result_release']==AT_RELEASE_IMMEDIATE) {
        header('Location: '.url_rewrite('mods/_standard/tests/view_results.php?tid='.$tid.SEP.'rid='.$result_id.$cid_url, AT_PRETTY_URL_IS_HEADER));
        exit;
    }
    
    if (isset($cid)) header('Location: '.url_rewrite('content.php?cid='.$cid, AT_PRETTY_URL_IS_HEADER));
    else header('Location: '.url_rewrite('mods/_standard/tests/my_tests.php', AT_PRETTY_URL_IS_HEADER));
    exit;
}

$content_base_href = (defined('AT_FORCE_GET_FILE') && AT_FORCE_GET_FILE) ? 'get.php/' : sprintf('content/%d/', $course_id);

require(AT_INCLUDE_PATH.'header.inc.php');

/* Retrieve the content_id of this test */
$num_questions = $test_row['num_questions'];
$content_id = $test_row['content_id'];
$anonymous = $test_row['anonymous'];
$instructions = $test_row['instructions'];
$title = $test_row['title'];
$timed_test = $test_row['timed_test'];
$timed_test_duration = $test_row['timed_test_duration'];
$normal_mode = $timed_test ? $test_row['timed_test_normal_mode'] : 0;
$intermediate_mode = $timed_test ? $test_row['timed_test_intermediate_mode']: 0;
$emergency_mode = $timed_test ? $test_row['timed_test_emergency_mode'] : 0;
$normal_mode_seconds = intval($timed_test_duration - (($normal_mode/100) * ($timed_test_duration)));
$intermediate_mode_seconds = intval($normal_mode_seconds - (($intermediate_mode/100) * ($timed_test_duration)));
$emergency_mode_seconds = intval($intermediate_mode_seconds - (($emergency_mode/100) * ($timed_test_duration)));

$sql = "SELECT * FROM %stests_custom_duration WHERE test_id = %d";
$custom_duration_rows = queryDB($sql, array(TABLE_PREFIX, $tid));

foreach($custom_duration_rows as $row) {
    if($row['type'] == 'student') {
        if($row['type_id'] == $member_id) {
            $timed_test_duration = $row['custom_duration'];
            break;
        }
    } else if($row['type'] == 'group') {
        $sql = "SELECT member_id FROM %sgroups_members WHERE group_id = %d";
        $members = queryDB($sql, array(TABLE_PREFIX, $row['type_id']));
        foreach($members as $member) {
            if($member['member_id'] == $member_id) {
                $timed_test_duration = $row['custom_duration'];
                break;
            }
        }
    }
}

$_letters = array(_AT('A'), _AT('B'), _AT('C'), _AT('D'), _AT('E'), _AT('F'), _AT('G'), _AT('H'), _AT('I'), _AT('J'));

// first check if there's an 'in progress' test.
// this is the only place in the code that makes sure there is only ONE 'in progress' test going on.
$in_progress = false;

$sql = "SELECT result_id, test_timer FROM %stests_results WHERE member_id=%d AND test_id=%d AND status=0";
$row  = queryDB($sql, array(TABLE_PREFIX, $member_id, $tid), TRUE);

if(count($row) == 0)
{
    $timer = $timed_test_duration;
} else {
    $timer = $row['test_timer'];
}

if(count($row) > 0){

    $result_id = $row['result_id'];
    $in_progress = true;

    // retrieve the test questions that were saved to `tests_answers`

    $sql = "SELECT TA.*, TQA.*, TQ.* FROM %stests_answers TA INNER JOIN %stests_questions_assoc TQA USING (question_id) INNER JOIN %stests_questions TQ USING (question_id) WHERE TA.result_id=%d AND TQA.test_id=%d ORDER BY TQ.question_id";
    $rows_questions    = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, TABLE_PREFIX, $result_id, $tid));
} else if ($test_row['random']) {
    /* Retrieve 'num_questions' question_id randomly choosed from those who are related to this test_id*/

    $non_required_questions = array();
    $required_questions     = array();

    $sql = 'SELECT question_id, required FROM %stests_questions_assoc WHERE test_id=%d';
    $rows_questions    = queryDB($sql, array(TABLE_PREFIX, $tid));
    
    foreach($rows_questions as $row){
        if ($row['required'] == 1) {
            $required_questions[] = $row['question_id'];
        } else {
            $non_required_questions[] = $row['question_id'];
        }
    }
    
    $num_required = count($required_questions);
    if ($num_required < max(1, $num_questions)) {
        $required_questions = array_merge($required_questions, array_slice($non_required_questions, 0, $num_questions - $num_required));
    }

    $id_string = implode(',', $required_questions);

    $sql = 'SELECT TQ.*, TQA.* FROM %stests_questions TQ INNER JOIN %stests_questions_assoc TQA USING (question_id) WHERE TQ.course_id=%d AND TQA.test_id=%d AND TQA.question_id IN (%s) ORDER BY TQ.question_id';
    $rows_questions    = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, $course_id, $tid, $id_string));  
    
} else {

    $sql = "SELECT TQ.*, TQA.* FROM %stests_questions TQ INNER JOIN %stests_questions_assoc TQA USING (question_id) WHERE TQ.course_id=%d AND TQA.test_id=%d ORDER BY TQA.ordering, TQA.question_id";
    $rows_questions    = queryDB($sql, array(TABLE_PREFIX, TABLE_PREFIX, $course_id, $tid));
}

$questions = array();

foreach($rows_questions as $row){
    $questions[] = $row;
}

// Shuffle questions if the order is set to be random
// Mantis 5383: THIS CAUSES RESHUFFLE EVERYTIME THE TAKE TEST PAGE RELOADS 
if ($test_row['random']) {
    shuffle($questions);
}

if (count($rows_questions) == 0 || !$questions) {
    echo '<p>'._AT('no_questions').'</p>';
    require(AT_INCLUDE_PATH.'footer.inc.php');
    exit;
}

// save $questions with no response, and set status to 'in progress' in test_results <---
if (!$gid && !$in_progress) {

    $sql = 'INSERT INTO %stests_results VALUES (NULL, %d, %d, NOW(), "", 0, NOW(), 0, %d)';
    $result = queryDB($sql, array(TABLE_PREFIX, $tid, $member_id, $timer));
    $result_id = at_insert_id();

}
?>
<form id="test_form" method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
<input type="hidden" name="tid" value="<?php echo $tid; ?>" />

<?php
    if ($gid) {
        echo sprintf('<input type="hidden" name="gid" value="%s" />', $gid);
    }
    if ($cid) {
        echo sprintf('<input type="hidden" name="cid" value="%s" />', $cid);
    }
?>

<div class="input-form" style="width:95%">
    <fieldset class="group_form"><legend class="group_form"><?php echo $title ?></legend>

        <div id ="test_timer" class="test_timer">
        </div>
        <div id ="test_timer_aria"  class="region" role="timer" aria-labelledby="live1Label" aria-live="assertive" aria-atomic="false" aria-relevant="additions" style="
    opacity: 0;" >
            00:00:00
        </div>
        <input type="hidden" name="test_timer_hidden" id="test_timer_hidden" value="0" />
        <input type="hidden" name="test_type" id="test_type" value="all_question_page" />
    <?php if ($instructions!=''): ?>
        <div class="test_instruction">
            <strong><?php echo _AT('instructions'); ?></strong>
        </div>
        <div class="row" style="padding-bottom: 20px"><?php echo $instructions; ?></div>
    <?php endif; ?>

    <?php if ($anonymous): ?>
        <div class="row"><strong><strong><?php echo _AT('test_anonymous'); ?></strong></strong></div>
    <?php endif; ?>

    <?php
    foreach ($questions as $row) {
        if (!isset($post_gid) && !$in_progress) {
            
            $sql    = "INSERT INTO %stests_answers VALUES (%d, %d, %d, '', '', '')";
            queryDB($sql, array(TABLE_PREFIX, $result_id, $row[question_id], $member_id));
        }
        
        // retrieve the answer to re-populate the form (so we can edit our answer)
        $sql = "SELECT answer FROM %stests_answers WHERE result_id=%d AND question_id=%d";
        $row_answer = queryDB($sql, array(TABLE_PREFIX, $result_id, $row['question_id']), TRUE);
        
        $obj = TestQuestions::getQuestion($row['type']);
        $obj->display($row, $row['answer']);
    }
    ?>
    <div class="test_instruction">
        <strong><?php echo _AT('done'); ?>!</strong>
    </div>
    <div class="row buttons">
        <input type="submit" id="submit_test" name="submit" value="<?php echo _AT('submit'); ?>" accesskey="s" onclick="confirmSubmit(this, '<?php echo $addslashes(_AT("test_confirm_submit")); ?>'); return false;"/>
    </div>
    </fieldset>
</div>
</form>
<script type="text/javascript" src="<?php echo $_base_href;?>/mods/_standard/tests/lib/take_test.js"></script>
<script type="text/javascript">
        
    $(window).bind('beforeunload', function() {
        $.post("<?php echo AT_BASE_HREF."mods/_standard/tests/";?>save_answers_ajax.php", 
            $("#test_form").serialize(),
            function(data)
            {
                console.log(data);
            }
        );
        return "You haven't submitted the assessment.";
    });
    
    $(document).ready(function(){
        <?php
        if($timed_test == 1)
        {
        ?>
            CreateTimer("test_timer", "test_timer_hidden", <?php echo $timer;?>, <?php echo $normal_mode_seconds;?>, <?php echo $intermediate_mode_seconds;?>, <?php echo $emergency_mode_seconds;?>);
            $("#test_timer").scrollToFixed({ marginTop: 22 });
            
            $(document).keydown(function(e) {
                var convertedObj = {hours:0, mins:0, secs:0};
                if(e.altKey && e.keyCode == 84){ //Alt+t
                    updateLiveRegion($("#test_timer_hidden").val(), convertedObj, "#test_timer_aria");
                } else if(e.altKey && e.keyCode == 73) { //Alt+i
                    toggleTimerSize();
                }
            });
        <?php
        }
        ?>
        TestTimeout({
            title                   : "Time Up!",
            message                 : "Time Up. Your answers will be submitted.",
            buttons                 : { "Ok": function() { $(this).dialog("close"); 
            }}
        });
        
        $('#test_form').submit(function() {
            $(window).unbind('beforeunload');
        });
    });
    
</script>
<?php require(AT_INCLUDE_PATH.'footer.inc.php'); ?>