# Resources for level10

## Walkthrough to capture the flag:

### Step 1: Find files owned by user `flag00`
```bash
find / -user flag00 2>/dev/null
```
> Output:
```
/usr/sbin/john
/rofs/usr/sbin/john
```

### Step 2: Read the encrypted string
```bash
cat /rofs/usr/sbin/john
```
> Output:
```
cdiiddwpgswtgt
```

### Step 3: Decrypt it (likely ROT13)
Decrypted password: `nottoohardhere`

### Step 4: Switch to `flag00` user
```bash
su flag00
# enter password: nottoohardhere
```

### Step 5: Get the flag
```bash
getflag
```
> Output:
```
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```
