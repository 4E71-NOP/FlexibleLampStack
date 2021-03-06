<?php
error_reporting ( E_ERROR | E_WARNING | E_PARSE | E_NOTICE );
header ( "Content-type: image/png" );
$im = ImageCreate ( 480, 32 ) or die ( "Erreur lors de la création de l'image" );
$backgroundColor = ImageColorAllocate ($im, 64, 192, 255);

$textColor = imagecolorallocate ( $im, 255, 255, 255 );
$textShadow = imagecolorallocate($im, 0, 64, 128);
$msg = "GD seems to work... somehow";
// $font = "/var/www/html/MWM/Hydr/Hydr/gfx/Magma/HARNGTON.TTF";
$font = "/usr/share/fonts/truetype/liberation/LiberationMono-Regular.ttf";

imagettftext ( $im, 20, 0, 26, 26, $textShadow, $font, $msg );
imagettftext ( $im, 20, 0, 25, 25, $textColor, $font, $msg );

ImagePng ( $im );

?>
