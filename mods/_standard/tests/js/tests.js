/**
 * @author Alexey Novak
 * @copyright Copyright © 2013, ATutor, All rights reserved.
 */

/*global jQuery*/
/*global ATutor */

ATutor = ATutor || {};
ATutor.mods = ATutor.mods || {};
ATutor.mods.tests = ATutor.mods.tests || {};
ATutor.mods.tests.create_test = ATutor.mods.tests.create_test || {};

(function () {
    "use strict";
    
    /**
    * Function mainly for edit_test and create_test for disabling/enabling elements depending on user interactions
    * @author    Alexey Novak
    */
    ATutor.mods.tests.disable_elements = function(name, disableFlag) {
        var passpercent = $("#passpercent"),
            passscore = $("#passscore"),
            num_questions = $("#num_questions"),
            timed_test_duration = [$("#timed_test_hours"), $("#timed_test_minutes"), $("#timed_test_seconds")],
            show_guest_form = $("#show_guest_form");
        
        // Disable/Enable elements based on what user clicked
        if (name === "both") {
            passpercent.attr("disabled", "disabled");
            passscore.attr("disabled", "disabled");
            passpercent.val(0);
            passscore.val(0);
        } else if (name === "percentage") {
            passpercent.attr("disabled", "disabled");
            passscore.removeAttr("disabled");
            passpercent.val(0);
        } else if (name === "points") {
            passpercent.removeAttr("disabled");
            passscore.attr("disabled", "disabled");
            passscore.val(0);
        } else if (name === "num_questions") {
            num_questions[(disableFlag) ? "attr" : "removeAttr"]("disabled", "");
        } else if (name === "timed_test_duration") {
            $(timed_test_duration).each(function(id){
                var elem = timed_test_duration[id]
                elem[(disableFlag) ? "attr" : "removeAttr"]("disabled", "");
            });
        } else if (name === "show_guest_form") {
            show_guest_form[(disableFlag) ? "attr" : "removeAttr"]("disabled", "");
            if (disableFlag) {
                show_guest_form.attr("checked", false);
            }
        }
    };
    
    /**
    * Function to scroll to the selector
    * @author    Alexey Novak
    */
    ATutor.mods.tests.jumpTo = function(selector) {
        var selector = $(selector);
        
        if (selector.length === 0) {
            return;
        }
        
        $("html, body").animate({
            scrollTop: $(selector).offset().top
        }, 1);
    };
    
    /**
    * Function to scroll to the top of the window and focus on the Test Begin button.
    * @author    Alexey Novak
    */
    ATutor.mods.tests.focusBegin = function() {
        ATutor.mods.tests.jumpTo("a[name=content]");
        $(".row.buttons input[name=submit]").focus();
    };

    ATutor.mods.tests.create_test.change_options = function(ele, id) {
        var val = ele.value;
        $("#custom_duration_options_"+ id +" option").remove();
        $('#custom_duration_options_'+ id).append(ATutor.mods.tests.create_test.get_options(val))
    }
    
    ATutor.mods.tests.create_test.add_custom_duration_row = function(id, type, type_id, hours, mins, secs) {
        type = typeof type !== 'undefined' ? type : 'group';
        type_id = typeof type_id !== 'undefined' ? type_id : -1;
        hours = typeof hours !== 'undefined' ? hours : 0;
        mins = typeof mins !== 'undefined' ? mins : 0;
        secs = typeof secs !== 'undefined' ? secs : 0;
        
        var type_selected_none = "";
        var type_selected_group = "";
        var type_selected_student = "";
        
        if(type =='group') {
            type_selected_none    = "";
            type_selected_group   = " selected = 'selected'";
            type_selected_student = "";
        } else if(type == 'student') {
            type_selected_none    = "";
            type_selected_group   = "";
            type_selected_student = " selected = 'selected'";
        } else {
            type_selected_none    = " selected = 'selected'";
            type_selected_group   = "";
            type_selected_student = "";
        }
        
        var data="";
        data+="<tr id='custom_duration_row_"+id+"' >";
        data+="<td><input type='checkbox' name='custom_duration_checkbox_"+id+"' id='custom_duration_checkbox_"+id+"' onclick='javascript:ATutor.mods.tests.create_test.selectRow("+id+");' /><label for='' ></label></td>"
        data+="<td>\
                <select name='custom_duration_type_"+id+"' id='custom_duration_type_"+id+"' onchange='javascript:ATutor.mods.tests.create_test.change_options(this, "+id+");' >\
                    <option value='-1'"+ type_selected_none +">select type</option>\
                    <option value='group'"+ type_selected_group +">Group</option>\
                    <option value='student'"+ type_selected_student +">Student</option>\
                </select>\
               </td>";
        data+="<td>";
   
            
        data+="<div class='ui-widget'>\
                <select name='custom_duration_options_"+id+"' id='custom_duration_options_"+id+"' class='combobox' >\
                <option value='-1'>select group/student</option>"+ATutor.mods.tests.create_test.get_options(type)+"\
               </select></div>";
        data+="</td>";
        data+="<td>";
        data+="<input type='text' name='custom_duration_hours_"+id+"' id='custom_duration_hours_"+id+"' size='2' value='"+ hours +"' />\
                <label for='custom_duration_hours_"+id+"' ><?php echo _AT('hours'); ?></label>\
                <input type='text' name='custom_duration_minutes_"+id+"' id='custom_duration_minutes_"+id+"' size='2' value='"+ mins +"' /> \
                <label for='custom_duration_minutes_"+id+"'><?php echo _AT('in_minutes'); ?></label> \
                <input type='text' name='custom_duration_seconds_"+id+"' id='custom_duration_seconds_"+id+"' size='2' value='"+ secs +"' /> \
                <label for='custom_duration_seconds_"+id+"' ><?php echo _AT('seconds'); ?></label>\
                </td>\
                </tr>";
        $('#custom_duration tbody').append(data);
        $('#custom_duration_options_'+id+' option[value="'+type_id+'"]').attr('selected', 'selected');
        $( ".combobox" ).combobox();
    }
    
    ATutor.mods.tests.create_test.edit_custom_duration_row = function(type, type_id, custom_duration) {
        var hours = (parseInt)(custom_duration/3600);
        var mins = (parseInt)((custom_duration % 3600)/60);
        var secs = (parseInt)(custom_duration % 60);
        ATutor.mods.tests.create_test.add_custom_duration_row(ATutor.mods.tests.create_test.custom_duration_row_id++, type, type_id, hours, mins, secs);
    }
    
    ATutor.mods.tests.create_test.selectRow = function(id) {
        var checkbox_check = ($('#custom_duration_checkbox_'+id).prop('checked'));
        if(checkbox_check == true) {
            $('#custom_duration_row_'+id).addClass('selected');
        } else {
            $('#custom_duration_row_'+id).removeClass('selected');
        }
    }
    
    
    /**
    * Function to activate Slide All link for the Remedial Content divs
    * @author    Alexey Novak
    */
    var activateHideAllLink = function(collapsibleElements, hideAllLink) {
        // If there is no remedial content then just exit
        if (collapsibleElements.length === 0) {
            return;
        }
        
        // Show the link
        hideAllLink.show();
        
        // Assign a click to the link
        hideAllLink.click(function (event) {
            var link = (event.currentTarget) ? $(event.currentTarget) : $(event.srcElement),
                linkHideText = link.find(".hideAllLabel"),
                linkShowText = link.find(".showAllLabel"),
                isAllHidden = linkShowText.is(":visible"),
                linkClass;
            
            if (isAllHidden) {
                linkHideText.show();
                linkShowText.hide();
                linkClass = ".show";
            } else {
                linkHideText.hide();
                linkShowText.show();
                linkClass = ".hide";
            }
            
            collapsibleElements.filter(linkClass).click();
            
            link.focus();
            return false;
        });    
    };
    
    /**
    * Function which would assign a slide function to all areas with links which have a specified class
    * @options
    *    collapsibleElements                - jQuery links which would have a click event bind to them
    *    collapsedClass                    - class which will be added/removed to the div area which will have a slide effect
    *    fieldsetNotCollapsedMinHeight    - min-height for the div area when it is not collapsed
    *    fieldsetCollapsedMinHeight        - min-height for the div area when it is collapsed
    * @author    Alexey Novak
    */
    var makeCollapsibles = function(options) {
        options = options || {};
        
        var collapsibleElements = options.collapsibleElements;
        
        if (!collapsibleElements || collapsibleElements.length === 0) {
            return;
        }
        
        // Bind the click event
        collapsibleElements.click(function (event) {
            var link = (event.currentTarget) ? $(event.currentTarget) : $(event.srcElement),
                linkHideText = link.find(".hideLabel"),
                linkShowText = link.find(".showLabel"),
                fieldset = link.parent().parent(),
                row = fieldset.find(".row"),
                collapsedClass = options.collapsedClass,
                isCollapsed = fieldset.hasClass(collapsedClass),
                addRemoveClass, rowShowHide;
            
            // If area is currently sliding then just do not do anything
            if (row.is(":animated")) {
                return;
            }
            
            if (isCollapsed) {
                linkHideText.show();
                linkShowText.hide();
                
                link.addClass("hide").removeClass("show");
    
                addRemoveClass = "removeClass";
                rowShowHide = "slideDown";
                
                fieldset[addRemoveClass](collapsedClass);
                fieldset.animate({"min-height": options.fieldsetNotCollapsedMinHeight}, "slow");
                row[rowShowHide]("slow");
            } else {
                linkHideText.hide();
                linkShowText.show();
                
                link.removeClass("hide").addClass("show");
                
                addRemoveClass = "addClass";
                rowShowHide = "slideUp";
                
                fieldset.animate({"min-height": options.fieldsetCollapsedMinHeight}, "slow");
                
                row[rowShowHide]("slow", function() {
                    fieldset[addRemoveClass](collapsedClass);
                });
            }
            
            link.focus();
            return false;
        });
    };
    
    /**
    * Function to be called upon page load
    * @author    Alexey Novak
    */
    var initialize = function() {
        // Get all the links for remedial content and Hide All Remedial content link
        var collapsibleElements = $(".collapsible"),
            hideAllLink = $(".hideAllRemedialLink");
        
        // Set up Remedial Content Hide/Show separate links
        makeCollapsibles({
            collapsibleElements: collapsibleElements,
            collapsedClass: "collapsed",
            fieldsetNotCollapsedMinHeight: "170px",
            fieldsetCollapsedMinHeight: "5px"
        });
        
        // Set up Hide All Remedial Content link
        activateHideAllLink(collapsibleElements, hideAllLink);
    };

    jQuery(document).ready(initialize);
})();