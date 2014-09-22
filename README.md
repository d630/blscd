## blscd v0.1.2.3 [GNU GPLv3]

`blscd`(1) is a simple [ranger](http://ranger.nongnu.org/)-like file browser/navigator for the command line. Currently, you may browse your file system and search and open files without many features. `blscd`(1) is written in `GNU bash` and has been tested with `xterm`(1), `urxvt`(1) and the virtual console on `Debian GNU/Linux`.

![](https://raw.githubusercontent.com/D630/blscd/master/doc/blscd.png)

### Install

Explicitly required: `GNU bash`(1) >= 4.0, `file`(1), `grep`(1), `ls`(1), `stty`(1) and `tput`(1)

Optional: `less`(1) and its scripts under `lessopen`(1); `w3m`(1) and its patch `w3m-img`

* Get the newest version of `blscd`(1) with `$ git clone https://github.com/D630/blscd.git` or
  download its last release on https://github.com/D630/blscd/tags
* Copy the script `blscd` elsewhere into `<PATH>` and make it executable.

### Help

```
usage: [source] blscd [-v | --version | -h | --help]

    Key bindings
      ^B    [ PAGE-UP ]     Move page up
      d                     Move five lines down
      D                     Move ten lines down
      E                     Edit the current file in '<EDITOR>' (fallback:
                            'vi')
      ^F    [ PAGE-DOWN ]   Move page down
      gd                    Move to /dev
      ge                    Move to /etc
      G     [ END ]         Move to bottom
      gg    [ HOME ]        Move to top
      gh                    Move to <HOME>
      gl                    Move to /usr/lib
      gL                    Move to /var/log
      gm                    Move to /media
      gM                    Move to /mnt
      go                    Move to /opt
      g?                    Open this help in '<PAGER>' (fallback: 'less')
      gr    [ g/ ]          Move to /
      gs                    Move to /srv
      gu                    Move to /usr
      gv                    Move to /var
      h     [ LEFTARROW ]   Move left
      j     [ DOWNARROW ]   Move down
      J                     Move half page down
      K                     Move half page up
      k     [ UPARROW ]     Move up
      ^L                    Redraw the screen
      l     [ RIGHTARROW ]  Move right
      m                     Go to next match
      n                     Go to previous match
      :                     Open the console
      q                     Quit
      ^R                    Reload everything
      S                     Fork a shell in the current directory
      /                     Search for files in the current directory
                            (like console command 'search')
      SPACE                 Toggle the mark-status of a file
      u                     Move five lines up
      U                     Move ten lines up
      vn                    Unmark all files
      vv                    Toggle the mark-status of all files

    File type indicators
      b                     File is a block device
      c                     File is a character device
      -                     File is a regular file
      @                     File is a symbolic link
      |                     File is a named pipe
      =                     File is a socket
      *                     File is a regular file and is executable

    Console Commands
      During line editing in the console you may use your configured
      Readline key bindings, just as well the other features of it
      ('read -e' obtains the line in an interactive shell).

      search '<PATTERN>'    Search for files in the current directory,
                            that match the given (case insensitive)
                            regular expression pattern (regextype is
                            'posix-egrep')
```

### Notes

- To use different file handlers, have a look at the functions called `__blscd_p_open_file()` and `__blscd_p_declare_set()`. Currently, the last one is also the place, where you need to edit the color configuration.
- In this version file names may not contain apostrophes resp. single quotes (').

### To do

A lot.

### Bugs & Requests

Report it on https://github.com/D630/blscd/issues

### Credits

`blscd`(1) is a fork and rewrite of [lscd v0.1](https://github.com/hut/lscd/blob/989cb7e045a4e5e879db9af0f7f7c721d8a93acc/lscd) (2014, GNU GPLv3) by Roman Zimbelmann aka. [hut](https://github.com/hut).

### See also

Similar to this project and independent from `lscd` is [deer](https://github.com/vifon/deer), which is written in `zsh`.
