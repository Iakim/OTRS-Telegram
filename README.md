# OTRS + Telegram integration
This document is intended to perform the integration of OTRS with Telegram.

### 1: Create a bot in telegram, and get the groupid for send menssages, follow this steps "https://github.com/Iakim/Zabbix-Telegram/blob/master/Zabbix-Telegram-com-graficos.pdf" to page two.

### 2: Download the files telegram-otrs.sh, otrs.txt and create old.txt with 0 value "echo 0 > /opt/old.txt" for the /opt path.

### 3: Change the telegram-otrs.sh

    BOT_TOKEN='866542761:AAFPNvQ3SMjngpnYosbcdLQG6MeMg8oKkzA'
    USER='-358887503'

### 4: Change the otrs.txt

    user=otrsuserdatabase
    password=otrspassworddatabase
    
### 5: Create a crontab like:
    
    */5 * * * * sh /opt/telegram-otrs.sh
