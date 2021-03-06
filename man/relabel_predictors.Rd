% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/relabel_predictors.R
\name{relabel_predictors}
\alias{relabel_predictors}
\title{Relabel the Predictors in a Tidy Data Frame of Regression Results}
\usage{
relabel_predictors(x, replace = NULL)
}
\arguments{
\item{x}{Either a plot generated by \code{\link[dotwhisker]{dwplot}} or a tidy data.frame to be passed to \code{\link[dotwhisker]{dwplot}}}

\item{replace}{A named character vector, with new values as values, and old values as names}
}
\value{
The function returns a tidy data.frame.
}
\description{
\code{relabel_predictors} is a convenience function for relabeling the predictors in a tidy data.frame to be passed to \code{\link[dotwhisker]{dwplot}}
}
\examples{
library(broom)
library(dplyr)

data(mtcars)
m1 <- lm(mpg ~ wt + cyl + disp, data = mtcars)
m1_df <- broom::tidy(m1) \%>\%
         relabel_predictors(c("(Intercept)" = "Intercept",
                              wt = "Weight",
                              cyl = "Cylinder",
                              disp = "Displacement"))
dwplot(m1_df)

dwplot(m1, show_intercept = TRUE) \%>\%
    relabel_predictors(c("(Intercept)" = "Intercept",
                              wt = "Weight",
                              cyl = "Cylinder",
                              disp = "Displacement"))


}
