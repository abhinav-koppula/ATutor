<?php
$output = array();
$return_val = 0;
echo exec('phing', $output , $return_val);
$url = 'http://' . $_SERVER['HTTP_HOST'];            // Get the server
$url .= rtrim(dirname($_SERVER['PHP_SELF']), '/\\'); // Get the current directory
$url .= '/reports/phpunit-noframes.html';            // <-- Your relative path
header('Location: ' . $url, true, 302);              // Use either 301 or 302
?>