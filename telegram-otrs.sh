#!/bin/bash
###################################################################################
## OTRS-Telegram					   		 	 ##
## Script bash for integration for OTRS + Telegram				 ##
## Author: https://github.com/Iakim 				    		 ##
## Simplicity is the ultimate degree of sophistication		    		 ##
###################################################################################

SUBJECT="$text"
SUBJECT="${SUBJECT//,/ }"
MESSAGE="chat_id=${USER}&text=$text"
OTRSMSG="/tmp/otrs-message-$(date "+%Y.%m.%d-%H.%M.%S").tmp"
BOT_TOKEN='868882761:AAFPNvQ3SMjngpnYovfABCDG6MeMg8oKkzA'
USER='-357888503'
CURL="/usr/bin/curl"
COOKIE="/tmp/telegram_cookie-$(date "+%Y.%m.%d-%H.%M.%S")"
IDSQL=`mysql --defaults-extra-file=/opt/otrs.txt -e 'use otrs; select id, tn, title, customer_user_id, create_time from ticket;' | tail -n1 | sed 's/ /_/g' | awk '{print$1}'`
OLDIDSQL=`cat /opt/old.txt`
if [ "$IDSQL" -gt "$OLDIDSQL" ]
then
	echo "$IDSQL" > /opt/id.txt
	TNSQL=`mysql --defaults-extra-file=/opt/otrs.txt -e 'use otrs; select id, tn, title, customer_user_id, create_time from ticket;' | tail -n1 | sed 's/ /_/g' | awk '{print$2}'`
	TITLESQL=`mysql --defaults-extra-file=/opt/otrs.txt -e 'use otrs; select id, tn, title, customer_user_id, create_time from ticket;' | tail -n1 | sed 's/ /_/g' | awk '{print$3}'`
	USERSQL=`mysql --defaults-extra-file=/opt/otrs.txt -e 'use otrs; select id, tn, title, customer_user_id, create_time from ticket;' | tail -n1 | sed 's/ /_/g' | awk '{print$4}'`
	DATECREATESQL=`mysql --defaults-extra-file=/opt/otrs.txt -e 'use otrs; select id, tn, title, customer_user_id, create_time from ticket;' | tail -n1 | sed 's/ /_/g' | awk '{print$5}'`
	A="Número: $TNSQL"
	B="Título: $TITLESQL"
	C="Cliente: $USERSQL"
	D="Data de Criação: $DATECREATESQL"
	SUBJECT="Você tem um novo chamado no OTRS!"
	SUBJECT=`echo $SUBJECT | sed 's/ /%20/g'`
	SUBJECT="${SUBJECT//,/ }"
	echo "$MESSAGE" > $OTRSMSG
	${CURL} -k -s -c ${COOKIE} -b ${COOKIE} -s -X GET "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage?chat_id=${USER}&text="${SUBJECT}""  > /dev/null
	${CURL} -k -s -c ${COOKIE} -b ${COOKIE} --data-binary @"${OTRSMSG}" -X GET "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"  > /dev/null
	rm -f ${COOKIE}
	rm -f ${OTRSMSG}
	
	for i in "$A" "$B" "$C" "$D";
	do
		SUBJECT="$i"
		SUBJECT=`echo $SUBJECT | sed 's/ /%20/g'`
		SUBJECT="${SUBJECT//,/ }"
		echo "$MESSAGE" > $OTRSMSG
		${CURL} -k -s -c ${COOKIE} -b ${COOKIE} -s -X GET "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage?chat_id=${USER}&text="${SUBJECT}""  > /dev/null
		${CURL} -k -s -c ${COOKIE} -b ${COOKIE} --data-binary @"${OTRSMSG}" -X GET "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage"  > /dev/null
		rm -f ${COOKIE}
		rm -f ${OTRSMSG}
	done
	rm -rf /opt/old.txt
	mv /opt/id.txt /opt/old.txt
else
	exit 0
fi
