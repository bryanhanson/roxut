#'
#' Test File #1
#'
#' This test file serves as a demonstration of the `@tests` tag infrastructure.
#' It contains multiple `@tests` blocks and uses both `tinytest` and `testthat`.
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
#' # comment 1
#' expect_true(testFunc1(1, 1) == 2.0)
#' expect_true(testFunc1(1.5, 0.25) == 1.75)
#' 
#' @tests tinytest
#' # comment 2
#' expect_true(testFunc1(1, 1) == 2.0)
#' expect_true(testFunc1(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc1(1.5, 0.25)))
#' 
#' @tests testthat
#' # comment 3
#' expect_false(testFunc1(1, 1) == 5)
#' expect_false(is.na(testFunc1(1.5, 0.25)))
#' 
testFunc1 <- function(x, y) x + y
