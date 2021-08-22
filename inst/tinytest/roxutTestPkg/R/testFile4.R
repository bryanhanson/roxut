#'
#' Test File #4 (testFunc4)
#'
#' This test file serves as a demonstration of the `@tests` tag infrastructure.
#' It uses both `tinytest` and `testthat`. This particular file contains two
#' functions, each with their own unit tests.  The tests for testFunc5 should not
#' overwrite the tests for testFunc4.
#'
#' @param x Integer or real.
#' @param y Integer or real.
#'
#' @export
#'
#' @examples
#' res <- testFunc4(3, 5)
#'
#' @tests testthat
#' # testthat tests
#' expect_true(testFunc4(1, 1) == 2.0)
#' expect_true(testFunc4(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc4(1.5, 0.25)))
#'
#' @tests tinytest
#' # tinytest tests
#' expect_true(testFunc4(1, 1) == 2.0)
#' expect_true(testFunc4(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc4(1.5, 0.25)))
#'
testFunc4 <- function(x, y) x + y


#'
#' Test File #4 (testFunc5)
#'
#' This test file serves as a demonstration of the `@tests` tag infrastructure.
#' It uses both `tinytest` and `testthat`. This particular file contains two
#' functions, each with their own unit tests.  The tests for testFunc5 should not
#' overwrite the tests for testFunc4.
#'
#' @param x Integer or real.
#' @param y Integer or real.
#'
#' @export
#'
#' @examples
#' res <- testFunc5(3, 5)
#'
#' @tests testthat
#' # testthat tests
#' expect_true(testFunc5(1, 1) == 2.0)
#' expect_true(testFunc5(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc5(1.5, 0.25)))
#'
#' @tests tinytest
#' # tinytest tests
#' expect_true(testFunc5(1, 1) == 2.0)
#' expect_true(testFunc5(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc5(1.5, 0.25)))
#'
testFunc5 <- function(x, y) x + y
