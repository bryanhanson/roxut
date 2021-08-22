# roxut 0.4.0 2021-08-22

## Bugs
* The unit test files were missing a comment marker on Windows (in spite of passing all tests on Win-Builder; reported by Vilmantas Gegzna).

## Improvements
* Much more robust unit tests were added. See `tests_roclet.R`.
* Unit test files now have a line giving the location of the unit test in the original file.  Helpful if a `*.R` file contains more than one function with unit tests.  Suggested with initial code by Claudia Beleites (was actually added in the previous version).

# roxut 0.3.23 2021-08-15

## Bugs
* Fixed a problem where the unit test files were overwritten if there was more than one function and hence more than one set of unit tests in a single file.  Reported with a suggested fix by Claudia Beleites.

# roxut 0.2.40 2021-04-26

## Miscellaneous
* Built and checked against R 4.1 RC.
* Improved internal testing (`roxutTstPkg`).

# roxut 0.2.23 2020-07-04

## Miscellaneous
* First Release!
