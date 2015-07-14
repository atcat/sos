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

