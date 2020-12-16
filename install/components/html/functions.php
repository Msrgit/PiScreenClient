<?php

function get_access_points()
{
    $aplist=[];
    $trycount=0;
    while (count($aplist)<1)
    {
        $trycount+=1;
        sleep(($trycount > 1 ? 1 : 0));
        exec("sudo /sbin/iw dev wlan0 scan | grep SSID: | sort | uniq | sed 's/SSID://' | sed -e 's/^[ \t]*//' | sed 's/\"//g'", $aplist,$retvar);
        if ($trycount > 10){
            echo "<h1>Failed to find WiFi</h1>";
            echo "<p>Please make sure you are within range of a working WiFi access point</p>";
            die("Stopped trying after $trycount attempts");
        }
    }
    return $aplist;
}

function addNetwork($ssid, $passphrase)
{



}

function isOnline()
{
    exec("ping -c1 -n -w1 8.8.8.8 > /dev/null 2>&1; echo $?", $result, $status);
    return $result[0]==0;
}
function update_wpa($ssid, $password)
{

    echo "<p>Updating WPA for $ssid</p>";

}

?>
