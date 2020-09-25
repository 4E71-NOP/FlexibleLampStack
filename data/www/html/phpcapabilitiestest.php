<?
echo ("<h1>Testing PHP capabilites.</h1><br>");

echo ("<h4>Testing PHP connection to mysql.</h4><p>");
if ( function_exists ("mysqli_connect")) {
    $link = mysqli_connect("mysql", "docker", "1a2b3c4d", "docker");
    
    if (!$link) {
        echo "Error : Unable to connect to mysql" . "<br>";
        echo "Errno  : " . mysqli_connect_errno() . "<br>";
        echo "Error msg : " . mysqli_connect_error() . "<br>";
        exit;
    }
    
    echo "Success : Connexion to the database was sucessful." . "<br>";
    echo "Host info : " . mysqli_get_host_info($link) . "<br>";
    
    mysqli_close($link);
}
else {
    echo("ERROR : The function mysqli_connect() isn't available<br>");
}
echo ("</p><br>");

echo ("<h4>Testing PHP connection to postgres.</h4><p>");
if ( function_exists ("pg_connect")) {
    $link = pg_connect("host=postgres port=5432 dbname=docker user=docker password=1a2b3c4d");
    if (!$link) {
        echo "Error : Unable to connect to postgres" . "<br>";
        echo "Errmsg  : " . pg_last_error($link);
        exit;
    }
    
    echo "Success : Connexion to the database was sucessful." . "<br>";
    echo "Host info : " . pg_host($link) . "<br>";
    
    pg_close($link);
}
else {
    echo("ERROR : The function pg_connect() isn't available<br>");
}
echo ("</p><br>");


echo ("<h4>GD</h4>");
echo ("<p>");
if (function_exists("gd_info()")) {
    var_dump(gd_info());
}
else {
    echo("ERROR : The function gd_info() isn't available<br>");
}
echo ("</p>");


echo ( "<p>".var_dump(PDO::getAvailableDrivers()) ."</p>");


?>
