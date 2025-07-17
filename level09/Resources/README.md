# SnowCrash Level09 Walkthrough

This walkthrough explains how we retrieved the flag for `level09` in the SnowCrash wargame.

---

## Step 1: Exploring the Environment

After logging into `level09`, we run:

```bash
level09@SnowCrash:~$ ls
level09  token
```

We discover an executable file `level09` and a file named `token`.

---

## Step 2: Testing the Executable

We run the executable with the token as argument:

```bash
level09@SnowCrash:~$ ./level09 token
tpmhr
```

Trying a custom input gives us hint:

```bash
level09@SnowCrash:~$ ./level09 "1337 coding school"
145:$hukqwq+pv~}
```

---

## Step 3: Viewing the Token File

Let's examine the contents of the `token` file:

```bash
level09@SnowCrash:~$ cat token
f4kmm6p|=�p�n��DB�Du{��
```

It looks encoded. Our assumption is that the program encodes its input, so we’ll reverse the process.

---

## Step 4: Writing a Decoder in C

We write a small C program to reverse the transformation:

```c
#include <stdio.h>

int main(int ac, char **av)
{
    if (ac < 2)
        return 1;

    int i = 0;
    char *token = av[1];

    while (*token)
    {
        printf("%c", *token - i);
        i++;
        *token++;
    }
    printf("\n");
}
```

---

## Step 5: Compiling the Decoder

We initially try to compile in the home directory but encounter a permission issue:

```bash
level09@SnowCrash:~$ gcc /tmp/decod.c -o /tmp/decod
Cannot create temporary file in ./: Permission denied
Aborted (core dumped)
```

We navigate to `/tmp` and compile successfully:

```bash
level09@SnowCrash:~$ cd /tmp
level09@SnowCrash:/tmp$ gcc decod.c -o decod
```

---

## Step 6: Decoding the Token

We decode the `token` using our compiled program:

```bash
level09@SnowCrash:~$ cat ~/token | xargs /tmp/decod
f3iji1ju5yuevaus41q1afiuq
```

This string is the password for the `flag09` user.

---

## Step 7: Switching User and Getting the Flag

```bash
level09@SnowCrash:~$ su flag09
Password: f3iji1ju5yuevaus41q1afiuq

Don't forget to launch getflag !

flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```

---

## ✅ Summary

- Analyzed output behavior of binary
- Reversed its encoding logic using a C program
- Decoded the `token` to retrieve the `flag09` password
- Switched to user `flag09` and ran `getflag`

**Flag:** `s5cAJpM8ev6XHw998pRWG728z`
