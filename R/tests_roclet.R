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
#' # This follows closely the process in test_roxutTestPkg.R
#' # & the results are appended to roxutTestPkg.Rcheck/00check.log
#' 
#' message("\n>>> Unit test results follow\n")
#'
#' # Step 0.  Set up testing environment in a temp dir
#' setwd("roxutTestPkg")
#' td <- tempdir()
#' tst_dir <- paste(td, "unit_tests", "roxutTestPkg", sep = "/")
#' dir.create(tst_dir, recursive = TRUE)
#' system2("cp", paste0("-r . ", tst_dir))
#' setwd(tst_dir)
#' roxygenize(roclets = "tests_roclet")
#' #system2("cp", "-r . ~/Desktop/tempdir_UT") # good for troubleshooting DEACTIVATE FOR CRAN
#'
#' # Step 1. Get the file names
#' tinytest_files <- list.files("inst/tinytest", "test-.*\\.R", full.names = TRUE)
#' testthat_files <- list.files("tests/testthat", "test-.*\\.R", full.names = TRUE)
#' if (length(tinytest_files) != length(testthat_files)) stop("Did not find equal numbers of files")
#' nf <- length(tinytest_files)
#'
#' # Step 2. Compare the file contents
#  # If the tinytest contents = testhat contents, verify the contents
#  # Subsetting to get just the actual tests, not the file:line labels and empty lines
#'
#' expected_contents <- c("# File created by roxut; edit the function definition file, not this file",
#'                        "expect_true(testFunc(1, 1) == 2.0)",
#'                        "expect_true(testFunc(1.5, 0.25) == 1.75)",
#'                        "expect_false(is.na(testFunc(1.5, 0.25)))")
#' skipped_contents <- "# This file exists to demonstrate/test that non-roxut files are properly skipped."
#'
#' for (i in 1:nf) {
#'   if (i == 3L) { # the skipped file requires different checks
#'     tmp1 <- readLines(tinytest_files[i])[1]
#'     tmp2 <- readLines(testthat_files[i])[1]
#'     expect_equivalent(tmp1, tmp2)
#'     expect_equivalent(tmp1, skipped_contents)
#'   next
#'   }
#'   tmp1 <- readLines(tinytest_files[i])[-c(2:5)]
#'   tmp2 <- readLines(testthat_files[i])[-c(2:5)]
#'   expect_equivalent(tmp1, tmp2)
#'   tmp3 <- sub("(testFunc)[0-9]{1}", "\\1", tmp1) # harmonize: testFunc1 -> testFunc etc
#'   expect_equivalent(tmp3, expected_contents)
#' }
#'
#' @examples
#' # In actual use, the test lines would be in your function definition file.
#' # The results (cat'd here) would be written to the unit test file.
#' # If the function definition file is myFunc.R then the results
#' # are written to test-myFunc.R in the appropriate directory
#' # (the directory depends on whether your are using tinytest or testthat).
#'
#' tinytest_in <- "#' @tests tinytest\n#' # Are these equal?\n#' expect_equal(5.0, 5.0)\nNULL\n"
#' tinytest_out <- roxygen2::roc_proc_text(tests_roclet(), tinytest_in)
#' cat(tinytest_out$tinytest, "\n")
#' 
#' testthat_in <- "#' @tests testthat\n#' # Are these equal?\n#' expect_equal(5.0, 5.0)\nNULL\n"
#' testthat_out <- roxygen2::roc_proc_text(tests_roclet(), testthat_in)
#' cat(testthat_out$testthat, "\n")
#' 

tests_roclet <- function() {
  roclet("tests")
}
