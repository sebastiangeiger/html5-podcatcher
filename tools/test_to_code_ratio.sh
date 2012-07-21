#!/usr/bin/evn sh
code_lines=$(cat `find app -name "*.rb"  | xargs` | wc -l)
test_lines=$(cat `find spec -name "*.rb" | xargs` | wc -l)

ratio=$(echo "scale=2; $test_lines / $code_lines" | bc)
echo "${ratio} lines of tests for 1 line of code"
