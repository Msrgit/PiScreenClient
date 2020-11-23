<?php

require_once "functions.php";
require_once "messages.php";
while (true) {
    if (! isOnline() ) {
        showit($MSG_OFFLINE, 20, "warn");
        startAP();
    }else{
        showit("Online\n\nmessage",5, "info");
    }
    sleep(5);
}

