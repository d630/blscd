### Conventions

- (Nested) shell functions (procedures and functions in the stricter sense) are declared without the reserved word `function`; their names are prefixed with `__blscd_`. The bodies may have every compound command, but the group command is prefered:

```sh
__blscd_one_line () { LIST ; }

__blscd_one_line () [[ $@ ]]

__blscd_many_lines ()
{
    LIST
}

__blscd_many_lines ()
for i
do
    LIST
done
```

- Variables, which are not restricted to local scope in a function, are prefixed with `_blscd_`.

```sh
    _blscd_var_global=
```
- Shell builtins have to be executed with `builtin`; foreign commands with `command`.
- Every variable is to be declared/initiated with the builtin command `declare` like:

```sh
builtin declare string=
builtin declare -g string=
builtin declare -gx string=
builtin declare -i int=
builtin declare -a "iarray=()"
builtin declare -A aarray
```

### Environments

| **Name** | **Fallback** |
| -------- | ------------ |
| `EDITOR` | `vi` |
| `PAGER` | `less` |
| `LANG` | |
| `SHELL` | |
| `LS_COLORS` | |

### Variables

| **Name** | **Type** |**Default** | **Description** |
| -------- | -------- |------------| --------------- |
| `_blscd_action_last` | v | | |
| `_blscd_col_1_list` | ia | | |
| `_blscd_col_1_list_total` | iv | `0` | |
| `_blscd_col_1_view` | ia | | |
| `_blscd_col_1_view_offset` | iv | `1` | |
| `_blscd_col_1_view_total` | iv | `0` | |
| `_blscd_col_2_list` | ia | | |
| `_blscd_col_2_list_total` | iv | `0` | |
| `_blscd_col_2_mtime` | ia | | |
| `_blscd_col_2_search` | ia | | |
| `_blscd_col_2_view` | ia | | |
| `_blscd_col_2_view_offset` | iv | `1` | |
| `_blscd_col_2_view_total` | iv | `0` | |
| `_blscd_col_3_list` | ia | | |
| `_blscd_col_3_list_total` | iv | `0` | |
| `_blscd_col_3_view` | ia | | |
| `_blscd_col_3_view_offset` | iv | `1` | |
| `_blscd_col_3_view_total` | iv | `0` | |
| `_blscd_console_command_name` | v | | |
| `_blscd_data` | aa | | |
| `_blscd_dir_col_0_string` | v | | |
| `_blscd_dir_col_1_string` | v | `<PWD>` | |
| `_blscd_dir_last` | v | | |
| `_blscd_hidden_filter` | v | `^\.|~$'` | |
| `_blscd_hidden_filter_ls` | v | `--ignore=.* --ignore=*~` | |
| `_blscd_hidden_filter_md5sum` | v | | |
| `_blscd_input` | v | | |
| `_blscd_k1` | v | | |
| `_blscd_k2` | v | | |
| `_blscd_k3` | v | | |
| `_blscd_LC_COLLATE_old` | v | `<LC_COLLATE>` | |
| `_blscd_line_last` | v | | |
| `_blscd_opener` | v | `builtin export LESSOPEN='"| /usr/bin/lesspipe %s"';command less -R "$1"` | |
| `_blscd_redraw` | v | `_blscd_redraw` | |
| `_blscd_redraw_number` | iv | `0` | |
| `_blscd_reprint` | v | `_blscd_reprint` | |
| `_blscd_saved_stty` | v | | |
| `_blscd_saved_traps` | v | | |
| `_blscd_screen_lines_browser` | iv | `0` | |
| `_blscd_screen_lines_browser_col_1_cursor` | iv | `0` | |
| `_blscd_screen_lines_browser_col_1_cursor_string` | v | | |
| `_blscd_screen_lines_browser_col_1_visible` | iv | `0` | |
| `_blscd_screen_lines_browser_col_2_cursor` | iv | `0` | |
| `_blscd_screen_lines_browser_col_2_cursor_string` | v | | |
| `_blscd_screen_lines_browser_col_2_visible` | iv | `0` | |
| `_blscd_screen_lines_browser_col_3_cursor` | iv | `0` | |
| `_blscd_screen_lines_browser_col_3_cursor_string` | v | | |
| `_blscd_screen_lines_browser_col_3_visible` | iv | `0` | |
| `_blscd_screen_lines_offset` | iv | `4` | |
| `_blscd_screen_lines_titlebar_string` | v | | |
| `_blscd_search_block` | v | | |
| `_blscd_search_pattern` | v | | |
| `_blscd_show_hidden` | v | | |
| `_blscd_sort_mechanism` | v | `_blscd_sort_mechanism_basename` | |
| `_blscd_sort_reverse` | v | | |
| `_blscd_step` | iv | `6` | |
| `_blscd_tput_alt` | v | | |
| `_blscd_tput_am_off` | v | | |
| `_blscd_tput_am_on` | v | | |
| `_blscd_tput_black_f` | v | | |
| `_blscd_tput_blue_f` | v | | |
| `_blscd_tput_bold` | v | | |
| `_blscd_tput_clear` | v | | |
| `_blscd_tput_cup_1_0` | v | | |
| `_blscd_tput_cup_2_0` | v | | |
| `_blscd_tput_cup_99999_0` | v | | |
| `_blscd_tput_ealt` | v | | |
| `_blscd_tput_eel` | v | | |
| `_blscd_tput_green_b` | v | | |
| `_blscd_tput_green_f` | v | | |
| `_blscd_tput_hide` | v | | |
| `_blscd_tput_home` | v | | |
| `_blscd_tput_red_b` | v | | |
| `_blscd_tput_reset` | v | | |
| `_blscd_tput_show` | v | | |
| `_blscd_tput_white_b` | v | | |
| `_blscd_tput_white_f` | v | | |
| `_blscd_tput_yellow_b` | v | | |
| `_blscd_tput_yellow_f` | v | | |

### Functions

| **Name**  | **Arguments** | **Description** |
| --------- | ------------- | --------------- |
| `__blscd_build_col_list` | `(1|2|3)` | Build `_blscd_col_<INT>_list`; call `__blscd_build_search` |
| `__blscd_build_col_view` | `(1|2|3)` | Build `_blscd_col_<INT>_view`, `_blscd_col_<INT>_view_offset`, `_blscd_col_<INT>_view_total`, `_blscd_screen_lines_browser_col_<INT>_cursor`, `_blscd_screen_lines_browser_col_<INT>_cursor_string`, `_blscd_data='(["view <KEY>"]= ["view offset <KEY>"]= ["view cursor <KEY>"]= )'` |
| `__blscd_build_data` | `<DIR>` ... | Nested; call `__blscd_build_data_do_stat` and `__blscd_build_data_do_<INT>`; build `_blscd_data='(["stat <KEY>"]= ["atime <KEY>"]= ["basename <KEY>"]= ["color <KEY>"]= ["color prae <KEY>"]= ["color post <KEY>"]= ["ctime <KEY>"]= ["index <KEY>"]= ["mtime <KEY>"]= ["size <KEY>"]= ["type <KEY>"]= ["list <KEY>"]= )'` |
| `__blscd_build_mtime` | | Build `_blscd_col_2_mtime` |
| `__blscd_build_search` | | Build `_blscd_col_2_search` |
| `__blscd_draw_screen` | |Determine screen dimension, print screen (titlebar, browser with three columns, statusbar) and set cursor position; call `__blscd_build_col_list`, `__blscd_build_col_view`, `__blscd_draw_screen_lines` |
| `__blscd_draw_screen_check` | | Check, whether the screen needs to be redrawn |
| `__blscd_draw_screen_lines` | `(1|2|3)` | Build `_blscd_screen_lines_titlebar_string`, `screen_lines_statusbar_string`; color `_blscd_screen_lines_browser_col_<INT>_cursor` |
| `__blscd_edit_line` | | Execute `<EDITOR>` and open `_blscd_screen_lines_browser_col_2_cursor_string` |
| `__blscd_help` | | Print usage and help |
| `__blscd_main` | | Initiate `blscd`(1); decide, what to do based on command line arguments and pressed keys |
| `__blscd_move_col` | `<DIR>` | Nested; call `__blscd_move_col_up` and `__blscd_move_col_down`; change diretories |
| `__blscd_move_line` | `(1|2|3)` `<INT>` | Nested; call `__blscd_move_line_do`; move lines in the browser |
| `__blscd_mtime` | `(newest|oldest)` | Call `__blscd_mtime_go_newest` and `__blscd_mtime_go_oldest` and move lines |
| `__blscd_mtime_go_newest` | | Change order in `_blscd_col_2_mtime` |
| `__blscd_mtime_go_oldest` | | Change order in `_blscd_col_2_mtime` |
| `__blscd_open_console` | | Build `_blscd_console_command_name` and `console_command_arguments`; call console commands like `search` |
| `__blscd_open_line` | `<PATH>` | Decide, what to do with `_blscd_screen_lines_browser_col_2_cursor_string` based on the file type |
| `__blscd_open_shell` | | Execute and fork `<SHELL>` in the current directory |
| `__blscd_search` | | Declare `_blscd_search_pattern` and initiate redraw of the screen; then move line to first match |
| `__blscd_search_go_down` | | Move line to next match  |
| `__blscd_search_go_up` | | Move line to previous match |
| `__blscd_set_action_last` | | Build `_blscd_action_last` |
| `__blscd_set_declare` | | Declare/Initiate all global variables and save terminal environment |
| `__blscd_set_delete` | | Unset all global variables and all functions |
| `__blscd_set_environment` | | Go to the alternate screen; then change terminal environment and trap signals |
| `__blscd_set_exit` | | Restore terminal environment and call `__blscd_set_delete` |
| `__blscd_set_hide` | | Set `_blscd_show_hidden` and call `__blscd_set_hide_filter_md5sum` |
| `__blscd_set_hide_filter_md5sum` | | Build `_blscd_hidden_filter_md5sum` |
| `__blscd_set_reload` | | Reset terminal environment and global variables |
| `__blscd_set_resize` | `(1|2|[^12])` | Build `_blscd_redraw` and `_blscd_reprint` |
| `__blscd_set_search_non` | | Delete environment for the console command `search` |
| `__blscd_set_sort` | `(A|a|B|b|C|c|M|m|N|n|S|s|T|t|r)` | Change `_blscd_sort_mechanism` and `_blscd_sort_reverse` |
| `__blscd_version` | | Print version number |
