<?php

class MyTest extends PHPUnit_Framework_TestCase {
    /*
    public function test_this() {
        $this->assertEquals('hello','hello');
    }
    */
    public function test_thistoo() {
        $key = 'test';
        $value = 'test';
        
        //print_r('foo breaks: this { bar');
        $this->assertEquals($key, $value);
    }
    
    public function test_testing() {
        $expected = "abc";
        $actual = "abc";
        $this->assertEquals($expected, $actual);
    }
}

?>
