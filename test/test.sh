#!/usr/bin/env bash

mkdir -p ./test-dir/dir/dir1
mkdir -p ./test-dir/$'a\nb'/dir2
mkdir -p ./test-dir/$'a\nb\nc'/dir3
mkdir -p ./test-dir/''\''I'\'' m an evil dir'\'''/dir4

mkfifo ./test-dir/FIFO

printf '%s' text > ./test-dir/FILE
printf '%s' text > ./test-dir/file
printf '%s' text > ./test-dir/''\''I'\'' m an evil file'\'''
printf '%s' text > ./test-dir/$'FILE WITH SPACES'
printf '%s' text > ./test-dir/$'a\nb\nc'/file3
printf '%s' text > ./test-dir/$'a\nb\nc'/dir3/file4

ln ./test-dir/FILE ./test-dir/FILE_HLINK
ln -sr ./test-dir/FILE ./test-dir/FILE_SLINK
ln -sr ./test-dir/ORHAN ./test-dir/ORPHAN_SLINK
ln -sr ./test-dir/dir ./test-dir/DIR_SLINK
ln -sr ./test-dir/dir ./test-dir/$'a\nb'/dir2/BLINK

ls -Rli ./test-dir
