#'
#' tests_roclet
#'
#' This roclet automates the creation of unit tests, using \code{@tests} tags
#' written in the function definition files, and processed using \code{roxygen2}.
#' The unit tests are written verbatim to the appropriate destination file.
#'
#' @return A complete roclet.
#'
#' @author Bryan A. Hanson
#' @export
#' @examples
#' # In actual use, the test lines would be in your function definition file.
#' # The results (cat'd here) would be written to the unit test file.
#' # If the function definition file is myFunc.R then the results
#' # are written to test_myFunc.R in the appropriate directory
#' # (which depends on whether your are using tinytest or testthat).
#'
#' tinytest_lines <- "#' @tests tinytest\n#' expect_equal(5.0, 5.0)\nNULL\n"
#' tinytest_out <- roxygen2::roc_proc_text(tests_roclet(), tinytest_lines)
#' cat(tinytest_out$tinytest)
#' 
#' testthat_lines <- "#' @tests testthat\n#' expect_true(1 > 0)\nNULL\n"
#' testthat_out <- roxygen2::roc_proc_text(tests_roclet(), testthat_lines)
#' cat(testthat_out$testthat)
#' 

tests_roclet <- function() {
  roclet("tests")
}
