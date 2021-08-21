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
#'
#' @tests tinytest
#'
#' # verify that tinytest & testhat output are the same
#' tinytest_lines <- "#' @tests tinytest\n#' expect_equal(5.0, 5.0)\nNULL\n"
#' tinytest_out <- roxygen2::roc_proc_text(tests_roclet(), tinytest_lines)
#' testthat_lines <- "#' @tests testthat\n#' expect_equal(5.0, 5.0)\nNULL\n"
#' testthat_out <- roxygen2::roc_proc_text(tests_roclet(), testthat_lines)
#' expect_equivalent(tinytest_out, testthat_out)
#'
#' @examples
#' # In actual use, the test lines would be in your function definition file.
#' # The results (cat'd here) would be written to the unit test file.
#' # If the function definition file is myFunc.R then the results
#' # are written to test-myFunc.R in the appropriate directory
#' # (the directory depends on whether your are using tinytest or testthat).
#'
#' tinytest_lines <- "#' @tests tinytest\n#' expect_equal(5.0, 5.0)\nNULL\n"
#' tinytest_out <- roxygen2::roc_proc_text(tests_roclet(), tinytest_lines)
#' cat(tinytest_out$tinytest, "\n")
#' 
#' testthat_lines <- "#' @tests testthat\n#' expect_equal(5.0, 5.0)\nNULL\n"
#' testthat_out <- roxygen2::roc_proc_text(tests_roclet(), testthat_lines)
#' cat(testthat_out$testthat, "\n")
#' 

tests_roclet <- function() {
  roclet("tests")
}
