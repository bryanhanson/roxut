
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

## What is `roxut`?

Much as `roxygen2` allows one to document functions in the same file as the function itself, `roxut`  allows one to write the unit tests in the same file as the function.  Once processed, the unit tests are moved to the appropriate directory.  Currently supports `testthat` and `tinytest` frameworks.  Relies on and extends the `roxygen2` system.

Full Disclosure: Mikkel Meyer Andersen had this idea already, back in July 2019!  His [roxytest](https://cran.r-project.org/package=roxytest) package takes care of unit tests in a manner similar to `roxut` and also includes some additional useful roclets.  Note to self: look around more fully before starting a new package!

### Installing `roxut` from CRAN:

````r
chooseCRANmirror() # choose a CRAN mirror
install.packages("roxut")
library("roxut")
````

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
#' @tests tinytest # or testthat
#' expect_equal(blah blah blah)
#' expect_true(blah blah blah)
#' ... snip: more documentation using tags
test <- function() {do something}
```

You will also need to put a driver script in the appropriate directory.  For example `tinytest` requires `...PkgName/tests/tinytest.R` and `testthat` requires `...PkgName/tests/unittest.R`.  See the corresponding package documentation for details about the necessary files.

When `roxut` reads a file called `myFunction.R` containing `@tests` tags, it creates a file called `test-myFunction.R` in the directory containing the unit tests.  *This file is overwritten each time you run `roxut` if it was previously created by `roxut`* (this is the same behavior as `roxygen2` on `*.Rd` files).

You can use both `roxut` and manually created, dedicated unit test files simultaneously, as long as the manually created files avoid using the file names used by `roxut`. You can also have any other files you like in the directory holding the unit tests, such as files that generate test data.  

To run `roxut` set the working directory to the root of the package and do:

```r
library("roxut")
roxygenize(roclets = c("rd", "collate", "namespace", "tests_roclet"))
```

You can also run specific roclets if you don't want them all.  When you `roxygenize()`, the contents of the `@tests` block are copied to files in the necessary directory.  You can also use `document()` in place of `roxygenize()`.

If you are writing a package, put the following line in your `DESCRIPTION` file:

```
Roxygen: list(roclets = c("collate", "namespace", "rd", "roxut::tests_roclet"))
```

and then if you build and check via a `make` file or similar steps when `roxygenize()` or `document()` is called the `tests_roclet` will automatically be applied.  Good stuff from the developers of `roxygen2`!

### Developers/Contributors/Testers

`tinytest` is used to perform unit tests of `roxut`.  In this case, there is a test package at `roxut/inst/tinytest/roxutTestPkg`.  When `roxut` is checked, this test package is used for testing `roxut`, and it is also built and checked to verify everything worked.  The process is controlled by `roxut/inst/tinytest/test_roxutTestPkg.R`; have a look!  See also the unit tests in `tests_roclet.R`.

### License Information

`roxut` is distributed under the GPL-3 license, as stated in the DESCRIPTION file.  For more info, see the [GPL site.](https://gnu.org/licenses/gpl.html)

Questions?  hanson@depauw.edu
