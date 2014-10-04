function iframeSetHeight(id, height) {
	document.getElementById("qframe" + id).style.height = (height + 20) + "px";
}

/**
 * jQuery - Mimic confirm alert box
 * @param	DOM input element	The input submit button.
 * @param	String				The message that confirms submission
 */
function confirmSubmit(input, confirmMsg) {
	input_button = jQuery(input);
	submit_row = input_button.parent();
	//jquery submit button alternation
	input_button.attr('id', 'submit_test');
	input_button.removeAttr('onclick');
	input_button.prop("onclick", null);
	//label for the modified submit button
	input_label = jQuery('<label>').attr('for', 'submit_test');
	input_label.text(confirmMsg);

	submit_row.prepend(jQuery('<br>'));
	submit_row.prepend(input_label);
}

var Timer;
var TotalSeconds;
var TimerHidden;
var NormalMode;
var IntermediateMode;
var EmergencyMode;

function CreateTimer(TimerID, TimerHiddenID, Time, normalMode, intermediateMode, emergencyMode) {
    Timer = document.getElementById(TimerID);
    TimerHidden = document.getElementById(TimerHiddenID);
    TotalSeconds = Time;
    NormalMode = normalMode;
    IntermediateMode = intermediateMode;
    EmergencyMode = emergencyMode;
    
    UpdateTimer();
    window.setTimeout("Tick()", 1000);
}

function autoSubmitTest() {
    test_type = $('#test_type').val();
    input_button = jQuery("#submit_test");
    if(test_type == 'single_question_page')
    {
        form_action = $('#test_form').attr('action');
        form_action+='&test_timeout=1';
        console.log(form_action);
        $('#test_form').attr('action', form_action);
    }
    
    //jquery submit button alternation
    input_button.removeAttr('onclick');
    input_button.prop("onclick", null);
    $(input_button).trigger('click');
}

function Tick() {
    if (TotalSeconds <= 0) {
        $( "#testTimeout-dialog" ).dialog( "open" );
        autoSubmitTest();
        return;
    }
    
    TotalSeconds -= 1;
    UpdateTimer()
    window.setTimeout("Tick()", 1000);
}

function UpdateTimer() {
    var Seconds = TotalSeconds;
        
    var Days = Math.floor(Seconds / 86400);
    Seconds -= Days * 86400;

    var Hours = Math.floor(Seconds / 3600);
    Seconds -= Hours * (3600);

    var Minutes = Math.floor(Seconds / 60);
    Seconds -= Minutes * (60);


    var TimeStr = ((Days > 0) ? Days + " days " : "") + LeadingZero(Hours) + ":" + LeadingZero(Minutes) + ":" + LeadingZero(Seconds)
    var TimeInWords = convertToWords(Days, Hours, Minutes, Seconds);
    
    changeMode();
    Timer.innerHTML = TimeInWords;
    TimerHidden.value = TotalSeconds;
}

function changeMode() {
    var seconds = TotalSeconds;
    
    if(seconds > NormalMode) {
        Timer.style.color = "#008000";
    } else if(seconds == NormalMode) {
        setTimerAttributes();
        updateLiveRegion("#test_timer_aria");
    } else if(seconds > IntermediateMode) {
        removeTimerAttributes();
        Timer.style.color = "#E89C0C";
    } else if(seconds == IntermediateMode) {
        setTimerAttributes();
        updateLiveRegion("#test_timer_aria");
    } else {
        removeTimerAttributes();
        Timer.style.color = "#FF0000";
    }
}

function toggleTimerSize() {
    var timerSizes = [18,23,26];
    
    var fontSize = parseInt(Timer.style.fontSize);
    if(isNaN(fontSize) || fontSize == timerSizes[0]) {   //isNaN check included because js fontSize property is initially undefined until set explicitly
        Timer.style.fontSize = timerSizes[1]+"px";
    } else if(fontSize == timerSizes[1]) {
        Timer.style.fontSize = timerSizes[2]+"px";
    } else {
        Timer.style.fontSize = timerSizes[0]+"px";
    }
}

function convertToWords(Days, Hours, Minutes, Seconds) {
    var convertedString = "";
    if(Days > 0) {
        convertedString = Days + " days " + LeadingZero(Hours) + " hours remaining";
    } else if(Hours > 0) {
        convertedString = Hours + " hours " + LeadingZero(Minutes) + " minutes remaining";
    } else if(Minutes > 0) {
        convertedString = Minutes + " minutes " + LeadingZero(Seconds) + " seconds remaining";
    } else {
        convertedString = Seconds + " seconds remaining";
    }
    return convertedString;
}

function LeadingZero(Time) {
    return (Time < 10) ? "0" + Time : + Time;
}

function convert_duration_to_hhmmss(duration, convertedObj) {
    hours = Math.floor(duration/3600);
    mins = Math.floor((duration % 3600)/60);
    secs = Math.floor((duration)%60);
    convertedObj.hours = hours;
    convertedObj.mins = mins;
    convertedObj.secs = secs;
}

function setTimerAttributes() {
    Timer.setAttribute('aria-relevant', 'all');
    Timer.setAttribute('aria-atomic', 'true');
    Timer.setAttribute('aria-live', 'polite');
}

function removeTimerAttributes() {
    Timer.removeAttribute('aria-relevant');
    Timer.removeAttribute('aria-atomic');
    Timer.removeAttribute('aria-live');
}

function updateLiveRegion(liveRegionId) {
    $(liveRegionId).text(Timer.innerHTML);
}

TestTimeout = function(options) {
    $("body").append("<div title='"+ options.title +"' id='testTimeout-dialog'>"+ options.message +"</div>");
    TestTimeoutDialog = $("#testTimeout-dialog").dialog({
        autoOpen: false,
        width: 400,
        modal: true,
        closeOnEscape: false,
        open: function() { $(".ui-dialog-titlebar-close").hide(); },
        buttons: options.buttons
    });
}
