### Install

* Get the newest version of `blscd`(1) with `$ git clone https://github.com/D630/blscd.git` or
  download its last release on https://github.com/D630/blscd/tags
* If you like, reduce the code with:
```sh
$ cd ./blscd
$ chmod 755 blscd.sh
$ blscd.sh --dump
$ chmod 755 blscd
```
* Copy one of the executables `blscd.sh` and `blscd` elsewhere into `<PATH>`

Explicitly required:
- `GNU bash`(1) >= 4.0
- `file`(1)
- `find`(1)
- `grep`(1)
- `ls`(1)
- `md5sum`(1)
- `numfmt`(1)
- `paste`(1)
- `sort`(1)
- `stty`(1)
- `tput`(1)
- `tr`(1)

Optional:
- `vi`(1)
- `less`(1) and its scripts under `lessopen`(1)
- `w3m`(1) and its patch `w3m-img`
