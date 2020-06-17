[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

## What is `roxut`?

Much as 'roxygen2' allows one to document functions in the same file as the function itself, 'roxut'  allows one to write the unit tests in the same file as the function.  Once processed, the unit tests are moved to the appropriate directory.  Currently supports 'testthat' and 'tinytest' frameworks.  Relies on and extends the 'roxygen2' system.

### Installing `roxut` from Github:

````r
install.packages("remotes")
library("remotes")
install_github(repo = "bryanhanson/roxut@master")
library("roxut")
?roxut # to get started
````

If you use `@some_other_branch` you can download other branches that might be available.  They may or may not pass CRAN checks and thus may not install automatically using the method above.  Check the NEWS file to see what's up.

### Developers/Contributors/Testers

If you set your working directory to the top level of your local copy of the repository, you can run `make` to build, check and install the package.  `tinytest` is used to perform unit tests of `roxut`.  In this case, there is a test package at `roxut/roxut/inst/tinytest/roxutTestPkg`.  When `roxut` is checked, this test package is used for testing `roxut`, and it is also built, checked and installed to verify everything worked.

### License Information

`roxut` is distributed under the GPL-3 license, as stated in the DESCRIPTION file.  For more info, see the [GPL site.](https://gnu.org/licenses/gpl.html)

Questions?  hanson@depauw.edu
