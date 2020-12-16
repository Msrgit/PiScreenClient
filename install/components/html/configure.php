<html>
<body>

<?php
require_once "functions.php";
echo $_POST["ap"];
echo "<br>".$_POST["password"];
update_wpa($_POST["ap"], $_POST["password"]);



?>
</body>
</html>
