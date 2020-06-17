# File created by roxut; edit the function definition file, not this file
 
# comment 1
expect_true(testFunc1(1, 1) == 2.0)
expect_true(testFunc1(1.5, 0.25) == 1.75)

 
# comment 3
expect_false(testFunc1(1, 1) == 5)
expect_false(is.na(testFunc1(1.5, 0.25)))
