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

