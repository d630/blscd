## blscd v0.1.0.0 [GNU GPLv3]

`blscd`(1) is a simple [ranger](http://ranger.nongnu.org/) like file browser/navigator for the command line. Currently, you may browse your file system and search and open files without many features. `blscd`(1) is written in `GNU bash` and has been tested with `xterm`, `urxvt` and the virtual console on `Debian GNU/Linux`.

![](https://raw.githubusercontent.com/D630/blscd/master/doc/blscd.png)

### Install

Explicitly required: `GNU bash >= 4.0`, `file`, `find`, `grep`, `ls`, `sort`, `stty` and `tput`

Optional: `less` and its scripts under `lessopen`; `w3m` and its patch `w3m-img`

* Get `blscd`(1) with `$ git clone https://github.com/D630/blscd.git` or
  download it on https://github.com/D630/blscd/tags
* Copy the script `blscd` elsewhere into `<PATH>` and make it executable.

### Usage

```
usage: [source] blscd  [-v | --version | -h | --help]

    Key bindings
      ^B    [ PAGE-UP ]     Move half page up
      d                     Move five lines down
      D                     Move ten lines down
      ^F    [ PAGE-DOWN ]   Move half page down
      gd                    Move to
      ge                    Move to /etc
      G     [ END ]         Move to bottom
      gg    [ HOME ]        Move to top
      gh                    Move to <HOME>
      gl                    Move to /usr/lib
      gL                    Move to /var/log
      gm                    Move to /media
      gM                    Move to /mnt
      go                    Move to /opt
      g?                    Open this help in '<PAGER>'
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
      q                     Quit
      ^R                    Reload everything
      /                     Search for files in the current directory*
      SPACE                 Mark a file
      u                     Move five lines up
      U                     Move ten lines up
      vn                    Unmark all files
      vv                    Toggle the mark-status of all files

      * During line editing in the search prompt you may use your
        configured Readline key bindings, just as well the other features
        of it; 'read -e' obtains the line in an interactive shell. The
        regextype is 'posix-egrep', and the tool 'grep'.

```

### Notes

To use different file handlers, have a look at the functions called `__blscd_open_file()` and `__blscd_declare_set()`. Currently, the last one is also the place, where you need to edit the color configuration.

### TODO

A lot.

### Bugs & Requests

Report it on https://github.com/D630/blscd/issues

### Credits

`blscd`(1) is a fork and rewrite of `lscd v0.1` [2014, GNU GPLv3] by `hut` aka. [Roman Zimbelmann](https://github.com/hut/lscd)

### See also

Similar to this project is [deer](https://github.com/vifon/deer), which is written in `zsh`.
