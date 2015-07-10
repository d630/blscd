#!/usr/bin/env bash

# blscd
# Copyright (C) 2014f. D630, GNU GPLv3
# <https://github.com/D630/blscd>

# Fork and rewrite in GNU bash of lscd v0.1 [2014, GNU GPLv3] by Roman
# Zimbelmann aka. hut, <https://github.com/hut/lscd>

# -- DEBUGGING.

#printf '%s (%s)\n' "$BASH_VERSION" "${BASH_VERSINFO[5]}" && exit 0
#set -o errexit
#set -o errtrace
#set -o noexec
#set -o nounset
#set -o pipefail
#set -o verbose
#set -o xtrace
#trap '(read -p "[$BASH_SOURCE:$LINENO] $BASH_COMMAND?")' DEBUG
#exec 2>> ~/blscd.sh.log
#typeset vars_base=$(set -o posix ; set)
#fgrep -v -e "$vars_base" < <(set -o posix ; set) |
#egrep -v -e "^BASH_REMATCH=" \
#         -e "^OPTIND=" \
#         -e "^REPLY=" \
#         -e "^BASH_LINENO=" \
#         -e "^BASH_SOURCE=" \
#         -e "^FUNCNAME=" |
#less

Blscd ()
{
        # -- FUNCTIONS.

        function Blscd__DrawScreen
        {
                builtin typeset -i \
                        i= \
                        c1_w= \
                        c2_w= \
                        c3_w= \
                        dim_cols= \
                        dim_lines=;

                Blscd__SetScreen

                if
                        ((
                                dim_cols < 40 - ${#USER} - 1 - ${#HOSTNAME} - 1 ||
                                dim_lines < ${I[ofs]]} + ${I[step]]} ||
                                dim_lines < 3
                        ))
                then
                        Blscd__Exit
                        builtin printf '%s\n' "Error: Bad dimension: ${dim_cols},${dim_lines}" 1>&2
                        builtin return 1
                fi

                if
                        (( ${I[reprint]} > 0 ))
                then
                        builtin printf "${S[tput_clear]}"

                        Blscd__SetWd

                        if
                                [[ ${S[cwd_str]} == / ]]
                        then
                                S[pwd_di]=00
                                I[c1_total]=0
                        elif
                                [[ -n ${D[${S[pwd_str]},${I[hidden]},di]} ]]
                        then
                                S[pwd_di]=${D[${S[pwd_str]},${I[hidden]},di]}
                                I[c1_total]=${D[${S[pwd_di]},${I[hidden]},cnt]}
                        else
                                Blscd__GetDi S[pwd_di] "${S[pwd_str]}"
                                FILE_INODE=${S[pwd_di]} \
                                FILE_NAME=${S[pwd_str]} \
                                        Blscd__GetBlscdData
                                I[c1_total]=${D[${S[pwd_di]},${I[hidden]},cnt]}
                        fi

                        if
                                [[ -n ${D[${S[cwd_str]},${I[hidden]},di]} ]]
                        then
                                S[cwd_di]=${D[${S[cwd_str]},${I[hidden]},di]}
                        else
                                Blscd__GetDi S[cwd_di] "${S[cwd_str]}"
                                FILE_INODE=${S[cwd_di]} \
                                FILE_NAME=${S[cwd_str]} \
                                        Blscd__GetBlscdData
                        fi

                        ((
                                I[c1_vis] =
                                ${I[c1_total]} > ${I[bsr_h]}
                                ? ${I[bsr_h]}
                                : ${I[c1_total]}
                        ))
                        Blscd__MoveLine 1 "${D[${S[cwd_di]},${I[hidden]},idx]}"

                        I[c1_csr]=${D[${S[pwd_di]}:${I[bsr_h]},csr]:-${I[c1_csr]}}
                        I[c2_csr]=${D[${S[cwd_di]}:${I[bsr_h]},csr]:-${I[c2_csr]}}
                        I[c1_ofs]=${D[${S[pwd_di]}:${I[bsr_h]},ofs]:-${I[c1_ofs]}}
                        I[c2_ofs]=${D[${S[cwd_di]}:${I[bsr_h]},ofs]:-${I[c2_ofs]}}
                else
                        # Delete obsolete lines in column 3.
                        if
                                (( ${I[c3_total]} <= 15 ))
                        then
                                ((
                                        i =
                                        ${I[c3_total]} < ${I[bsr_h]}
                                        ? ${I[c3_total]}
                                        : ${I[bsr_h]}
                                ))
                                for (( i=$i ; i > 1 ; --i ))
                                do
                                        builtin printf "\033[$((i + 1));$((c1_w + c2_w + 3))H${S[tput_eel]}"
                                done
                        elif
                                ((
                                        ${I[c3_total]} < ${I[bsr_h]} &&
                                        ${I[c1_vis]:-0} > 5
                                ))
                        then
                                builtin printf "${S[tput_cup_2_0]}"
                                for (( i=${I[c3_total]} ; i < ${I[bsr_h]} ; ++i ))
                                do
                                        builtin printf "%-${c1_w}.${c1_w}s\n" ""
                                done
                        fi
                fi

                I[c2_total]=${D[${S[cwd_di]},${I[hidden]},cnt]}
                S[file_di]=${D[${S[cwd_di]},${I[hidden]},$((${I[c2_ofs]} + ${I[c2_csr]} - 1))]}
                S[file_str]=${S[cwd_str]}/${D[${S[file_di]},str]}

                if
                        [[ -n ${D[${S[file_str]}]} ]]
                then
                        S[file_di]=${D[${S[file_str]}]}
                else
                        FILE_INODE=${S[file_di]} \
                        FILE_NAME=${S[file_str]} \
                                Blscd__GetBlscdData
                fi

                I[c3_ofs]=${D[${S[file_di]}:${I[bsr_h]},ofs]:-${I[c3_ofs]}}
                I[c3_csr]=${D[${S[file_di]}:${I[bsr_h]},csr]:-${I[c3_csr]}}

                I[c3_total]=${D[${S[file_di]},${I[hidden]},cnt]}
                S[preview_di]=${D[${S[file_di]},${I[hidden]},$((${I[c3_ofs]} + ${I[c3_csr]} - 1))]}
                S[preview_str]=${S[file_str]}/${D[${S[preview_di]},str]}

                D[${S[pwd_di]}:${I[bsr_h]},csr]=${I[c1_csr]}
                D[${S[pwd_di]}:${I[bsr_h]},ofs]=${I[c1_ofs]}
                D[${S[cwd_di]}:${I[bsr_h]},csr]=${I[c2_csr]}
                D[${S[cwd_di]}:${I[bsr_h]},ofs]=${I[c2_ofs]}
                D[${S[file_di]}:${I[bsr_h]},csr]=${I[c3_csr]}
                D[${S[file_di]}:${I[bsr_h]},ofs]=${I[c3_ofs]}

                ((
                        I[c2_vis] =
                        ${I[c2_total]} > ${I[bsr_h]}
                        ? ${I[bsr_h]}
                        : ${I[c2_total]}
                ))

                ((
                        I[c3_vis] =
                        ${I[c3_total]} > ${I[bsr_h]}
                        ? ${I[bsr_h]}
                        : ${I[c3_total]}
                ))

                if
                        [[
                                ! -d ${S[file_str]} ||
                                -z ${S[file_str]} ||
                                ${I[c2_total]} -eq 0
                        ]]
                then
                        ((
                                c2_w *= 2,
                                c3_w = 0
                        ))
                fi

                Blscd__DrawScreenTbar
                Blscd__DrawScreenBsr
                Blscd__DrawScreenSbar

                builtin printf "${S[tput_reset]}\033[$((${I[c2_csr]} + 2));$((c1_w + 2))H"
        }

        function Blscd__DrawScreenBsr
        {
                builtin typeset \
                        i= \
                        c1_color= \
                        c2_color= \
                        c3_color= ;

                builtin printf '%s' "${S[tput_cup_1_0]}"

                for (( i=0 ; i < ${I[bsr_h]} ; ++i ))
                do
                        c1_color=
                        c2_color=
                        c3_color=
                        if
                                (( i == ${I[c1_csr]} ))
                        then
                                if
                                        (( ${I[c1_total]} == 0 ))
                                then
                                        c1_color=${S[c1_err,csr,color]}
                                else
                                        c1_color=${S[c1,csr,color]}
                                fi
                        fi
                        if
                                (( i == ${I[c2_csr]} ))
                        then
                                if
                                        (( ${I[c2_total]} == 0 ))
                                then
                                        c2_color=${S[c2_err,csr,color]}
                                else
                                        c2_color=${S[c2,csr,color]}
                                fi
                        fi
                        if
                                (( i == ${I[c3_csr]} ))
                        then
                                if
                                        (( ${I[c3_total]} == 0 ))
                                then
                                        c3_color=${S[c3_err,csr,color]}
                                else
                                        c3_color=${S[c3,csr,color]}
                                fi
                        fi
                        builtin printf "${S[${D[${D[${S[pwd_di]},${I[hidden]},$((${I[c1_ofs]} + i - 1))]},type]},color]}${c1_color}%-${c1_w}.${c1_w}s${S[tput_reset]} " " ${D[${D[${S[pwd_di]},${I[hidden]},$((${I[c1_ofs]} + i - 1))]},str]//$'\n'/?} "
                        builtin printf "${S[${D[${D[${S[cwd_di]},${I[hidden]},$((${I[c2_ofs]} + i - 1))]},type]},color]}${c2_color}%-${c2_w}.${c2_w}s${S[tput_reset]} " " ${D[${D[${S[cwd_di]},${I[hidden]},$((${I[c2_ofs]} + i - 1))]},str]//$'\n'/?} "
                        builtin printf "${S[${D[${D[${S[file_di]},${I[hidden]},$((${I[c3_ofs]} + i - 1))]},type]},color]}${c3_color}%-${c3_w}.${c3_w}s${S[tput_reset]}\n" " ${D[${D[${S[file_di]},${I[hidden]},$((${I[c3_ofs]} + i - 1))]},str]//$'\n'/?} "
                done
        }

        function Blscd__DrawScreenSbar
        {
                [[ -n ${D[${S[file_di]}:${I[bsr_h]},sbar]} ]] || {
                        builtin typeset \
                                sbar0=. \
                                sbar_str=. \
                                sbar1=. \
                                sbar2=. \
                                sbar3=. \
                                sbar4=. \
                                sbar5=.;

                        (( ${I[c2_total]} == 0 )) || {
                                sbar0=$(command ls -lAdqh "${S[file_str]//\/\//\/}")

                                if
                                        [[ ${sbar0:0:1} == l ]]
                                then
                                        builtin set -- $sbar0
                                        sbar0="${sbar0%% /*} -> ${@:$#}"
                                        builtin set -- $sbar0
                                else
                                        sbar0=${sbar0%% /*}
                                        builtin set -- $sbar0
                                fi
                                builtin read -r sbar1 sbar2 sbar3 <<IN
$((${I[c2_ofs]} + ${I[c2_csr]})) \
${I[c2_total]} \
$((100 * (${I[c2_ofs]} + ${I[c2_csr]}) / ${I[c2_total]}))
IN
                        }

                        if
                                (( ${I[c2_total]} <= ${I[bsr_h]} ))
                        then
                                sbar4=All
                        elif
                                ((
                                        ${I[c2_total]} > ${I[bsr_h]} &&
                                        ${I[c2_csr]} + ${I[c2_ofs]} <= ${I[c2_vis]}
                                ))
                        then
                                sbar4=Top
                        elif
                                ((
                                        ${I[c2_total]} > ${I[bsr_h]} &&
                                        ${I[c2_csr]} + ${I[c2_ofs]} >= ${I[c2_total]} - ${I[bsr_h]} + 1
                                ))
                        then
                                sbar4=Bot
                        else
                                sbar4=Mid
                        fi

                        if
                                [[ -d ${S[file_str]} ]]
                        then
                                sbar5=${I[c3_total]}
                        else
                                sbar5=-
                        fi

                        builtin printf -v sbar_str "%s %s  %*s/%s  %d%% %s  %s" "$1" "${*:2}" "$((dim_cols - ${#sbar0} - 7 - ${#sbar1} - ${#sbar2} - ${#sbar3} - ${#sbar4} - ${#sbar5}))" "$sbar1" "$sbar2" "$sbar3" "$sbar4" "$sbar5"

                        (( ${#sbar_str} > dim_cols )) && sbar_str=${sbar_str:0:dim_cols}

                        builtin printf -v sbar_str "${S[sbar,color]}\033[$((${I[bsr_h]} + 2));0H${S[tput_eel]}%s${S[tput_reset]} %s" "$1" "${sbar_str#* }"

                        D[${S[file_di]}:${I[bsr_h]},sbar]=$sbar_str
                }

                builtin printf '%s' "${D[${S[file_di]}:${I[bsr_h]},sbar]}"
        }

        function Blscd__DrawScreenTbar
        {
                [[ -n ${D[${S[file_di]}:${I[bsr_h]},tbar]} ]] || {
                        builtin typeset tbar_str=

                        COLUMNS=$dim_cols \
                        SPATH_MARK=" ... " \
                        SPATH_LENGTH=$((40 - ${#USER} - 1 - ${#HOSTNAME} - 1)) \
                                __spath_do "tbar_str" "${S[file_str]//$'\n'/?}"

                        tbar_str=${S[tput_blue_f]}${S[tput_bold]}${USER}@${HOSTNAME}:${S[tput_green_f]}${tbar_str%/*}/${S[tput_white_f]}${tbar_str##*/}${S[tput_reset]}
                        tbar_str=${tbar_str//\/\//\/}
                        #tbar_str=${tbar_str/${HOME}/"~"}

                        D[${S[file_di]}:${I[bsr_h]},tbar]=$tbar_str
                }

                builtin printf '%s\n' "${S[tput_home]}${S[tput_eel]}${D[${S[file_di]}:${I[bsr_h]},tbar]//\/\//\/}"
        }

        function Blscd__EditFile
        {
            Blscd__SetAction
            command "${EDITOR:-vi}" "${S[file_str]}"
        }

        function Blscd__Exit
        {
                command stty ${S[saved_stty]}
                builtin trap - SIGWINCH SIGINT SIGALRM
                builtin eval "${S[saved_traps]}"
                builtin printf "${S[tput_clear]}${S[tput_ealt]}${S[tput_show]}${S[tput_am_on]}"
                builtin typeset -xg LC_COLLATE=${S[saved_LC_COLLATE]}
                builtin unset -v \
                        BlscdData \
                        BlscdSettingsInt \
                        BlscdSettingsStr \
                        D \
                        I \
                        S;
        }

        function Blscd__GetArgs
        case $1 in
        -h|--help)
                Blscd__PrintHelp
        ;;
        -v|--version)
                Blscd__PrintVersion
        ;;
        *)
                builtin return 1
        ;;
        esac

        function Blscd__GetBlscdData
        {
                Blscd__GetBlscdDataByAwk()
                {
                        command awk '
                                BEGIN {
                                        idx = 0;
                                        FS = "|";
                                        RS = "\0"
                                }

                                function Blscd__getBasename(str) {
                                        sub(/.*\//, "", str);
                                        return str
                                }

                                {
                                        printf("D[%s,%d,%d]=%s;D[%s,type]=%c;D[%s,%d,idx]=%d;D[%s,str]='\''%s'\'';", "'$FILE_INODE'", "'${I[hidden]}'", idx, $2, $2, substr($1,0,1), $2, "'${I[hidden]}'", idx, $2, Blscd__getBasename($3));
                                        idx += 1
                                }

                                END {
                                        printf("D['$FILE_NAME','${I[hidden]}',di]=%s;D[%s,'${I[hidden]}',cnt]=%d", "'$FILE_INODE'", "'$FILE_INODE'", idx)
                                }
                        ' 2>>/tmp/blscd.log
                }

                Blscd__GetBlscdDataByBash()
                {
                        builtin typeset -i idx=
                        builtin typeset \
                                di \
                                n \
                                t;

                        while
                                IFS='|' builtin read -r -d '' t di n
                        do
                                D[${FILE_INODE},${I[hidden]},${idx}]=$di
                                D[${di},type]=${t:0:1}
                                D[${di},${I[hidden]},idx]=$idx
                                D[${di},str]=${n##*/}
                                (( idx++ ))
                        done < <(
                                command stat --printf="%A|%d:%i|%n\0" "$FILE_NAME"/* 2>>/tmp/blscd.log
                        )

                        D[${FILE_NAME},${I[hidden]},di]=$FILE_INODE
                        D[${FILE_INODE},${I[hidden]},cnt]=$idx
                }

                if
                        [[
                                -z ${D[${FILE_INODE},${I[hidden]},cnt]} &&
                                -d $FILE_NAME
                        ]]
                then
                        builtin shopt -s dotglob
                        (( ${I[hidden]} == 0 )) && GLOBIGNORE="${FILE_NAME}/".*
                        builtin set -- *
                        if
                                (( $# > 799 ))
                        then
                                builtin source <(
                                        2>>/tmp/blscd.log \
                                        command stat \
                                                --printf="%A|%d:%i|%n\0" "$FILE_NAME"/* \
                                        | Blscd__GetBlscdDataByAwk
                                )
                        else
                                Blscd__GetBlscdDataByBash
                        fi
                        builtin unset -v GLOBIGNORE
                        builtin shopt -u dotglob
                fi
        }

        function Blscd__GetDi
        {
                builtin eval "${1}=\$(command stat --format="%d:%i" "$2" 2>>/tmp/blscd.log)"
        }

        function Blscd__GetInputKeyboard
        {
                builtin typeset \
                        input \
                        k1 \
                        k2 \
                        k3;

                builtin read -s -n 1 input
                builtin read -s -N 1 -t 0.0001 k1
                builtin read -s -N 1 -t 0.0001 k2
                builtin read -s -N 1 -t 0.0001 k3

                S[input]=${input}${k1}${k2}${k3}

                case ${S[input]} in
                j|$'\e[B')
                        Blscd__MoveLine 2 1
                ;;
                k|$'\e[A')
                        Blscd__MoveLine 2 -1
                ;;
                h|$'\e[D')
                        Blscd__MoveCol ..
                ;;
                l|$'\e[C')
                        Blscd__OpenFile "${S[file_str]}"
                        builtin printf "${S[tput_alt]}"
                        Blscd__SetResize 2
                ;;
                $'\x06'|$'\e[6~') # Ctrl+F | <PAGE-DOWN>
                        Blscd__MoveLine 2 "${I[bsr_h]}"
                ;;
                $'\x02'|$'\e[5~') # Ctrl+B | <PAGE-UP>
                        Blscd__MoveLine 2 "-${I[bsr_h]}"
                ;;
                $'\e[H'|$'\eOH') # <HOME>
                        Blscd__MoveLine 2 -9999999999
                ;;
                G|$'\e[F'|$'\eOF') # <END>
                        Blscd__MoveLine 2 9999999999
                ;;
                J)
                        Blscd__MoveLine 2 "$((${I[bsr_h]} / 2))"
                ;;
                K)
                        Blscd__MoveLine 2 "-$((${I[bsr_h]} / 2))"
                ;;
                d)
                        Blscd__MoveLine 2 5
                ;;
                D)
                        Blscd__MoveLine 2 10
                ;;
                u)
                        Blscd__MoveLine 2 -5
                ;;
                U)
                        Blscd__MoveLine 2 -10
                ;;
                g)
                        builtin read -n 1 input
                        case $input in
                        g)
                                Blscd__MoveLine 2 -9999999999
                        ;;
                        h|\~)
                                Blscd__MoveCol ~
                        ;;
                        e)
                                Blscd__MoveCol "/etc"
                        ;;
                        u)
                                Blscd__MoveCol "/usr"
                        ;;
                        d)
                                Blscd__MoveCol "/dev"
                        ;;
                        l)
                                Blscd__MoveCol "/usr/lib"
                        ;;
                        L)
                                Blscd__MoveCol "/var/log"
                        ;;
                        o)
                                Blscd__MoveCol "/opt"
                        ;;
                        v)
                                Blscd__MoveCol "/var"
                        ;;
                        m)
                                Blscd__MoveCol "/media"
                        ;;
                        M)
                                Blscd__MoveCol "/mnt"
                        ;;
                        s)
                                Blscd__MoveCol "/srv"
                        ;;
                        r|/)
                                Blscd__MoveCol /
                        ;;
                        \?)
                                Blscd__PrintHelp | command "${PAGER:-less}"
                                builtin printf "${S[tput_alt]}"
                                Blscd__SetAction
                                Blscd__SetResize 2
                        ;;
                        -)
                                Blscd__MoveCol "$OLDPWD"
                        ;;
                        esac
                ;;
                #~ \[)
                        #~ Blscd__MoveParent +1
                #~ ;;
                #~ \])
                        #~ Blscd__MoveParent -1
                #~ ;;
                $'\x12') # CTRl+R
                         Blscd__Reload
                ;;
                $'\x0c') # CTRL+L
                        Blscd__SetResize 2
                        builtin printf "${S[tput_cup_99999_0]}${S[tput_eel]}"
                ;;
                $'\x08') # CTRL+H
                        Blscd__ToggleHidden
                ;;
                E)
                        Blscd__EditFile
                        builtin printf "${S[tput_alt]}"
                        Blscd__SetResize 2
                ;;
                S)
                        builtin printf "${S[tput_show]}${S[tput_am_on]}"
                        Blscd__OpenShell
                        builtin printf "${S[tput_alt]}"
                        Blscd__SetResize 2
                ;;
                q)
                        Blscd__Exit
                        builtin break
                ;;
                esac
        }

        function Blscd__Init
        {
                {
                    builtin typeset i="$(</dev/fd/0)"
                }  <<-'INIT'
builtin typeset -gA BlscdData

builtin typeset -gA "BlscdSettingsStr=(
        [action_last]=
        [console_command_name]=
        [cwd_di]=
        [cwd_str]=$PWD
        [file_di]=
        [file_str]=
        [opener]='command less "\$1"'
        [preview_di]=
        [preview_str]=
        [pwd_di]=
        [pwd_str]=
        [saved_LC_COLLATE]=$LC_COLLATE
        [saved_stty]='$(command stty -g)'
        [saved_traps]='$(builtin trap)'
        [tput_alt]='$(command tput smcup || command tput ti)'
        [tput_am_off]='$(command tput rmam)'
        [tput_am_on]='$(command tput am)'
        [tput_bold]='$(command tput bold || command tput md)'
        [tput_clear]='$(command tput clear)'
        [tput_cup_1_0]='$(command tput cup 1 0)'
        [tput_cup_2_0]='$(command tput cup 2 0)'
        [tput_cup_99999_0]='$(command tput cup 99999 0)'
        [tput_ealt]='$(command tput rmcup || command tput te)'
        [tput_eel]='$(command tput el || command tput ce)'
        [tput_hide]='$(command tput civis || command tput vi)'
        [tput_home]='$(command tput home)'
        [tput_reset]='$(command tput sgr0 || command tput me)'
        [tput_show]='$(command tput cnorm || command tput ve)'
        [tput_white_f]='$(command tput setaf 7 || command tput AF 7)'
)"

if
        [[ $TERM != *-m ]]
then
        BlscdSettingsStr+=(
                [tput_black_f]=$(command tput setaf 0 || command tput AF 0)
                [tput_blue_f]=$(command tput setaf 4 || command tput AF 4)
                [tput_cyan_f]=$(command tput setaf 6 || command tput AF 6)
                [tput_green_b]=$(command tput setab 2)
                [tput_green_f]=$(command tput setaf 2 || command tput AF 2)
                [tput_red_b]=$(command tput setab 1)
                [tput_red_f]=$(command tput setaf 1 || command tput AF 1)
                [tput_white_b]=$(command tput setab 7)
                [tput_yellow_b]=$(command tput setab 3)
                [tput_yellow_f]=$(command tput setaf 3 || command tput AF 3)
        )
fi

#      -        regular file
#      ?        some other file type
#      C        high performance ('contiguous data') file
#      D        door (Solaris 2.5 and up)
#      M        off-line ('migrated') file (Cray DMF)
#      P        port (Solaris 10 and up)
#      b        block special file
#      c        character special file
#      d        directory
#      l        symbolic link
#      n        network special file (HP-UX)
#      p        FIFO (named pipe)
#      s        socket

BlscdSettingsStr+=(
        [-,color]=
        [?,color]=${BlscdSettingsStr[tput_red_f]}
        [C,color]=
        [D,color]=
        [M,color]=
        [P,color]=
        [b,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_blue_f]}
        [c,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_white_f]}
        [c1,csr,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_black_f]}${BlscdSettingsStr[tput_green_b]}
        [c1_err,csr,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_black_f]}${BlscdSettingsStr[tput_red_b]}
        [c2,csr,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_black_f]}${BlscdSettingsStr[tput_green_b]}
        [c2_err,csr,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_black_f]}${BlscdSettingsStr[tput_red_b]}
        [c3,csr,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_black_f]}${BlscdSettingsStr[tput_green_b]}
        [c3_err,csr,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_black_f]}${BlscdSettingsStr[tput_red_b]}
        [d,color]=${BlscdSettingsStr[tput_blue_f]}
        [l,color]=${BlscdSettingsStr[tput_green_f]}
        [n,color]=
        [p,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_yellow_f]}
        [s,color]=${BlscdSettingsStr[tput_bold]}${BlscdSettingsStr[tput_yellow_f]}
        [sbar,color]=${BlscdSettingsStr[tput_blue_f]}${BlscdSettingsStr[tput_bold]}
)

builtin typeset -gAi "BlscdSettingsInt=(
        [bsr_h]=
        [c1_csr]=
        [c1_ofs]=1
        [c1_total]=
        [c1_vis]=
        [c2_csr]=
        [c2_ofs]=1
        [c2_total]=
        [c2_vis]=
        [c3_csr]=
        [c3_ofs]=1
        [c3_total]=
        [c3_vis]=
        [hidden]=1
        [ofs]=4
        [redraw]=1
        [redraw_cnt]=
        [reprint]=1
        [step]=6
)"

builtin typeset -x LC_COLLATE=C

builtin typeset -gn \
        D=BlscdData \
        I=BlscdSettingsInt \
        S=BlscdSettingsStr;
INIT

                builtin printf '%s\n' "$i"
        } 2>>/tmp/blscd.log

        function Blscd__Main
        {
                Blscd__GetArgs "$@" || {
                        builtin source <(Blscd__Init)
                        Blscd__SetEnv
                        Blscd__MainLoop
                }
        }

        function Blscd__MainLoop
        while
                builtin :
        do
                builtin printf "${S[tput_hide]}${S[tput_am_off]}"
                (( ${I[redraw]} == 0 )) || {
                        Blscd__DrawScreen || builtin break
                        Blscd__SetResize 0
                        (( ++${I[redraw_cnt]} ))
                }
                Blscd__GetInputKeyboard
        done

        function Blscd__MoveCol
        {
                Blscd__SetResize 2

                function Blscd__MoveColUp
                {
                        Blscd__SetAction
                }

                function Blscd__MoveColDown
                {
                        Blscd__SetAction
                }

                if
                        [[ $1 == .. ]]
                then
                        Blscd__MoveColUp
                else
                        Blscd__MoveColDown
                fi

                I[c2_ofs]=1
                I[c2_csr]=0

                builtin cd -- "$1"
        }

        function Blscd__MoveLine
        {
                Blscd__SetResize 1

                function Blscd__MoveLineDo
                {
                        builtin typeset -i \
                                col=$1 \
                                difference= \
                                list_total=$2 \
                                max_cursor=$((bsr_vis - 1)) \
                                max_index=$(($2 - bsr_vis + 1)) \
                                old_index=$view_offset \
                                step_l=

                        # Add the argument to the current bsr_csr
                        bsr_csr="bsr_csr + arg"

                        if
                                (( bsr_csr >= bsr_vis ))
                        then
                                # bsr_csr moved past the bottom of the list.
                                if
                                        (( bsr_vis >= list_total ))
                                then
                                        # The list fits entirely on the screen.
                                        sview_offset=1
                                else
                                        # The list doesn't fit on the screen.
                                        if
                                                (( view_offset + bsr_csr > list_total ))
                                        then
                                                # bsr_csr out of bounds. Put it at the very bottom.
                                                view_offset=$max_index
                                        else
                                            # Move the view_offset down so the visible part of the list,
                                            # also shows the bsr_csr.
                                            difference="bsr_vis - 1 - bsr_csr"
                                            view_offset="view_offset - difference"
                                        fi
                                fi
                                # In any case, place the bsr_csr on the last file.
                                bsr_csr=$max_cursor
                        elif
                                (( bsr_csr <= 0 ))
                        then
                                # bsr_csr is above the list, so scroll up.
                                view_offset="view_offset + bsr_csr"
                                bsr_csr=0
                        fi

                        # The view_offset should always be >0 and <$max_index.
                        (( view_offset > max_index )) && \
                                view_offset=$max_index

                        (( view_offset < 1 )) && \
                                view_offset=1

                        (( view_offset == old_index )) || {
                                # redraw if the view_offset (and thus the visible files) has changed.
                                #I[reprint]=1

                                # Jump a step_l when scrolling.
                                if
                                        (( view_offset > old_index ))
                                then
                                        # Jump a step_l down.
                                        step_l="max_index - view_offset"
                                        (( step_l > ${I[step]} )) && \
                                                step_l=${I[step]}
                                        view_offset="view_offset + step_l"
                                        bsr_csr="bsr_csr - step_l"
                                else
                                        # Jump a step_l up.
                                        step_l="view_offset - 1"
                                        (( step_l > ${I[step]} )) && \
                                                step_l=${I[step]}
                                        view_offset="view_offset - step_l"
                                        bsr_csr="bsr_csr + step_l"
                                fi
                        }

                        # The view_offset should always be >0 and <$max_index.
                        (( view_offset > max_index )) && \
                                view_offset=$max_index
                        (( view_offset < 1 )) && \
                                view_offset=1
            }

                builtin typeset -i arg=$2

                case $1 in
                1)
                        builtin typeset -i \
                                bsr_csr=${I[c1_csr]} \
                                bsr_vis=${I[c1_vis]} \
                        view_offset=${I[c1_ofs]}
                        Blscd__MoveLineDo "$1" "${I[c1_total]}"
                        I[c1_ofs]=$view_offset
                        I[c1_csr]=$bsr_csr
                        I[c1_vis]=$bsr_vis
                ;;
                2)
                        Blscd__SetAction
                        builtin typeset -i \
                                bsr_csr=${I[c2_csr]} \
                                bsr_vis=${I[c2_vis]} \
                        view_offset=${I[c2_ofs]}
                        Blscd__MoveLineDo "$1" "${I[c2_total]}"
                        I[c2_ofs]=$view_offset
                        I[c2_csr]=$bsr_csr
                        I[c2_vis]=$bsr_vis
                ;;
                3)
                        :
                ;;
                esac
        }

        #~ function Blscd__MoveParent
        #~ {
                #~ if
                        #~ [[
                                #~ -n ${D[${D[${S[pwd_di]},$((${D[${S[cwd_di]},${I[hidden]},idx]} ${1}))]},str]} &&
                                #~ -d ${S[pwd_str]}/${D[${D[${S[pwd_di]},$((${D[${S[cwd_di]},${I[hidden]},idx]} ${1}))]},str]}
                        #~ ]]
                #~ then
                        #~ builtin cd -- "${S[pwd_str]}/${D[${D[${S[pwd_di]},$((${D[${S[cwd_di]},${I[hidden]},idx]} ${1}))]},str]}"
                        #~ Blscd__SetAction
                        #~ Blscd__SetResize 2
                        #~ D[${S[cwd_str]},${I[hidden]},di]=
                        #~ D[${S[pwd_di]}:${I[bsr_h]},csr]=
                        #~ D[${S[pwd_di]}:${I[bsr_h]},ofs]=
                        #~ I[c1_csr]=0
                        #~ I[c1_ofs]=1
                #~ fi
        #~ }

        function Blscd__OpenFile
        if
                [[
                        -d $1 #&&${I[c3_total]} -ne 0
                ]]
        then
                Blscd__MoveCol "$1"
        else
                Blscd__SetAction
                [[ -e $1 ]] && \
                        builtin eval "${BlscdSettingsStr[opener]}" 2>>/tmp/blscd.log
        fi

        function Blscd__OpenShell
        {
            command stty ${S[saved_stty]}
            builtin printf "${S[tput_ealt]}"
            command "${SHELL:-bash}"
            command stty -echo
        }

        function Blscd__PrintHelp
        {
                {
                        builtin typeset help="$(</dev/fd/0)"
                }  <<-'HELP'
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
        ^H                    Toggle filtering of dotfiles

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
HELP

                builtin printf '%s\n' "$help"
        }

        function Blscd__PrintVersion
        {
            builtin typeset version=0.2.0
            builtin typeset md5sum="$(command md5sum "${BASH_SOURCE[0]}")"
            builtin printf 'v%s (%s)\n' "${version}" "${md5sum%  *}"
        }

        function Blscd__Reload
        {
                builtin trap - SIGWINCH SIGINT SIGALRM
                command stty ${S[saved_stty]}
                builtin typeset LC_COLLATE=${S[saved_LC_COLLATE]}
                builtin unset -v \
                        BlscdData \
                        BlscdSettingsInt \
                        BlscdSettingsStr \
                        D \
                        I \
                        S;
                builtin source <(Blscd__Init)
                Blscd__SetEnv
        }

        function Blscd__SetAction
        {
            S[action_last]=${FUNCNAME[1]}
        }

        function Blscd__SetEnv
        {
                builtin printf "${S[tput_alt]}"
                command stty -echo
                builtin trap '
                        Blscd__SetResize 2
                        builtin printf \
                                "${S[tput_cup_99999_0]}" \
                                "${S[tput_eel]}"
                ' SIGWINCH
                builtin trap 'printf "${S[tput_clear]}"' SIGINT
                builtin trap '' SIGALRM
        }

        function Blscd__SetResize
        case $1 in
        1)
                I[redraw]=1
                I[reprint]=0
        ;;
        2)
                I[redraw]=1
                I[reprint]=1
        ;;
        *)
                I[redraw]=0
                I[reprint]=0
        ;;
        esac

        function Blscd__SetScreen
        {
                builtin read -r dim_cols dim_lines <<< $(
                                command tput -S < <(
                                        builtin printf '%s\n' cols lines
                                )
                )
                c1_w="(dim_cols - 2) / 5"
                c2_w="c1_w * 2"
                c3_w="c1_w * 2"
                I[bsr_h]="dim_lines - ${I[ofs]} + 1"
        }

        function Blscd__SetWd
        {
                S[cwd_str]=$PWD
                S[cwd_str]=${S[cwd_str]//\/\//\/}
                S[pwd_str]=${S[cwd_str]%/*}
                S[pwd_str]=${S[pwd_str]:-/}
        }

        function Blscd__ToggleHidden
        {
                Blscd__SetAction
                Blscd__SetResize 2

                ((
                        I[hidden] =
                        ${I[hidden]}
                        ? 0
                        : 1
                ))

                D[${S[cwd_di]}:${I[bsr_h]},csr]=
                D[${S[cwd_di]}:${I[bsr_h]},ofs]=
                D[${S[cwd_str]},${I[hidden]},di]=
                D[${S[file_di]}:${I[bsr_h]},csr]=
                D[${S[file_di]}:${I[bsr_h]},ofs]=
                D[${S[file_str]},${I[hidden]},di]=
                D[${S[preview_di]}:${I[bsr_h]},csr]=
                D[${S[preview_di]}:${I[bsr_h]},ofs]=
                D[${S[preview_str]},${I[hidden]},di]=
                D[${S[pwd_di]}:${I[bsr_h]},csr]=
                D[${S[pwd_di]}:${I[bsr_h]},ofs]=
                D[${S[pwd_str]},${I[hidden]},di]=
                I[c1_csr]=0
                I[c1_ofs]=1
                I[c2_csr]=0
                I[c2_ofs]=1
                I[c3_csr]=0
                I[c3_ofs]=1
        }

        # -- MAIN.

        builtin typeset -i ret

        builtin eval "$@"
        ret=$?

        builtin unset -f \
                Blscd__DrawScreen \
                Blscd__DrawScreenBsr \
                Blscd__DrawScreenSbar \
                Blscd__DrawScreenTbar \
                Blscd__EditFile \
                Blscd__Exit \
                Blscd__GetArgs \
                Blscd__GetBlscdData \
                Blscd__GetBlscdDataByAwk \
                Blscd__GetBlscdDataByBash \
                Blscd__GetDi \
                Blscd__GetInputKeyboard \
                Blscd__Init \
                Blscd__Main \
                Blscd__MainLoop \
                Blscd__MoveCol \
                Blscd__MoveColDown \
                Blscd__MoveColUp \
                Blscd__MoveLine \
                Blscd__MoveLineDo \
                Blscd__OpenFile \
                Blscd__OpenShell \
                Blscd__PrintHelp \
                Blscd__PrintVersion \
                Blscd__Reload \
                Blscd__SetAction \
                Blscd__SetEnv \
                Blscd__SetResize \
                Blscd__SetScreen \
                Blscd__SetWd \
                Blscd__ToggleHidden ;


        builtin return "$ret"
}

source $HOME/var/code/projects/spath.sh/spath.sh

Blscd "$@"

unset -f __spath_do __spath_get_cols
