#'
#' Write the Results of Processing @tests Tags to Unit Test File
#'
#' The contents of the unit tests (lines following the \code{@tests} tags)
#' are written verbatim to the appropriate directories (directory depends
#' on whether \code{tinytest} or \code{testthat} is in use).
#'
#' @param x A \code{roclet} object.
#'
#' @param results Value returned from the \code{roclet_process()} method.
#'
#' @param base_path Path to root of source package.
#'
#' @param ... Other arguments passed downstream. Needed for compatibility,
#'        does not appear to be used.
#'
#' @return NULL
#'
#' @author Bryan A. Hanson
#'
#' @export
#'

roclet_output.roclet_tests <- function(x, results, base_path, ...) {

  # helper function
  writeUT <- function(tests, con) {
    tests <- c("# File created by roxut; edit the function definition file, not this file\n", tests)
    writeLines(tests, con, sep = "") # \n already present
    message("Writing ", con)
  }

  for (framework in names(results)) {

    # extract the original short filename
    fn <- sub("\\[.*/(.*)\\.R:[0-9]+\\].*", "\\1", results[[framework]])

    # ensure filename is unique
    fn <- unique(fn)
    if (length(fn) > 1) stop("More than one file name is present")

    # extract the test contents
    tests <- sub(".*\\](.*)", "\\1", results[[framework]])

    # collapse tests if more than one present
    tests <- paste0(tests, collapse = "\n")

    if (framework == "tinytest") {

      # create output filename
      out_file <- paste("inst/tinytest/test_", fn, ".R", sep = "")
 
      # create any needed directories
      need_inst_dir <- !dir.exists(file.path("inst"))
      if (need_inst_dir) dir.create("inst")
      need_tt_dir <- !dir.exists(file.path("inst/tinytest"))
      if (need_tt_dir) dir.create("inst/tinytest")

      # write to file and close
      writeUT(tests, out_file)
    }

    if (framework == "testthat") {

      # create output filename
      out_file <- paste("tests/testthat/test_", fn, ".R", sep = "")
 
     # create any needed directories
      need_inst_dir <- !dir.exists(file.path("tests"))
      if (need_inst_dir) dir.create("tests")
      need_tt_dir <- !dir.exists(file.path("tests/testthat"))
      if (need_tt_dir) dir.create("tests/testthat")

      # write to file and close
      writeUT(tests, out_file)
    }
  }

  invisible(NULL)
}


