#'
#' Process @tests Tags
#'
#' @param x A `roclet` object.
#'
#' @param blocks A list of [roxy_block] objects.
#'
#' @param env Package environment.
#'
#' @param base_path Path to root of source package.
#'
#' @return A list containing XXX.
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


