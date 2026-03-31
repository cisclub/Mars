
<p align="center">
  <img width="265" height="265" alt="mars" src="https://github.com/user-attachments/assets/ecc15187-c70b-42a6-a60a-4f575be91fab" />
</p>


# Mars
Script to list unused xib and storyboard files in an xcode project.

## Requirements:
- Script must be run in [fish shell](https://fishshell.com/)

## Before use
1. Download the script (Mars.fish)
2. In terminal `chmod +x ~/path-to-script/Mars.fish`

## How to use
`fish Mars.fish path-to-search-in [limit]`</br>
**[limit]:** to limit the number of files to test.</br>
If the command takes long time, you can limit the number of files to scan (to 100 for example).</br>

**Example:** `fish ~/Downloads/Mars.fish ~/my-project-directory 200`</br>
This will scan only 100 `.xib` and `.storyboard` files in /my-project-directory before it prints summary and exit.</br>

**Example:** `fish ~/Downloads/Mars.fish ~/my-project-directory`</br>
This will scan all files.

## Notes:
- No guarantee there will not be false-positive(s) or false-negative(s).
- Script doesn't delete files. It will list them only.
  
## How it works

## Backlog
- Add option to delete files
- [done] Add option to set a limit for number of files to check (script is very slow)
- Optimization
- Add option to pass exception file (Strings.swift shouldn't count as used)
- Calculate total size
