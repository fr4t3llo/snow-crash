# Level14 - SnowCrash Walkthrough

## Step 1: No Executable Found

In this level, we don’t find any user-owned executable file:

```bash
level14@SnowCrash:~$ ls
# (nothing interesting or executable here)
```

Running the `getflag` binary directly produces a message indicating failure:

```bash
level14@SnowCrash:~$ getflag
Check flag.Here is your token :
Nope there is no token here for you sorry. Try again :)
```

---

## Step 2: Analyzing `getflag` with GDB

Since `getflag` seems to have internal logic based on conditions, we analyze it with GDB:

```bash
level14@SnowCrash:~$ gdb getflag
(gdb) disassemble main
```



Inside the disassembled code, we find a call to the `ft_des` function late in the program:

```asm
...
0x08048de5 <+1183>: mov    0x804b060,%eax
0x08048dea <+1188>: mov    %eax,%ebx
0x08048dec <+1190>: movl   $0x8049220,(%esp)
0x08048df3 <+1197>: call   0x8048604 <ft_des>
...
```

This function likely generates or prints the token when the right conditions are met.

---

## Step 3: Forcing Execution to Token Logic

We can bypass the checks by jumping directly to the instruction that sets things up for `ft_des`.

Set a breakpoint at the start of `main()`:

```bash
(gdb) break *0x08048946
Breakpoint 1 at 0x8048946
```

Run the program:

```bash
(gdb) run
```

When the breakpoint hits:

```bash
(gdb) jump *0x08048de5
Continuing at 0x8048de5.
```

This forces execution to the part of the program that generates the flag.

The program prints the token:

```
7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
```

You may also see some runtime errors like:

```
*** stack smashing detected ***: /bin/getflag terminated
Program received signal SIGSEGV, Segmentation fault.
```

These can be ignored for our purposes, since the flag is already printed before the crash.

---

## Conclusion

We exploited the program flow by jumping to the location where the `getflag` binary would normally execute its token-revealing logic if the correct conditions were met.

**Token:** `7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ`
