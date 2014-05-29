function iframeSetHeight(id, height) {
	document.getElementById("qframe" + id).style.height = (height + 20) + "px";
}

/**
 * jQuery - Mimic confirm alert box
 * @param	DOM input element	The input submit button.
 * @param	String				The message that confirms submission
 */
function confirmSubmit(input, confirmMsg){
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

function CreateTimer(TimerID, TimerHiddenID, Time) {
    Timer = document.getElementById(TimerID);
    TimerHidden = document.getElementById(TimerHiddenID);
    TotalSeconds = Time;
    
    UpdateTimer();
    window.setTimeout("Tick()", 1000);
}

function autoSubmitTest()
{
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


    Timer.innerHTML = TimeStr;
    TimerHidden.value = TotalSeconds;
}


function LeadingZero(Time) {
    return (Time < 10) ? "0" + Time : + Time;
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
