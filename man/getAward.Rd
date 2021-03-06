% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/awards.R
\name{getAward}
\alias{getAward}
\title{Get Award}
\usage{
getAward(award = NULL)
}
\arguments{
\item{award}{Optional, award ID to get specific award information. Notable awards include Stanley Cup = 1, Conn smythe = 7, Vezina = 18.}
}
\value{
The API output of awards
}
\description{
Get the NHL awards, including historical awards. Or, get one single award
}
\examples{
#See the list of all awards
awards <- getAward()

#Only get stanley Cup info
stanleycup <- getAward(award = 1)
}
