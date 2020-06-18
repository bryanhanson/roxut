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

tests_roclet <- function() {
  roclet("tests")
}
