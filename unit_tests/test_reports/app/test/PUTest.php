<?php

class PUTest extends PHPUnit_Framework_TestCase {
    public function test_this() {
        $key = 'test';
        $value = 'test';
        print_r('some stuff');
        $this->assertEquals($key, $value, 'test_this() failed!');
    }

    public function test_this_too() {
        $somestr = 0;
        $key = 'test';
        $value = 'value';
        $this->assertEquals($key, $value, 'test_this_too() failed!');
    }
    
    public function test_testing() {
        $expected = "abc";
        $actual = "abc";
        $this->assertEquals($expected, $actual);
    }
            
}

?>
