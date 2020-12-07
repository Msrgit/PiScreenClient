<?php

require_once "functions.php";
require_once "messages.php";
showit("Main starting - waiting",2);
firstTime();
if (! isOnline() ) {
    if (! getOnline() ){

    }


    showit("Confirm successful network connection.\nWarn if failure",2);
    showit("Get device information",2);
    showit("Confirm license validity",2);
    showit("Get device schedule",2);
    showit("Download files on schedule",2); 

    while (true) {
        showit("Top of main loop",2);

        if (! isOnline() ) {
            showit($MSG_OFFLINE, 20, "warn");
            startAP();
        }else{
            showit("Device is online",2);
        }
        showit("Check for schedule change",2);
        showit("Start/continue scheduled media (dispatcher)",2);

        showit("Bottom of main loop",2);
    }

