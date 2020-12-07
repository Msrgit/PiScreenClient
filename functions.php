<?php

function isOnline()
{
    exec("ping -c1 -n -w1 8.8.8.8 > /dev/null 2>&1; echo $?",  $result);
    return $result[0] == 0;
}

function showit($message, $timeout=10, $type="info")
{

    switch ($type){
    case "info":
        $title="<span foreground='green' font='48'>For information</span>\n\n";
        break;
    case "warn":
        $title="<span foreground='orange' font='48'>Action needed</span>\n\n";
        break;
    case "error":
        $title="<span foreground='red' font='48'>Error detected</span>\n\n";
        break;
    }
    $yad="--center --display=:0 --width=1000 --height=600 --fixed --title='PiScreen Message' ";
    $yad= $yad . "--text=\"". $title . " <span foreground='blue' font='32'>" . $message . "</span>\" ";
    $yad= $yad . "--timeout=" . $timeout ;
    exec("yad $yad", $result);
}

function firstTime()
{
    showit("Check for new device processing",2);
    exec("findmnt -bno size /", $result);
    showit("Result is: $result[0]",2);
    if($result[0] < 4000000000)
    {
        showit("As part of the setup this PiScreen will restart in a moment",5);
        exec("sudo raspi-config --expand-rootfs > /dev/null && touch #/fsx.done && sudo reboot", $result2);
    }

}
function startAP()
{
    showit("AP Starting");
}

