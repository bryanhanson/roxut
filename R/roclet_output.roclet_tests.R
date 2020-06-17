#'
#' Roclet to Write the Results of Processing @tests Tags to Unit Test File
#'
#' @param x A `roclet` object.
#'
#' @param results Value returned from the `roclet_process()` method.
#'
#' @param base_path Path to root of source package.
#'
#' @param ... Other arguments passed downstream. Needed for compatibility,
#'        does not appear to be used.
#'
#' @return `NULL`
#'
#' @author Bryan A. Hanson
#'
#' @export
#'

roclet_output.roclet_tests <- function(x, results, base_path, ...) {

  for (framework in names(results)) {

    # extract the original short filename
    fn <- sub("\\[.*/(.*)\\.R:[0-9]+\\].*", "\\1", results[[framework]])

    # ensure fn is length 1
    fn <- unique(fn)
    if (length(fn) > 1) stop("More than one file name is present")

    # extract the test contents
    tests <- sub(".*\\](.*)", "\\1", results[[framework]])

    # collapse tests if more than one present
    tests <- paste0(tests, collapse = "\n")

    if (framework == "tinytest") {

      # create output filename
      out_name <- paste("inst/tinytest/test_", fn, ".R", sep = "")
 
     # create any needed directories
      need_inst_dir <- !dir.exists(file.path("inst"))
      if (need_inst_dir) dir.create("inst")
      need_tt_dir <- !dir.exists(file.path("inst/tinytest"))
      if (need_tt_dir) dir.create("inst/tinytest")

      # write to file and close
      tests <- c("# File created by roxut; edit the function definition file, not this file\n", tests)
      # the line above also used by roclet_clean
      writeLines(tests, con = out_name, sep = "")
    }

    if (framework == "testthat") {

      # create output filename
      out_name <- paste("tests/testthat/test_", fn, ".R", sep = "")
 
     # create any needed directories
      need_inst_dir <- !dir.exists(file.path("tests"))
      if (need_inst_dir) dir.create("tests")
      need_tt_dir <- !dir.exists(file.path("tests/testthat"))
      if (need_tt_dir) dir.create("tests/testthat")

      # write to file and close
      tests <- c("# File created by roxut; edit the function definition file, not this file\n", tests)
      # the line above also used by roclet_clean
      writeLines(tests, con = out_name, sep = "")
    }
  }

  invisible(NULL)
}


