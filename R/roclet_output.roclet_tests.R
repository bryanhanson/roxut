#'
#' Write the Results of Processing @tests Tags to Unit Test File
#'
#' The contents of the unit tests (lines following the \code{@tests} tags)
#' are written verbatim to the appropriate directories (directory depends
#' on whether \code{tinytest} or \code{testthat} is in use).  If there is more
#' than one function and corresponding unit tests in a file, the first unit tests
#' will be in \code{filename.R}, the second in \code{filename-1.R} etc.
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

    # extract the test contents, the file name and the line numbers where the test was found
    pat <- "\\[(.*\\.R):([0-9]+)\\](.*)"
    file <- sub(pat, "\\1", results[[framework]])
    line <- sub(pat, "\\2", results[[framework]])
    tests <- sub(pat, "\\3", results[[framework]])

    # prepare the output file name
    fn <- basename(file)
    fn <- tools::file_path_sans_ext(fn)
    fn <- make.unique(fn, "-") # needed in case there are multiple functions and UTs in one file
    fn <- paste0(fn, ".R")

    # clean up the file name & add line numbers (basename avoids any platform-dependant issues)
    file_line <- basename(file)
    file_line <- paste(file_line, line, sep = ":")

    # re-assemble with some formating
    tests <- paste("\n# Test found in", file_line, "(file:line)\n", tests)

    if (framework == "tinytest") {

      # create any needed directories
      need_inst_dir <- !dir.exists(file.path("inst"))
      if (need_inst_dir) dir.create("inst")
      need_tt_dir <- !dir.exists(file.path("inst/tinytest"))
      if (need_tt_dir) dir.create("inst/tinytest")

      # write out unit test files
      for (i in 1:length(fn)) {
        out_file <- paste0("inst/tinytest/test-", fn[i])
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
        out_file <- paste0("tests/testthat/test-", fn[i])
        writeUT(tests[i], out_file)
      }

    }

  } # end of master loop

  invisible(tests)
}
