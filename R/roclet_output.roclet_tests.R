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
#' @return Invisibly, a list with the text of the tests. Writes files!
#'
#' @author Bryan A. Hanson
#'
#' @export
#'

roclet_output.roclet_tests <- function(x, results, base_path, ...) {

  # This is vectorized over results (and thus fn, tests)

  # helper functions
  writeUT <- function(tests, con) {
    if (roxutFile(con)) {
      tests <- paste0("# File created by roxut; edit the function definition file, not this file\n", tests)
      writeLines(tests, con, sep = "") # \n already present
      message("Writing ", con)
    }
  }

  roxutFile <- function(con) {
    rf <- TRUE
    fileExists <- file.exists(con)
    if (fileExists) {
      line1 <- readLines(con, n = 1L)
      if (!grepl("# File created by roxut;", line1)) {
        warning("File ", con, " already exists and was not created by roxut, skipping")
        rf <- FALSE
      }
    }
    return(rf)
  }

  # main function

  for (framework in names(results)) {

    # extract the original short filenames
    fn <- sub("\\[(.*\\.R):[0-9]+\\](.*)", "\\1", results[[framework]])
    fn <- basename(fn)

    # extract the test contents
    tests <- sub("(\\[.*\\.R:[0-9]+\\])(.*)", "\\2", results[[framework]])

    if (framework == "tinytest") {

      # create any needed directories
      need_inst_dir <- !dir.exists(file.path("inst"))
      if (need_inst_dir) dir.create("inst")
      need_tt_dir <- !dir.exists(file.path("inst/tinytest"))
      if (need_tt_dir) dir.create("inst/tinytest")

      # write out unit test files
      for (i in 1:length(fn)) {
        out_file <- paste0("inst/tinytest/test_", fn[i])
        writeUT(tests[i], out_file)
      }

    }

    if (framework == "testthat") {

      # create any needed directories
      need_inst_dir <- !dir.exists(file.path("tests"))
      if (need_inst_dir) dir.create("tests")
      need_tt_dir <- !dir.exists(file.path("tests/testthat"))
      if (need_tt_dir) dir.create("tests/testthat")

      # write out unit test files
      for (i in 1:length(fn)) {
        out_file <- paste0("tests/testthat/test_", fn[i])
        writeUT(tests[i], out_file)
      }

    }

  } # end of master loop

  invisible(tests)
}
