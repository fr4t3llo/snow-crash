# Level13 - SnowCrash Walkthrough

## Step 1: Exploring the Binary

We start by listing the contents of the home directory:

```bash
level13@SnowCrash:~$ ls
level13
```

We find an executable named `level13`.

Running it directly shows the following message:

```bash
level13@SnowCrash:~$ ./level13
UID 2013 started us but we expect 4242
```

This means the program checks the current user ID and expects UID 4242 to proceed.

---

## Step 2: Analyzing with GDB

To understand what's happening inside the binary, we open it in GDB:

```bash
gdb ./level13
(gdb) disassemble main
```

We inspect the disassembled code of the `main` function:

```asm
0x08048595 <+9>:  call   0x8048380 <getuid@plt>
0x0804859a <+14>: cmp    $0x1092,%eax     ; 0x1092 = 4242
0x0804859f <+19>: je     0x80485cb        ; jump to success if UID == 4242
```

The program uses `getuid()` and compares the result with `0x1092` (decimal 4242). If the UID matches, it jumps to the code that prints the flag.

As we don't have UID 4242, we need to bypass the check.

---

## Step 3: Bypassing UID Check

We can use GDB to force execution to skip the UID check and jump directly to the code that reveals the flag.

Set a breakpoint just before the comparison:

```bash
(gdb) break *0x08048595
Breakpoint 1 at 0x8048595
```

Run the program:

```bash
(gdb) run
Starting program: /home/user/level13/level13
```

When the breakpoint is hit:

```bash
Breakpoint 1, 0x08048595 in main ()
```

Force a jump to the success branch:

```bash
(gdb) jump *0x080485cb
Continuing at 0x80485cb.
```

You will see the flag printed:

```
your token is 2A31L79asukciNyi8uppkEuSx
```

---

## Conclusion

The program checks if the current UID is 4242. Since we cannot change our UID, we use GDB to skip the check and force execution to continue as if the UID matched. This reveals the flag.

**Token:** `2A31L79asukciNyi8uppkEuSx`
