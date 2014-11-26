#### General

- better performance in __blscd_build_data
- complete INFO.md
- "professionell" error handling and logging
- much more comments in the scipt
- configuration file
- test things in other ttys (urxvt, console)
- notice starting mode of blscd (if sourced or not) and then decide things
- history/chronicle

#### Ranger

- file preview (:get_preview, :update_preview)
- macros (:substitute_macros)
- marking/selecting, visual_mode (:copy, :cut, :paste, :delete, :uncut, :change_mode, :toggle_visual_mode, :mark_files, :select_file)
- most commandline arguments
- searching (:scout (filter, find, mark, unmark, search, search_inc, travel), :grep, :search_file, :search_next)
- setting (:set, :setlocal, :set_filter, :set_option, :set_option_from_string, :set_search_method, :toggle_option, :sort)
- simulate default colorschemes of ranger via dircolors
- simulate console commands:
  * :cd, :enter_dir
  * :console, :open_console, :chain
  * :display_command_help, :display_help, :display_log, :help, :log
  * :dump_commands, :dump_keybindings, :dump_settings
  * :edit, :edit_file
  * :execute_command, :execute_console, :execute_file, :open_with
  * :exit, :quit
  * :move, :move_parent, :history_go
  * :redraw_window, :reload_cwd, :reset
- new keybindings, aliases and settings

##### Special

- Flags
- Taskview (:tmap; :tunmap; :copytmap; :taskview_close; :taskview_move; :taskview_open; :pause_tasks)
- Work with Buffer (:load_copy_buffer; :save_copy_buffer)
- Console
  * :abort
  * :alias, :AliasCommand
  * :copymap
  * :map
  * :shell
  * :unmap
  * :terminal
- "Plugins"
  * :chmod
  * :mkdir
  * :paste_hardlink
  * :paste_hardlinked_subtree
  * :paste_symlink
  * :relink
  * :rename
  * :touch

#### Think about

- rifle
- scope.sh
- Console
  * :bulkrename
  * :draw_possible_programs
  * :traverse

### No account into

- Bookmarks (:enter_bookmark; :hide_bookmarks; :set_bookmark; :unset_bookmark; :draw_bookmarks)
- Pager (:pmap; :punmap; :copypmap; :pager_close; :pager_move; :display_file)
- Python (:eval)
- Tabs (:tab_close; :tab_move; :tab_new; :tab_open; :tab_restore)
- Tags (:mark_tag; :unmark_tag; :setintag; :tag_add; :tag_remove; :tag_toggle)
- Console
  * :cmap
  * :copycmap
  * :cunmap
  * :diff
  * :get_cumulative_size
  * :hide_console_info
  * :mark_in_direction
  * :notify
  * :quit!
  * :scroll
  * :source
  * :stage
