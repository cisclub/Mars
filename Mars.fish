#!/usr/bin/env fish
# Script to find unused xib and storyboard files in a project


set fpaths (grep -r --include="*.xib" --include="*.storyboard" -l "")
set -l all
for fpath in $fpaths
	set nm (basename $fpath)
    set -a all $nm
end

set -l toRemove
set count 1
for withExt in $all
    set count (math $count + 1)
    if test $count -eq 200
        break
    end
    set nib (path change-extension '' $withExt)
    printf "%s: " $withExt
    set filesContainXib (grep -rl --include="*.xib" --include="*.storyboard" --include="*.swift" $nib)
    set -l filesThatUse
    for file in $filesContainXib
        set fileNameWithExt (basename $file)
        set fileName (path change-extension '' $fileNameWithExt)
        set isNotSameFile $fileName != $nib
        if test $isNotSameFile
            set -a filesThatUse $fileName
        end    
    end
    set isEmpty (count $filesThatUse) -eq 0
    if test $isEmpty
        set -a toRemove $nib
        printf "\tnot used\n"
    else 
        printf "\tused\n"
    end
end

printf "\n\nSummary\n-------\n"
printf "Unused files:\n\n"
printf "%s\\n" $toRemove
printf "\nNumber of unsed files:\t(%d)\t\tTotal size:\t\n" $(count $toRemove)