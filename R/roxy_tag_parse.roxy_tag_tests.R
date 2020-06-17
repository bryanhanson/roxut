#'
#' Parse @tests Tags
#'
#' The `roxygen2` infrastructure is used to parse the `@tests` tags.
#' This function is called once for each tag in a `*.R` file.
#' 
#' @param x A `roclet` object.
#'
#' @return The `x` object is returned, appended with a list `val`
#'        containing two elements:
#' \itemize{
#'   \item `framework` containing the name of the unit test framework in use.
#'   \item `tests`containing the content of the unit tests.
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
