#!/usr/bin/env fish
# Script to find unused xib and storyboard files in a project


set searchPath $argv[1]
if count $argv[2] > /dev/null
    set limit $argv[2]
end

set fpaths (grep -r --include="*.xib" --include="*.storyboard" -l "" $searchPath)
set -l toRemove
set count 0
for fpath in $fpaths
    set name (basename $fpath)
    set nib (path change-extension '' $name)
    printf "\n%s: " $fpath
    set swiftFile $nib.swift
    set nibFile $nib.xib
    set sbFile $nib.storyboard
    set objmFile $nib.m
    set objhFile $nib.h
    if grep -r --silent --include="*.m" --include="*.h" --include="*.xib" --include="*.storyboard" --include="*.swift" --exclude=$swiftFile --exclude=$nibFile --exclude=$sbFile --exclude=$objmFile --exclude=$objhFile $nib $searchPath
        printf "\tused"
    else
        set -a toRemove $fpath
        printf "\tnot used"
    end

    if test $limit
        set count (math $count + 1)
        if test $count -eq $limit
            break
        end
    end
end

printf "\n\nSummary\n-------\n"
printf "Unused files:\n\n"
printf "%s\\n" $toRemove
printf "\nNumber of unused files:\t(%d)\t\tTotal size:\t\n" $(count $toRemove)

read -P "Do you want to delete unused files? (type \"YES DELETE\" all in capital to confirm. move unreversable): " ans
if test $ans = "YES DELETE"
    for path in $toRemove
        rm $path
    end
    printf "All unused files deleted.\n"
end