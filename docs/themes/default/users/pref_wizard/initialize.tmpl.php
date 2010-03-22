    <div>
        <input type="checkbox" name="pref_wiz[]" value="<?php echo DISPLAY ?>" id="display" <?php if (in_array(DISPLAY, $_POST['pref_wiz'])) echo checked ?> />
        <label for="display">I would like to make the text on the screen easier to see.</label>
    </div>

    <div>
        <input type="checkbox" name="pref_wiz[]" value="<?php echo NAVIGATION ?>" id="navigation" <?php if (in_array(NAVIGATION, $_POST['pref_wiz'])) echo checked ?> />
        <label for="navigation">I would like to enhance the navigation of the content.</label>
    </div>

    <div>
        <input type="checkbox" name="pref_wiz[]" value="<?php echo ALT_TO_TEXT ?>" id="altToText" <?php if (in_array(ALT_TO_TEXT, $_POST['pref_wiz'])) echo checked ?> />
        <label for="altToText">I would like alternatives to textual content.</label>
    </div>

    <div>
        <input type="checkbox" name="pref_wiz[]" value="<?php echo ALT_TO_AUDIO ?>" id="altToAudio" <?php if (in_array(ALT_TO_AUDIO, $_POST['pref_wiz'])) echo checked ?> />
        <label for="altToAudio">I would like alternatives to audio content.</label>
    </div>
    
    <div>
        <input type="checkbox" name="pref_wiz[]" value="<?php echo ALT_TO_VISUAL ?>" id="altToVisual" <?php if (in_array(ALT_TO_VISUAL, $_POST['pref_wiz'])) echo checked ?> />
        <label for="altToVisual">I would like alternatives to visual content.</label>
    </div>
    
    <div>
        <input type="checkbox" name="pref_wiz[]" value="<?php echo SUPPORT ?>" id="support" <?php if (in_array(SUPPORT, $_POST['pref_wiz'])) echo checked ?> />
        <label for="support">I would like access to learner support tools.</label>
    </div>
    
    <div>
        <input type="checkbox" name="pref_wiz[]" value="<?php echo ATUTOR ?>" id="atutor_pref" <?php if (in_array(ATUTOR, $_POST['pref_wiz'])) echo checked ?> />
        <label for="atutor_pref">I would like to change or review my ATutor preferences.</label>
    </div>
    
    <input type="hidden" value="-1" name="pref_index" id="pref_index" />
    <input type="submit" value="Next" name="next" id="next" />
    
    <!-- 
I want to make the text on the screen easier to see (leads to�screen enhancement options)

I want an overview of the course or the lesson (leads to�. list of lessons, table of contents, list of links?)

I want easier ways to move through the course (leads to options �. bread crumbs, previous/next button?, tab through headers)

I want alternatives to pictures and video (leads to options�. alt text and descriptions and audio alerts)

I want alternatives to sound and voice (leads to options�. captions and visual alerts)

I prefer a different language (leads to options �.how many? Dual language and option)

I want a dictionary or glossary (in what language?)

I want to be able to take notes (note taking utility in course)

I�m a visual learner (more pictures and video)

I want more detail (in text, by other means, linked, on the default screen)

1.  Can we add a question that deals with alternatives to a mouse, i.e. I want to make it easier to point and click.
The default presentation enables keyboard access to all functions. The standard enables the creation of personal keyboard shortcuts. We should discuss this further with respect to the specific scenarios.
2.  It must be less confusing is we separated some of the questions i.e. 
        I want an overview of the course
        I want an overview of the lesson 
        I want a dictionary 
        I want a glossary
Yes, definitely, any configuration of these is acceptable. 

3. The question I am a visual leaner may not be clear suggest we change it to � I would like to learn through more pictures and or videos
Yes, good rewording.

4. Can we add � I want alternatives to text�.
 Yes
5. Can we add - I want less detail and more overview �
Yes
6. Can we add I want to move through the course at my speed when I want to 
This is likely a default but we should discuss
7. Can we add � I want to be able to save or download or print off sections of the course for reference later.
 This is a function of the LMS and wouldn�t need a personal preference. 




 -->

    