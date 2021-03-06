% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/roclet_clean.roclet_tests.R
\name{roclet_clean.roclet_tests}
\alias{roclet_clean.roclet_tests}
\title{Delete Unit Test Files Generated by @tests Tags}
\usage{
\method{roclet_clean}{roclet_tests}(x, base_path)
}
\arguments{
\item{x}{A \code{roclet} object.}

\item{base_path}{Path to root of source package.}
}
\value{
NULL  If found, files created by \code{roxut} will be deleted.
}
\description{
Delete unit test files generated by @tests tags. Activated when
calling \code{roxygenize} with \code{clean = TRUE}.
}
\author{
Bryan A. Hanson
}
