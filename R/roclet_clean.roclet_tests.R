#'
#' Delete Unit Test Files Generated by @tests Tags
#'
#' Delete unit test files generated by @tests tags. Activated when
#' calling \code{roxygenize} with \code{clean = TRUE}.
#'
#' @param x A \code{roclet} object.
#'
#' @param base_path Path to root of source package.
#'
#' @return NULL  If found, files created by \code{roxut} will be deleted.
#'
#' @author Bryan A. Hanson
#' @importFrom stats na.omit
#' @export
#'

roclet_clean.roclet_tests <- function(x, base_path) {

  # To stay close to roxygen2, we can't include a "framework" argument,
  # so we'll clean all possibilites
  ut_testthat <- dir(file.path(base_path, "tests/testthat"), full.names = TRUE)
  ut_tinytest <- dir(file.path(base_path, "inst/tinytest"), full.names = TRUE)
  ut <- c(ut_testthat, ut_tinytest)
  ut <- ut[!file.info(ut)$isdir]
  remove <- NA_character_
  for (i in 1:length(ut)) {
    line1 <- readLines(ut[i], n = 1)
    if (grepl("# File created by roxut;", line1)) remove <- c(remove, ut[i])
  }
  unlink(na.omit(remove))
}
