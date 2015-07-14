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

