# sos

## Scripts

### contains

Exits with code 0 if stdin matches the Python regex specified on the
commandline; else exits with 1.

```sh
$ $(echo "foo" | contains "o") && echo hi
$ $(echo "foo" | contains "g") && echo hi
hi
```

### flags

Prints any commandline flags in stdin.

```sh
$ echo "This -v is -f an -h example." | flags
 -v -f -h
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

### skiplines

`skiplines 2` will skip the first two lines of stdin.

`skiplines 0 3` will skip the last three lines of stdin.

`skiplines 2 3` will skip the first two and last three lines of stdin.

```sh
$ printf " foo\n bar\n baz\n a\n b\n c\n"
 foo
 bar
 baz
 a
 b
 c
$ printf " foo\n bar\n baz\n a\n b\n c\n" | skiplines 2
 baz
 a
 b
 c
$ printf " foo\n bar\n baz\n a\n b\n c\n" | skiplines 0 3
 foo
 bar
 baz
$ printf " foo\n bar\n baz\n a\n b\n c\n" | skiplines 2 3
 baz
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

