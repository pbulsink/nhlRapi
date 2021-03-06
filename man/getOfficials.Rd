% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/officials.R
\name{getOfficials}
\alias{getOfficials}
\title{Get Officials}
\usage{
getOfficials(active = FALSE)
}
\arguments{
\item{active}{Whether to limit to active officials only. Optional, default False}
}
\value{
Officials information
}
\description{
Get Officials
}
\examples{
#Get all past officials
officials <- getOfficials()

#To pull only active officials:
officials_active <- getOfficials(active = TRUE)
}
