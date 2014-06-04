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
// $Id: $

/**
 * Tests utility functions for the infusion builder.
 */
/*
define("SIMPLETEST_PATH", 'tests/simpletest/');
require_once (SIMPLETEST_PATH.'autorun.php');
require_once(SIMPLETEST_PATH.'web_tester.php');

class TestAssessmentsUtils extends WebTestCase
{
    function test1(){
        $this->get('http://127.0.0.1/open_source/new_AT/ATutor/mods/_standard/tests/create_test.php');
        $this->assertResponse(200);
        $this->setField("title", "SimpleTest Assessment");
        $this->clickSubmitByName("submit");
        $this->assertResponse(200);
    }
}*/

class AssessmentsUtilsTest extends PHPUnit_Extensions_Selenium2TestCase
{
    protected function setUp()
    {
        $this->setHost('localhost');
        $this->setPort(4444);
        $this->setBrowser('firefox');
        $this->setBrowserUrl('http://localhost/open_source/new_AT/ATutor/');
        
    }

    /*
    *
    * Tests the title of PHPRO.ORG is correct
    *
    */
    /*
    public function testTitle()
    {
        $title = 'Course Server: Login';
        $this->url('http://localhost/open_source/new_AT/ATutor/login.php');
        $this->assertEquals( $title, $this->title());
    }*/
    
    public function testLogin()
    {
        $login_id = 'mancoolgunda';
        $login_password = 'abhinav';
        
        $this->url('http://localhost/open_source/new_AT/ATutor/login.php');
        $form = $this->byName('form');
        
        $this->byName('form_login')->value($login_id);
        $this->byName('form_password')->value($login_password);
        
        $action = $form->attribute('action');
        $this->assertEquals( 'http://localhost/open_source/new_AT/ATutor/login.php', $action);
        $this->byName("submit")->click();
        
        $this->byLinkText("CSE101")->click();
        
        $this->waitUntil(function () {
            if ($this->byCssSelector('h1')) {
            return true;
            }
            return null;
        }, 5000);
        
        $this->byLinkText("Manage")->click();
        $this->waitUntil(function () {
            if ($this->byCssSelector('h1')) {
            return true;
            }
            return null;
        }, 5000);
        $this->byLinkText("Create Test/Survey")->click();
        $this->waitUntil(function () {
            if ($this->byCssSelector('h1')) {
            return true;
            }
            return null;
        }, 5000);
        
        $this->byId('title')->value("Simulated Test");
        $this->byXPath("//input[@value='Save']")->click();
    }
    
}
?>
?>
