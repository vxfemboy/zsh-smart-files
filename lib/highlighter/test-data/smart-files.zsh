# lib/highlighter/test-data/smart-files.zsh

#!/usr/bin/env zsh
# Test new directory creation highlighting

# Test case: mv with new directory
BUFFER='mv file.txt new/dir/'
expected_region_highlight=(
  "1 2  command"                # mv
  "4 11 default"               # file.txt
  "13 20 smart-files:newpath"  # new/dir/
)

# Test case: cp with new directory
BUFFER='cp file.txt other/new/path/'
expected_region_highlight=(
  "1 2  command"                # cp
  "4 11 default"               # file.txt
  "13 27 smart-files:newpath"  # other/new/path/
)
