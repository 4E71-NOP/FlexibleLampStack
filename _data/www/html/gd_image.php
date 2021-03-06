<?php
error_reporting ( E_ERROR | E_WARNING | E_PARSE | E_NOTICE );
header ( "Content-type: image/png" );
$im = ImageCreate ( 480, 32 ) or die ( "Erreur lors de la création de l'image" );
$backgroundColor = ImageColorAllocate ( $im, 64, 128, 255 );

$textColor = imagecolorallocate ( $im, 255, 255, 255 );
$textShadow = imagecolorallocate ( $im, 0, 64, 128 );
$msg = "GD seems to work... somehow";
imagestring ( $im, 5, 12, 12, 'Default font : ' . $msg, $textShadow );
imagestring ( $im, 5, 10, 10, 'Default font : ' . $msg, $textColor );

ImagePng ( $im );
?>
