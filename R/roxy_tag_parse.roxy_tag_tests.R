#'
#' Parse @tests Tags
#'
#' This function is called once for each \code{@tests} tag in a
#' function definition file.
#'
#' @param x A \code{roclet} object.
#'
#' @return The \code{x} object is returned, appended with a list \code{val}
#'        containing two elements:
#' \itemize{
#'   \item \code{framework} containing the name of the unit test framework in use.
#'   \item \code{tests} containing the content of the unit tests.
#' }
#'
#' @author Bryan A. Hanson
#'
#' @export
#'
roxy_tag_parse.roxy_tag_tests <- function(x) {
  valid_frameworks <- "(testthat|tinytest)"
  if (!grepl(valid_frameworks, x$raw)) {
    roxy_tag_warning(x, "Invalid test framework")
    return()
  }

  framework <- trimws(strsplit(x$raw, "\\n")[[1]][1])

  tests <- sub(valid_frameworks, "", x$raw)

  x$val <- list(
    framework = framework,
    tests = tests
  )
  x
}
