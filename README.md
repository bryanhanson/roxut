
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

## What is `roxut`?

Much as `roxygen2` allows one to document functions in the same file as the function itself, `roxut`  allows one to write the unit tests in the same file as the function.  Once processed, the unit tests are moved to the appropriate directory.  Currently supports `testthat` and `tinytest` frameworks.  Relies on and extends the `roxygen2` system.

### Installing `roxut` from Github:

````r
install.packages("remotes")
library("remotes")
install_github(repo = "bryanhanson/roxut@master")
library("roxut")
````

If you use `@some_other_branch` you can download other branches that might be available.  They may or may not pass CRAN checks and thus may not install automatically using the method above.  Check the NEWS file to see what's up.

### Using `roxut`

To use `roxut`, write your unit tests in the function definition file, much as you would write your examples and other `roxygen2` tags:

```r
#' ... snip: documentation using tags
#' @tests tinytest (or testthat)
#' expect_equal(blah blah blah)
#' expect_true(blah blah blah)
#' ... snip: more documentation using tags
test <- function() {something}
```

You will also need to put a driver script in the appropriate directory.  For example `tinytest` requires `...PkgName/tests/tinytest.R` and `testthat` requires `...PkgName/tests/unittest.R`.  See the corresponding package documentation for details about the necessary files.

You can have any other files you like in the directory holding the unit tests, such as files that generate test data.  When `roxut` reads a file called `myFunction.R` containing `@tests` tags, it creates a file called `test_myFunction.R` in the directory containing the unit tests.  *This file is overwritten each time you run `roxut`.*  You can use both `roxut` and manually written dedicated unit test files simultaneously, as long as the manually written files avoid using the names used by `roxut`.

Finally, to run `roxut` set the working directory to the root of the package and do:

```r
roxygenize(roclets = c("rd", "collate", "namespace", "tests_roclet"))
```

You can also run specific roclets if you don't want them all.  When you `roxygenize`, the contents of the `@tests` block are copied to files in the necessary directory.

### Developers/Contributors/Testers

`tinytest` is used to perform unit tests of `roxut`.  In this case, there is a test package at `roxut/inst/tinytest/roxutTestPkg`.  When `roxut` is checked, this test package is used for testing `roxut`, and it is also built, checked and installed to verify everything worked.

### License Information

`roxut` is distributed under the GPL-3 license, as stated in the DESCRIPTION file.  For more info, see the [GPL site.](https://gnu.org/licenses/gpl.html)

Questions?  hanson@depauw.edu
