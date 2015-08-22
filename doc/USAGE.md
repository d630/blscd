##### INVOCATION

blscd has been written as pseudo-module. In an interactive bash session do:

```sh
source blscd
Blscd Blscd::Main [ -h | --help | -v | --version ]
```

Otherwise put it in a wrapper script like this:

```sh
cat >> "${HOME}/"bin/blscd.sh <<'CODE'
#!/usr/bin/env bash

source blscd
Blscd Blscd::Main "$@"
CODE

chmod 755 "${HOME}/"bin/blscd.sh
```

##### ENVIRONMENT VARIABLES

```
        BLSCD_HIDDEN          Default: 1
        BLSCD_SHOW_COL3       Default: 1
```

##### SHORTCUTS

```
Basics
        E                     Edit the current file in EDITOR
                              (fallback: vi)
        S                     Fork SHELL in the current directory
                              (fallback: bash, LC_COLLATE=C)
        ^L                    Redraw the screen
        ^R                    Reload everything
        g?                    Open this help in PAGER
                              (fallback: less)
        q                     Quit

Settings
        za                    Toggle filtering of dotfiles
        zo                    Toggle drawing of Column 3

Moving
        D                     Move ten lines down
        G     [ END ]         Move to bottom
        J                     Move half page down
        K                     Move half page up
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

Jumping
        g-                    Move to OLDPWD
        gL                    Move to /var/log
        gM                    Move to /mnt
        gd                    Move to /dev
        ge                    Move to /etc
        gh    [ g~ ]          Move to HOME
        gl                    Move to /usr/lib
        gm                    Move to /media
        go                    Move to /opt
        gr    [ g/ ]          Move to /
        gs                    Move to /srv
        gu                    Move to /usr
        gv                    Move to /var
```

##### CONFIGURATION

There is no configuration file at present; you can use some environment variables instead.

- In order to change the default opener and colors see the functions `Blscd::Init` and `Blscd::DrawScreenTbar`.
- Modify keybindings in function `Blscd::GetInputKeyboard`.
- Awk will only be used, if a directory lists 800 or more entries. You may edit this value in function `Blscd::GetBlscdData`.
- blscd is going to exit, if your terminal does not match the allowed height and width. See the head of `Blscd::DrawScreen` for this.
- Filtering of dotfiles works via GLOBIGNORE in `Blscd::GetBlscdData`. You can extend it easily; `man 1 bash` says:

```
        GLOBIGNORE
                A  colon-separated  list of patterns defining the set of
                filenames to be ignored by  pathname  expansion.   If  a
                filename  matched  by  a pathname expansion pattern also
                matches one of the patterns in GLOBIGNORE, it is removed
                from the list of matches.
```

##### TIPS

- Reduce the start up time of blscd by replacing all tput commands in `Blscd::Init` with ANSI escape code for your terminal. In this way, you may avoid a lot of subshells.
- blscd stores directory listings and inode infos in associative arrays just for once; any filesystem event after that will be ignored. If you want to see all current entries in a directory, quit blscd or reload everything via ^R. The Status bar data at the bottom is different: it is associated with the current cursor position and the size of the terminal columns number.
