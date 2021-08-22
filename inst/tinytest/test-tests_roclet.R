# File created by roxut; edit the function definition file, not this file

# Test found in tests_roclet.R:13 (file:line)
  
# This follows closely the process in test_roxutTestPkg.R

# Step 0.  Set up testing environment in a temp dir
setwd("roxutTestPkg")
td <- tempdir()
tst_dir <- paste(td, "unit_tests", "roxutTestPkg", sep = "/")
dir.create(tst_dir, recursive = TRUE)
system2("cp", paste0("-r . ", tst_dir))
setwd(tst_dir)
roxygenize(roclets = "tests_roclet")
system2("cp", "-r . ~/Desktop/tempdir2") # good for troubleshooting DEACTIVATE FOR CRAN

# Step 1. Get the file names
tinytest_files <- list.files("inst/tinytest", "test-.*\\.R", full.names = TRUE)
testthat_files <- list.files("tests/testthat", "test-.*\\.R", full.names = TRUE)
if (length(tinytest_files) != length(testthat_files)) stop("Did not find equal numbers of files")
nf <- length(tinytest_files)

# Step 2. Compare the file contents from each testing framework
for (i in 1:nf) {
  tmp1 <- readLines(tinytest_files[i])[-c(2:5)]
  tmp2 <- readLines(testthat_files[i])[-c(2:5)]
  expect_equivalent(tmp1, tmp2)
}
