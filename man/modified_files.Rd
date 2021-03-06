% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/deprec-files.R
\name{modified_files}
\alias{modified_files}
\title{(Deprecated) Get a list of modified files in a repo}
\usage{
modified_files(path = getwd())
}
\arguments{
\item{path}{path to local repo}
}
\value{
The complete git status message and modified files are printed in the console, and a vector of the modified filenames is invisibly returned.
}
\description{
(Deprecated) This function takes the git status message and isolates the files that have been modified according to that message.
}
\keyword{internal}
