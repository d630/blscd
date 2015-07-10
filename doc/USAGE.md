"blscd" "1" "Fri Jul 10 16:36:08 UTC 2015" "USAGE"

##### HELP

```
Usage
        [ . ] blscd [ -h | --help | -v | --version ]

Key bindings (basics)
        E                     Edit the current file in EDITOR
                              (fallback: vi)
        S                     Fork SHELL in the current directory
                              (fallback: bash, LC_COLLATE=C)
        ^L                    Redraw the screen
        ^R                    Reload everything
        g?                    Open this help in PAGER
                              (fallback: less)
        q                     Quit

Key bindings (settings)
        za                    Toggle filtering of dotfiles
        zo                    Toggle drawing of Column 3

Key bindings (moving)
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

Key bindings (jumping)
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

There is no configuration file at present.

To use another opener and different colors see the functions `Blscd::Init` and `Blscd::DrawScreenTbar`.

For other keybindings see function `Blscd::GetInputKeyboard`.

Awk will only be used, if a directory contains 800 or more files. You may modify this value in function `Blscd::GetBlscdData`.

blscd is going to exit, if your terminal does not match the allowed height and width. See the head of `Blscd::DrawScreen` for this.

Filtering of dotfiles works via GLOBIGNORE in `Blscd::GetBlscdData`. You can extend it easily; `man 1 bash` says:

```
       GLOBIGNORE
              A  colon-separated  list of patterns defining the set of
              filenames to be ignored by  pathname  expansion.   If  a
              filename  matched  by  a pathname expansion pattern also
              matches one of the patterns in GLOBIGNORE, it is removed
              from the list of matches.
```

##### TIPS

You can reduce the start up time of blscd by replacing the tput commands in `Blscd::Init` with ASCII codes for your terminal. In this way, you may avoid a lot of subshells.

blscd stores directory stats in associative arrays just for once; any filesystem events after that will be ignored. If you want to see all current files in a directory, quit blscd or reload everything via ^R.
