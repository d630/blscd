"blscd" "1" "Fri Jul 10 12:33:43 UTC 2015" "USAGE"

##### HELP

```
Usage
        [ . ] blscd [ -h | --help | -v | --version ]

Key bindings (basics)
        E                     Edit the current file in EDITOR
                              (fallback: vi)
        S                     Fork SHELL' in the current directory
                              (fallback: bash, LC_COLLATE=C)
        ^L                    Redraw the screen
        ^R                    Reload everything
        g?                    Open this help in PAGER
                              (fallback: less)
        q                     Quit

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
        gL                    Move to /var/log
        gM                    Move to /mnt
        gd                    Move to /dev
        ge                    Move to /etc
        gh                    Move to HOME
        gl                    Move to /usr/lib
        gm                    Move to /media
        go                    Move to /opt
        gr    [ g/ ]          Move to /
        gs                    Move to /srv
        gu                    Move to /usr
        gv                    Move to /var
```

##### CONFIGURATION

There is no configuration file at present. To use another opener and different colors see the functions `Blscd::Init` and `Blscd::DrawScreenTbar`.

##### TIP

You can reduce the start up time of blscd by replacing the tput commands in `Blscd::Init` with ASCII codes for your terminal. In this way, you may avoid a lot of subshells.
