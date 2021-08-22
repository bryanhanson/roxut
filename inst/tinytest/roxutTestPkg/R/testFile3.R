#'
#' Test File #3 (testFunc3)
#'
#' This test file serves as a demonstration of the `@tests` tag infrastructure.
#' It uses both `tinytest` and `testthat`.
#' THIS FILE will be processed but the corresponding unit test file
#' is present in .../inst/tinytest but is not tagged by roxut, so
#' it should be skipped with a warning
#'
#' @param x Integer or real.
#' @param y Integer or real.
#'
#' @export
#'
#' @examples
#' res <- testFunc3(3, 5)
#'
#' @tests testthat
#' # testthat tests
#' expect_true(testFunc3(1, 1) == 2.0)
#' expect_true(testFunc3(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc3(1.5, 0.25)))
#' 
#' @tests tinytest
#' # tinytest tests
#' expect_true(testFunc3(1, 1) == 2.0)
#' expect_true(testFunc3(1.5, 0.25) == 1.75)
#' expect_false(is.na(testFunc3(1.5, 0.25)))
#' 
testFunc3 <- function(x, y) x + y
