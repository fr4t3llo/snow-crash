


# SnowCrash Level02 Walkthrough

This walkthrough explains how we retrieved the flag for `level02` in the SnowCrash wargame.

---

## Step 1: Discovering the `.pcap` File

After logging into `level02`, we find a file:

```bash
ls
# Output:
level02.pcap
```

> **Note:** `.pcap` stands for **Packet CAPture**. It's used by network monitoring tools like Wireshark to store captured network data (TCP, UDP, etc).

---

## Step 2: Analyzing with Wireshark

To inspect the `.pcap` file, we transfer it to Kali Linux using `scp`:

```bash
scp -P 4242 level02@10.11.100.131:/home/user/level02/level02.pcap .
```

Then open the file with Wireshark and search for the keyword `password`.

We find a login attempt that looks like this:

```
..%
..%
..&..... ..#..'..$
..&..... ..#..'..$
.. .....#.....'.........
.. .38400,38400....#.SodaCan:0....'..DISPLAY.SodaCan:0......xterm..
........"........!
........"..".....b........b....	B.
..............................1.......!
.."....
.."....
..!..........."
........"
..".............	..
.....................
Linux 2.6.38-8-generic-pae (::ffff:10.1.1.2) (pts/10)

..wwwbugs login: 
l
.l
e
.e
v
.v
e
.e
l
.l
X
.X


..
Password: 
ft_wandr...NDRel.L0L

.
..
Login incorrect
wwwbugs login: 


```

This appears to be an incorrect password attempt due to `0x7f` characters (ASCII delete) in the middle. By examining the hex values, we identify these characters:

```
000000B9  66                                                 f
000000BA  74                                                 t
000000BB  5f                                                 _
000000BC  77                                                 w
000000BD  61                                                 a
000000BE  6e                                                 n
000000BF  64                                                 d
000000C0  72                                                 r
000000C1  7f                                                 .
000000C2  7f                                                 .
000000C3  7f                                                 .
000000C4  4e                                                 N
000000C5  44                                                 D
000000C6  52                                                 R
000000C7  65                                                 e
000000C8  6c                                                 l
000000C9  7f                                                 .
000000CA  4c                                                 L
000000CB  30                                                 0
000000CC  4c                                                 L
```

After cleaning up the delete characters, we get the correct password:

**`ft_waNDReL0L`**

---

## Step 3: Switching to the `flag02` User

```bash
su flag02
Password: ft_waNDReL0L
```

Then we run:

```bash
getflag
```

We get the flag:

```
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
```

Finally, we use this token to switch to the next user:

```bash
su level03
Password: kooda2puivaav1idi4f57q8iq
```

---

## ✅ Summary

- Transferred `.pcap` file and opened it in Wireshark
- Found login data with corrupted password (due to `DEL` characters)
- Reconstructed correct password
- Switched to user `flag02` and retrieved the flag

**Flag:** `kooda2puivaav1idi4f57q8iq`
