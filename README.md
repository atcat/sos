# sos

## Terminal Utilities

### l

Use `l` to recursively list files and folders.

`l`: For each path under `pwd`, lists: size, last modified time, path

`l -1`: Only prints path, disables colorization.

`l -n`: Same as `l`, but disable colorization.

#### l time, l size, l type

`l time`: Sort `l` by modified time

`l size`: Sort `l` by file size

`l type`: Sort `l` by file extension

#### l 1, l 2, l 3, ...

`l 1`: Examine `pwd/*`, no recursion.

`l 2`: Examine `pwd/*/*`, i.e. upto child folders.

`l 3`: Examine `pwd/*/*/*`, i.e. upto grandchild folders.


`l -n ~/Downloads | igrep \\.pdf`

#### Some examples of l

```sh
#
# Search for all zipfiles under $HOME, sorted by filesize.
#

$ time l ~ size | igrep zip
[... snip ...]
107K   2015-07-10 07:34:51  /Users/atcat/Downloads/fix_yosemite_vm_graphic_performance.zip
107K   2015-07-10 07:34:51  /Users/atcat/bin/fix_yosemite_vm_graphic_performance.zip
1.3M   2015-07-01 23:36:27  /Users/atcat/Downloads/Knox-2.3.2.zip
1.8M   2015-07-02 00:25:09  /Users/atcat/Downloads/HyperSwitch.zip
2.1M   2015-06-29 19:09:36  /Users/atcat/Downloads/OptimalLayout2.zip
12M    2015-06-29 19:32:52  /Users/atcat/Downloads/Geekbench-3.3.2-Mac.zip
104M   2015-06-29 19:44:01  /Users/atcat/Downloads/CINEBENCH_R15.zip

real	0m9.633s
user	0m7.088s
sys	0m2.662s

#
# Search for all zipfiles under $HOME upto three levels deep, sorted
# by filesize.
#

$ time l ~ 3 size | igrep zip
107K   2015-07-10 07:34:51  /Users/atcat/Downloads/fix_yosemite_vm_graphic_performance.zip
107K   2015-07-10 07:34:51  /Users/atcat/bin/fix_yosemite_vm_graphic_performance.zip
1.3M   2015-07-01 23:36:27  /Users/atcat/Downloads/Knox-2.3.2.zip
1.8M   2015-07-02 00:25:09  /Users/atcat/Downloads/HyperSwitch.zip
2.1M   2015-06-29 19:09:36  /Users/atcat/Downloads/OptimalLayout2.zip
12M    2015-06-29 19:32:52  /Users/atcat/Downloads/Geekbench-3.3.2-Mac.zip
104M   2015-06-29 19:44:01  /Users/atcat/Downloads/CINEBENCH_R15.zip


real	0m0.479s
user	0m0.333s
sys	0m0.159s

#
# Search for our most recently downloaded pdfs.
#
$ l ~ 4 time | igrep \\.pdf
2.5M  2015-06-30 18:58:37  /Users/atcat/Downloads/onlisp.pdf
141K  2015-07-02 02:31:21  /Users/atcat/Downloads/jmc.pdf
3.8M  2015-07-05 01:51:57  /Users/atcat/Downloads/The Art of the Interpreter.pdf
160K  2015-07-05 17:36:25  /Users/atcat/Downloads/cljs-cheatsheet.pdf
```



## Commandline

### firstline, lastline, skipfirst, skiplast

```sh
$ printf " foo\n bar\n baz\n a\n b\n c\n"
 foo
 bar
 baz
 a
 b
 c

$ printf " foo\n bar\n baz\n a\n b\n c\n" | firstline
 foo

$ printf " foo\n bar\n baz\n a\n b\n c\n" | lastline
 c

$ printf " foo\n bar\n baz\n a\n b\n c\n" | firstline 4
 foo
 bar
 baz
 a

$ printf " foo\n bar\n baz\n a\n b\n c\n" | firstline 4 | lastline 2
 baz
 a
```

### skipfirst, skiplast

```sh
$ printf " foo\n bar\n baz\n a\n b\n c\n"
 foo
 bar
 baz
 a
 b
 c

$ printf " foo\n bar\n baz\n a\n b\n c\n" | skipfirst
 bar
 baz
 a
 b
 c

$ printf " foo\n bar\n baz\n a\n b\n c\n" | skiplast
 foo
 bar
 baz
 a
 b

$ printf " foo\n bar\n baz\n a\n b\n c\n" | skipfirst 2
 baz
 a
 b
 c

$ printf " foo\n bar\n baz\n a\n b\n c\n" | skipfirst 2 | skiplast 3
 baz

```

### nthline

```sh
$ printf " foo\n bar\n baz\n a\n b\n c\n"
 foo
 bar
 baz
 a
 b
 c

$ printf " foo\n bar\n baz\n a\n b\n c\n" | nthline 0
 foo

$ printf " foo\n bar\n baz\n a\n b\n c\n" | nthline 1
 bar

$ printf " foo\n bar\n baz\n a\n b\n c\n" | nthline -1
 c

$ printf " foo\n bar\n baz\n a\n b\n c\n" | nthline -2
 b
 ```

### contains

Exits with code 0 if stdin matches the Python regex specified on the
commandline; else exits with 1.

```sh
$ $(echo "foo" | contains "o") && echo hi

$ $(echo "foo" | contains "g") && echo hi
hi

```

### math

For doing arithmetic.

```sh
$ math '1 + 1'
2

$ math '1 + 1.0'
2.0

$ math '(1 + 1) / 2'
1.00

$ math '(1 + 1) / 4'
.50

$ math '(1 + 1) / 3'
.66

$ hrs=2.5; echo "${hrs} hours is $(math "${hrs} * (60 * 60)") seconds"
2.5 hours is 9000.0 seconds
```

### trim, ltrim, rtrim

Strips whitespace from both/left/right sides of stdin.
(Note: To trim each line of stdin, use the `*trimlines` variants)

```sh
$ echo " foo bar "
 foo bar 

$ echo " foo bar " | trim
foo bar$ 

$ echo " foo bar " | rtrim
 foo bar$ 

$ echo " foo bar " | ltrim
foo bar 
```

### revlines

for line in stdin:
  print reverse(line)

```sh
$ printf "foo\nbar\nbaz\n"
foo
bar
baz

$ printf "foo\nbar\nbaz\n" | revlines
oof
rab
zab

```

### replace

For each pair of commandline arguments x, y: stdin.replace(x, y)

For commandline args, transforms '\n' into newline, '\r' into carriage
return, '\t' into tab, etc.  Also transforms unicode like '\u0000',
etc.

```sh
$ printf "foo\nbar\nbaz\n"
foo
bar
baz

$ printf "foo\nbar\nbaz\n" | replace 'o' 'z'
fzz
bar
baz

$ printf "foo\nbar\nbaz\n" | replace 'o' 'z' 'z' '1'
f11
bar
ba1

$ printf "foo\nbar\nbaz\n" | replace 'z' '1' 'o' 'z'
fzz
bar
ba1

$ printf "foo\nbar\nbaz\n" | replace 'z' '1' 'o' 'z' 'a' '\\n'
fzz
b\nr
b\n1

$ printf "foo\nbar\nbaz\n" | replace 'z' '1' 'o' 'z' 'a' '\\n' '\\n' '\n'
fzz
b
r
b
1

```

### natsort

Performs a natural sort of stdin's lines.

```sh
$ printf " 10\n 11\n 12\n 1\n 2\n 3\n"
 10
 11
 12
 1
 2
 3

$ printf " 10\n 11\n 12\n 1\n 2\n 3\n" | sort
 1
 10
 11
 12
 2
 3

$ printf " 10\n 11\n 12\n 1\n 2\n 3\n" | natsort
 1
 2
 3
 10
 11
 12

```

### human2bytes, bytes2human

`human2bytes` converts the first numeric column from a "human size" to bytes.

`bytes2human` undoes the operation.  (Note: Lossy.)

```sh
$ echo "4K bytes" | human2bytes
 4096 bytes

$ echo "4M bytes" | human2bytes
 4194304 bytes

$ echo "4.5M bytes" | human2bytes
 4718592 bytes

$ echo "4.5M bytes" | human2bytes | bytes2human
4.5M bytes

$ echo "4.5K bytes" | human2bytes
 4608 bytes
```

### humansizesort

Performs `human2bytes | natsort | bytes2human`, i.e. natsorts by the
first column (which is expected to represent a size in bytes).

```sh
 ls -laR | grep '^[d-]' | grep -v ' [.][.]\?/' -v | cols ,4 ,5:8 ,8: | last 10
148B  Jul 14 04:39  trim*
1.6K  Jul 14 05:11  trimlines*
317B  Jul 14 01:01  whichapp*
39B   Jul 14 04:20  col.txt
102B  Jul 14 00:00  home/
102B  Jul 14 00:00  Library/
102B  Jul 14 00:00  Preferences/
4.7K  Jul 14 00:00  net.lowndes.windowflow.plist
165B  Jul 14 04:12  sosbin*
3.0K  Jul 14 01:08  sospath*

$ ls -laR | grep '^[d-]' | grep -v ' [.][.]\?/' -v | cols ,4 ,5:8 ,8: | last 10 | humansizesort
39B   Jul 14 04:20  col.txt
102B  Jul 14 00:00  Library/
102B  Jul 14 00:00  Preferences/
102B  Jul 14 00:00  home/
148B  Jul 14 04:39  trim*
165B  Jul 14 04:12  sosbin*
317B  Jul 14 01:01  whichapp*
1.6K  Jul 14 05:11  trimlines*
3.0K  Jul 14 01:08  sospath*
4.7K  Jul 14 00:00  net.lowndes.windowflow.plist

```

### flags

Prints any commandline flags in stdin.

```sh
$ echo "This -v is -f an -h example." | flags
 -v -f -h

```

