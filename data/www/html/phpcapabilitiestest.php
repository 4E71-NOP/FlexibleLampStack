<?php
echo ("
<html>
<head>	
<style type='text/css'>
<!--
body {\r
    font-family: 'arial';\r
}\r
h1 {\r
    background-color: #40804080;\r
    padding:10px;\r
    font-style: italic;\r
    color : #FFFFFF;\r
    text-shadow: #000000C0 2px 2px 3px;\r
}\r
h4 {\r
    background-color: #00008080;\r
    padding:10px;\r
    color : #FFFFFF;\r
    text-shadow: #000000C0 2px 2px 3px;\r
}\r
table {\r
    width: 60%;\r
    margin-left: auto;\r
    margin-right: auto;\r
}\r
table > tbody > tr {\r
    background-color: #00808040;\r
}\r
table > tbody > tr > td {\r
    padding : 10px;\r
}\r

-->
</style>
</head>
<body>
");

echo ("<h1>Testing PHP capabilites.</h1><br>");

echo ("<h4>Testing PHP connection to mysql.</h4><p>");
if (function_exists ( "mysqli_connect" )) {
	$link = mysqli_connect ( "mysql", "docker", "1a2b3c4d", "docker" );

	if (! $link) {
		echo "ERROR : Unable to connect to mysql" . "<br>";
		echo "Errno  : " . mysqli_connect_errno () . "<br>";
		echo "Error msg : " . mysqli_connect_error () . "<br>";
	}

	echo "Success : Connexion to the database was sucessful." . "<br>";
	echo "Host info : " . mysqli_get_host_info ( $link ) . "<br>";

	mysqli_close ( $link );
} else {
	echo ("The function mysqli_connect() isn't available<br>");
}
echo ("</p><br>");

echo ("<h4>Testing PHP connection to postgres.</h4><p>");
if (function_exists ( "pg_connect" )) {
	$link = pg_connect ( "host=postgres port=5432 dbname=docker user=docker password=1a2b3c4d" );
	if (! $link) {
		echo "ERROR : Unable to connect to postgres" . "<br>";
		echo "Errmsg  : " . pg_last_error ( $link );
	}

	echo "Success : Connexion to the database was sucessful." . "<br>";
	echo "Host info : " . pg_host ( $link ) . "<br>";

	pg_close ( $link );
} else {
	echo ("The function pg_connect() isn't available<br>");
}
echo ("</p><br>");

echo ("<h4>GD</h4>");
echo ("<p>");
if (function_exists ( "gd_info()" )) {
	var_dump ( gd_info () );
} else {
	echo ("The function gd_info() isn't available<br>");
}

if (! extension_loaded ( 'gd' )) {
	echo ("extension is <b>NOT</b> loaded<br>");
} else {
	echo ("GD extension <b>IS</b> loaded<br>
    <table>
        <tr>
            <td>
                Default font
            </td>
            <td>
                <img src='gd_image.php'><br>
            </td>
        </tr>
        <tr>
            <td>
                TTF font
            </td>
            <td>
                <img src='gd_imagettf.php'><br>
            </td>
        </tr>
    </table>
    ");
}
echo ("</p>");

echo ("<hr><p>Available drivers:<br>");
echo (var_dump ( PDO::getAvailableDrivers () ));
echo ("</p>");

echo ("
<hr>
<p>
Part of Flexible LAMP Stack.
</p>
    </body>
    </html>
");

?>
