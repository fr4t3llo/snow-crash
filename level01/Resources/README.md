# SnowCrash Level01 Walkthrough

This walkthrough explains how we retrieved the flag for `level01` in the SnowCrash wargame.

---

## Step 1: Read `/etc/passwd`

After logging into `level01`, we run the following command:

```bash
cat /etc/passwd
```

We observe the following entry among others:

```
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```

The hash `42hDRfypTqqnw` seems suspicious, suggesting a password is stored in plaintext (likely DES-encrypted).

---

## Step 2: Crack the password using John the Ripper

We save the password hash into a file and use John to crack it:

```bash
echo 42hDRfypTqqnw > pass
john --format=descrypt pass
```

John proceeds with cracking:

```
Loaded 1 password hash (descrypt, traditional crypt(3) [DES 256/256 AVX2])
...
abcdefg          (?)     
Session completed.
```

The password is: `abcdefg`

---

## Step 3: Switch to the `flag01` user

```bash
su flag01
Password: abcdefg
```

Once logged in, we run the command to get the flag:

```bash
getflag
```

And we get the token:

```
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```

---

## ✅ Summary

- Found DES hash in `/etc/passwd`
- Cracked password using `john`
- Switched to user `flag01`
- Used `getflag` to retrieve the flag

**Flag:** `f2av5il02puano7naaf6adaaf`