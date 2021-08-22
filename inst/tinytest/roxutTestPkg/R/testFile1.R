#'
#' Test File #1 (testFunc1)
#'
#' This test file serves as a demonstration of the `@tests` tag infrastructure.
#' It uses both `tinytest` and `testthat`.
#'
#' @param x Integer or real.
#' @param y Integer or real.
#'
#' @export
#'
#' @examples
#' res <- testFunc1(3, 5)
#'
#' @tests testthat
#' # testthat tests
#' expect_true(testFunc1(1, 1) == 2.0)
#' expect_true(testFunc1(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc1(1.5, 0.25)))
#' 
#' @tests tinytest
#' # tinytest tests
#' expect_true(testFunc1(1, 1) == 2.0)
#' expect_true(testFunc1(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc1(1.5, 0.25)))
#' 
testFunc1 <- function(x, y) x + y
