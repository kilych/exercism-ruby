### Test

`$ cd <path/to/project>`

`$ ruby -I lib -r disable_skip -r minitest/pride <test_file>`

run all tests:

`$ for file in */*test.rb; do ruby -I lib -r disable_skip -r minitest/pride $file; done`
