### Run tests

#### Run single test

`$> cd <path/to/project>`
`$> ruby -I lib -r disable_skip -r minitest/pride <exercise_dir>/<test_file>`

#### Run all tests

`$> for file in */*test.rb; do ruby -I lib -r disable_skip -r minitest/pride $file; done`
