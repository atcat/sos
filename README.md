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

