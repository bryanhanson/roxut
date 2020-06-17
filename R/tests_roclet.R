#'
#' tests_roclet
#'
#' This roclet automates the creation of unit tests, using `@tests` tags
#' written in the `*.R` function definition files, and processed using `roxygen2`.
#' The unit tests are written verbatim to the appropriate destination file.
#'
#' @return XXX
#'
#' @author Bryan A. Hanson
#' @export
#'

tests_roclet <- function() {
  roclet("tests")
}
