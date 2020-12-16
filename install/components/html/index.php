<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="piscrds.css">
</head>
<body>
<?php
require_once "functions.php";
echo "Time is: ".date('H:i:s');
?>
<h1>Let's get this PiScreen Connected!</h1>
<hr/>
<form action="configure.php" method="post">
<h2>Choose your WiFi:</h2>

<?php 
foreach (get_access_points() as $ap){
echo "<input type='radio' id='$ap' name='ap' value='$ap' class='radio' required>";
echo "<label for='$ap' class='label'>$ap</label><br />";
}
?>

<p>
<strong>Password:</strong><br />
<input type="password" name="password" class='password' value="" required autocomplete="off" />
</p>
<input type="submit" name="submit" value="Connect" />
</form>
</body>
</html>
