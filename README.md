# OTRS + Telegram integration for notification new ticket
This document is intended to perform the integration of OTRS with Telegram.

### 1: Create a new bot in telegram, and get the groupid for send menssages

    Follow this steps "https://github.com/Iakim/Zabbix-Telegram/blob/master/Zabbix-Telegram-com-graficos.pdf" to page two.

### 2: Download the files, and create the old.txt file:
    cd /opt
    curl -O https://raw.githubusercontent.com/Iakim/OTRS-Telegram/master/telegram-otrs.sh
    curl -O https://raw.githubusercontent.com/Iakim/OTRS-Telegram/master/otrs.txt
    echo 0 > old.txt.

### 3: Change the telegram-otrs.sh

    BOT_TOKEN='866888761:AAFPNvQ3SMjngpABCDXrLQG6MeMg8oKkzA'
    USER='-357688803'

### 4: Change the otrs.txt

    user=otrsuserdatabase
    password=otrspassworddatabase
    
### 5: Create a crontab like:
    
    */1 * * * * sh /opt/telegram-otrs.sh
