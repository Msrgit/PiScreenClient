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

function startAP()
{
    showit("AP Starting");
}

