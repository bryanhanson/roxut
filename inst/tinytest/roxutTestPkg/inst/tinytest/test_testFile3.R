
# This file exists to ensure that non-roxut files are properly skipped.
expect_true(testFunc3(1, 1) == 2.0)
expect_true(testFunc3(1.5, 0.25) == 1.75)
expect_false(is.na(testFunc3(1.5, 0.25)))
