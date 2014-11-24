## blscd v0.1.4.2 [GNU GPLv3]

`blscd`(1) is a stupid [ranger](http://ranger.nongnu.org/)-like file browser/navigator (not manager) for the command line using `stty`(1), `tput`(1) and other Unix commands. At the moment, you may merely browse your file system with some basic actions like sorting, searching and opening files. `blscd`(1) is written in `GNU bash`(1) and has mainly been tested with `xterm`(1) on `Debian GNU/Linux`.

![](https://raw.githubusercontent.com/D630/blscd/master/doc/blscd.png)

### Install

* Get the newest version of `blscd`(1) with `$ git clone https://github.com/D630/blscd.git` or
  download its last release on https://github.com/D630/blscd/tags
* Copy the script `blscd` elsewhere into `<PATH>` and make it executable.

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

### Help

```
usage: [source] blscd [-v | --version | -h | --help]

    Key bindings (basics)
      :                     Open the console
      E                     Edit the current file in '<EDITOR>'
                            (fallback: 'vi')
      S                     Fork a shell in the current directory
      ^L                    Redraw the screen
      ^R                    Reload everything
      g?                    Open this help in '<PAGER>'
                            (fallback: 'less')
      q                     Quit

    Key bindings (settings)
      ^H                    Toggle '_blscd_show_hidden'

    Key bindings (moving)
      D                     Move ten lines down
      G     [ END ]         Move to bottom
      J                     Move half page down C-D
      K                     Move half page up C-U
      U                     Move ten lines up
      ^B    [ PAGE-UP ]     Move page up
      ^F    [ PAGE-DOWN ]   Move page down
      d                     Move five lines down
      gg    [ HOME ]        Move to top
      h     [ LEFTARROW ]   Move left
      j     [ DOWNARROW ]   Move down
      k     [ UPARROW ]     Move up
      l     [ RIGHTARROW ]  Move right
      u                     Move five lines up

    Key bindings (jumping)
      gL                    Move to /var/log
      gM                    Move to /mnt
      gd                    Move to /dev
      ge                    Move to /etc
      gh                    Move to <HOME>
      gl                    Move to /usr/lib
      gm                    Move to /media
      go                    Move to /opt
      gr    [ g/ ]          Move to /
      gs                    Move to /srv
      gu                    Move to /usr
      gv                    Move to /var

    Key bindings (searching)
      /                     Search for files in the current directory
                            (console command 'search')
      N                     Go to previous file
      n                     Go to next file. By default, go to newest
                            file; but after 'search' go to next match

    Key bindings (sorting)
      oA                    Sort by access time, oldest first
      oB                    Sort by basename (LC_COLLATE=C.UTF-8),
                            descend
      oC                    Sort by change time, oldest first
      oM                    Sort by modification time, oldest first
      oN                    Sort basenames naturally (LC_COLLATE=$LANG),
                            descend
      oS                    Sort by file size, smallest first
      oT                    Sort by type, descend
      oa                    Sort by access time, newest first
      ob                    Sort by basename (LC_COLLATE=C.UTF-8),
                            ascend
      oc                    Sort by change time, newest first
      om                    Sort by modification time, newest first
      on                    Sort basenames naturally (LC_COLLATE=$LANG),
                            ascend
      or                    Reverse whatever the sorting method is
      os                    Sort by file size, largest first
      ot                    Sort by type, ascend

    File type indicators (browser; via 'find')
      D                     door (Solaris)
      b                     block (buffered) special
      c                     character (unbuffered) special
      d                     directory
      f                     regular file
      l                     symbolic link
      p                     named pipe (FIFO)
      r                     non-link
      s                     socket

    File type indicators (statusbar; via 'ls')
      -                     regular file
      ?                     some other file type
      C                     high performance ('contiguous data') file
      D                     door (Solaris 2.5 and up)
      M                     off-line ('migrated') file (Cray DMF)
      P                     port (Solaris 10 and up)
      b                     block special file
      c                     character special file
      d                     directory
      l                     symbolic link
      n                     network special file (HP-UX)
      p                     FIFO (named pipe)
      s                     socket

    Console commands
      During line editing in the console you may use your configured
      Readline key bindings, just as well the other features of it
      ('read -e' obtains the line in an interactive shell).

      search '<PATTERN>'    Search for files in the current directory,
                            that match the given (case insensitive)
                            regular expression pattern (regextype is
                            'posix-egrep')
```

### Notes

- There is no configuration file at present, but to use different file handlers and some settings (hidden filter, colors in the bars, cursor), have a look at the functions called `__blscd_open_line()` and `__blscd_set_declare()`.
- The coloration in the browser pane works via `ls`(1) and the `<LS_COLORS>` environment variable; you may write your own specific database and source it with `dircolors`(1) into the environment before executing `blscd`(1):
```
eval $(dircolors -b "DATABASE")

```
- In this version file names may not contain nongraphic characters like newlines etc. Try it out.

### To do

A lot, and step-by-step.

### Bugs & Requests

Report it on https://github.com/D630/blscd/issues

See also [info file](../master/doc/INFO.md)

### Credits

`blscd`(1) is a fork and rewrite of [lscd v0.1](https://github.com/hut/lscd/blob/989cb7e045a4e5e879db9af0f7f7c721d8a93acc/lscd) (2014, GNU GPLv3) by Roman Zimbelmann aka. [hut](https://github.com/hut).

### See also

Similar to this project and independent from `lscd` is [deer](https://github.com/vifon/deer) (2014, GNU GPLv3), which is written in `zsh` by Wojciech Siewierski aka. [Vifon](https://github.com/vifon).
