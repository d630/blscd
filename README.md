"blscd" "1" "Fri Jul 10 13:43:10 UTC 2015" "0.2.0" "README"

##### README

[blscd](https://github.com/D630/blscd) is a stupid [ranger](http://ranger.nongnu.org/)-like file browser/navigator (not manager) for the command line using `stty`(1), `tput`(1) and other Unix utilities.

![](https://raw.githubusercontent.com/D630/blscd/master/doc/blscd.png)

(XTerm, Terminus 12, Zenburn)

##### BUGS & REQUESTS

Get in touch with blscd by reading the [USAGE](../doc/USAGE.md) text file. Please feel free to open an issue or put in a pull request on https://github.com/D630/blscd

##### GIT

To download the very latest source code:

```
git clone https://github.com/D630/blscd
```

If you want to use the latest tagged version, do also something like this:

```
cd ./blscd
git checkout $(git describe --abbrev=0 --tags)
```

##### NOTICE

blscd has been written in [GNU bash](http://www.gnu.org/software/bash/) on [Debian GNU/Linux 9 (stretch/sid)](https://www.debian.org) with these programs/packages:

- GNU Awk 4.1.1, API: 1.1 (GNU MPFR 3.1.3, GNU MP 6.0.0)
- GNU bash 4.3.33(1)-release
- GNU coreutils 8.23: ls, md5sum, stat, stty
- ncurses 5.9.20150516: tput

And has been tested in these terminal emulators:

- XTerm(318)
- rxvt-unicode (urxvt) v9.21
- st 0.5

For opening and editing files in blscd, I used:

- Vi IMproved 7.4 (Included patches: 1-712)
- less 458 (GNU regular expressions)

blscd is not portable; it does not work in [ksh](http://www.kornshell.com/), [mksh](https://www.mirbsd.org/mksh.htm) or [zsh](http://www.zsh.org/). Your bash version needs to handle associative arrays and namerefs via typeset/declare.

The usage of stat is not BSD-like (`grep -c stat blscd.sh` := 3). Please open and issue with the correct invocation for your system.

##### CREDITS

blscd is a fork and rewrite of [lscd v0.1](https://github.com/hut/lscd/blob/989cb7e045a4e5e879db9af0f7f7c721d8a93acc/lscd) by Roman Zimbelmann aka. [hut](https://github.com/hut).

##### SEE ALSO

Similar to this project and independent from lscd is [deer](https://github.com/vifon/deer), which is written in `zsh`(1) by Wojciech Siewierski aka. [Vifon](https://github.com/vifon).

##### LICENCE

[Copyrights](../master/doc/COPYRIGHT)

[GNU GPLv3](../master/doc/LICENCE)
