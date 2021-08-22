#'
#' Test File #2 (testFunc2)
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
#' res <- testFunc2(3, 5)
#'
#' @tests tinytest
#' # tinytest tests
#' expect_true(testFunc2(1, 1) == 2.0)
#' expect_true(testFunc2(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc2(1.5, 0.25)))
#' 
#' @tests testthat
#' # testthat tests
#' expect_true(testFunc2(1, 1) == 2.0)
#' expect_true(testFunc2(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc2(1.5, 0.25)))
#' 
testFunc2 <- function(x, y) x + y
