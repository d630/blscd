## blscd v0.1.1.11 [GNU GPLv3]

`blscd`(1) is a simple [ranger](http://ranger.nongnu.org/)-like file browser/navigator for the command line. Currently, you may browse your file system and search and open files without many features. `blscd`(1) is written in `GNU bash` and has been tested with `xterm`, `urxvt` and the virtual console on `Debian GNU/Linux`.

![](https://raw.githubusercontent.com/D630/blscd/master/doc/blscd.png)

### Install

Explicitly required: `GNU bash >= 4.0`, `file`, `grep`, `ls`, `stty` and `tput`

Optional: `less` and its scripts under `lessopen`; `w3m` and its patch `w3m-img`

* Get `blscd`(1) with `$ git clone https://github.com/D630/blscd.git` or
  download it on https://github.com/D630/blscd/tags
* Copy the script `blscd` elsewhere into `<PATH>` and make it executable.

### Usage

```
usage: [source] blscd [-v | --version | -h | --help]

    Key bindings
      ^B    [ PAGE-UP ]     Move page up
      d                     Move five lines down
      D                     Move ten lines down
      E                     Edit the current file in '<EDITOR>' (fallback:
                            'nano')
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
      q                     Quit
      ^R                    Reload everything
      S                     Fork a shell in the current directory
      /                     Search for files in the current directory[1]
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

      [1] During line editing in the search prompt you may use your
          configured Readline key bindings, just as well the other
          features of it; 'read -e' obtains the line in an interactive
          shell. The tool is 'grep', and the regextype is 'posix-egrep'.
```

### Notes

To use different file handlers, have a look at the functions called `__blscd_p_open_file()` and `__blscd_p_declare_set()`. Currently, the last one is also the place, where you need to edit the color configuration.

### TODO

A lot.

### Bugs & Requests

Report it on https://github.com/D630/blscd/issues

### Credits

`blscd`(1) is a fork and rewrite of `lscd v0.1` [2014, GNU GPLv3] by [Roman Zimbelmann](https://github.com/hut/lscd) aka. `hut`.

### See also

Similar to this project is [deer](https://github.com/vifon/deer), which is written in `zsh`.
