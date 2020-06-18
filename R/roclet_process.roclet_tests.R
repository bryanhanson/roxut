#'
#' Process @tests Tags
#'
#' Processes the blocks containing the \code{@tests} tags.
#'
#' @param x A \code{roclet} object.
#'
#' @param blocks A list of \code{roxy_block} objects.
#'
#' @param env Package environment.
#'
#' @param base_path Path to root of source package.
#'
#' @return A list.
#'
#' @author Bryan A. Hanson
#'
#' @export
#'
roclet_process.roclet_tests <- function(x, blocks, env, base_path) {
  results <- list()

  for (block in blocks) {
    tags <- block_get_tags(block, "tests")

    for (tag in tags) {
      msg <- paste0("[", tag$file, ":", tag$line, "] ", tag$val$tests)
      results[[tag$val$framework]] <- c(results[[tag$val$framework]], msg)
    }
  }
  results
}
