#'
#' Process a package using the tests roclet
#'
#' This is the user-facing function that converts `@tests` tags
#' written in the `*.R` function definition files into unit test files.
#' This function follows `roxygenize()` closely and is adapted from it.
#'
#' This function works by examining any files in the `R` subdirectory of
#' a package, looking for any `@tests` tags which start a block of unit tests.
#' Either the `tinytest` or `testthat` framework can be used.  Each unit test
#' is copied to the appropriate directory, with one file per `*R` file.
#' It is up to the package author to
#' create and deploy the supervising functions required by each framework.
#'
#' @param package.dir Location of package top level directory. Default is
#'        working directory.
#'
#' @param load_code A function used to load all the R code in the package
#'        directory. The default, `NULL`, uses the strategy defined by
#'        the `load` `roxygen2` option, which defaults to [load_pkgload()].
#'        See [load] for more details.
#'
#' @param clean If `TRUE`, `roxygen2` will delete all files previously
#'        created by `roxut` before running the tests roclet.  If the file
#'        names have not changed existing files are overwritten each time
#'        `roxut` is run.
#' 
#' @return `NULL`  Files will be written to the appropriate directory.
#'
#' @author Bryan A. Hanson, adapted and modified from `roxygen2::roxygenize()`
#' @export
#' 
roxut <- function(package.dir = ".",
                  load_code = NULL,
                  clean = FALSE) {

  base_path <- normalizePath(package.dir, mustWork = TRUE)
  is_first <- roxygen2:::roxygen_setup(base_path)

  encoding <- desc::desc_get("Encoding", file = base_path)[[1]]
  if (!identical(encoding, "UTF-8")) {
    warning("roxygen2 requires Encoding: UTF-8", call. = FALSE)
  }

  roxygen2:::roxy_meta_load(base_path)

  # Load required packages for method registration
  packages <- roxygen2::roxy_meta_get("packages")
  lapply(packages, loadNamespace)

  roclets <- "tests_roclet"
  roclets <- lapply(roclets, roclet_find)

  # Now load code
  load_code <- roxygen2:::find_load_strategy(load_code)
  env <- load_code(base_path)
  roxygen2:::roxy_meta_set("env", env)
  on.exit(roxygen2:::roxy_meta_set("env", NULL), add = TRUE)

  # Tokenise each file
  blocks <- parse_package(base_path, env = NULL)

  if (clean) {
    purrr::walk(roclets, roclet_clean, base_path = base_path)
  }

  roclets <- lapply(roclets, roclet_preprocess,
    blocks = blocks,
    base_path = base_path
  )

  blocks <- lapply(blocks, roxygen2:::block_set_env, env = env)

  results <- lapply(roclets, roclet_process,
    blocks = blocks,
    env = env,
    base_path = base_path
  )

  out <- purrr::map2(
    roclets, results,
    roclet_output,
    base_path = base_path,
    is_first = is_first
  )
  invisible(out)
}

