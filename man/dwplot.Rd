% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dwplot.R
\name{dwplot}
\alias{dwplot}
\title{Dot-and-Whisker Plots of Regression Results}
\usage{
dwplot(x, alpha = 0.05, dodge_size = 0.15, order_vars = NULL,
  show_intercept = FALSE, model_name = "model", dot_args = NULL,
  whisker_args = NULL, ...)
}
\arguments{
\item{x}{Either a tidy data.frame (see 'Details'), a model object to be tidied with \code{\link[broom]{tidy}}, or a list of such model objects.}

\item{alpha}{A number setting the criterion of the confidence intervals. The default value is .05, corresponding to 95-percent confidence intervals.}

\item{dodge_size}{A number (typically between 0 and 0.3) indicating how much vertical separation should be between different models' coefficients when multiple models are graphed in a single plot.  Lower values tend to look better when the number of independent variables is small, while a higher value may be helpful when many models appear on the same plot.}

\item{order_vars}{A vector of variable names that specifies the order in which the variables are to appear along the y-axis of the plot.}

\item{show_intercept}{A logical constant indicating whether the coefficient of the intercept term should be plotted.}

\item{model_name}{The name of a variable that distinguishes separate models within a tidy data.frame.}

\item{dot_args}{A list of arguments specifying the appearance of the dots representing mean estimates.  For supported arguments, see \code{\link{geom_point}}.}

\item{whisker_args}{A list of arguments specifying the appearance of the whiskers representing confidence intervals.  For supported arguments, see \code{\link{geom_segment}}.}

\item{\dots}{Extra arguments to pass to \code{\link[broom]{tidy}}.}
}
\value{
The function returns a \code{ggplot} object.
}
\description{
\code{dwplot} is a function for quickly and easily generating dot-and-whisker plots of regression models saved in tidy data frames.
}
\details{
\code{dwplot} visualizes regression results saved in tidy data.frames by, e.g., \code{\link[broom]{tidy}} as dot-and-whisker plots generated by \code{\link[ggplot2]{ggplot}}.

Tidy data.frames to be plotted should include the variables \code{term} (names of predictors), \code{estimate} (corresponding estimates of coefficients or other quantities of interest), \code{std.error} (corresponding standard errors), and optionally \code{model} (when multiple models are desired on a single plot; a different name for this last variable may be specified using the model_name argument).
In place of \code{std.error} one may substitute \code{lb} (the lower bounds of the confidence intervals of each estimate) and \code{ub} (the corresponding upper bounds).

For convenience, \code{dwplot} also accepts as input those model objects that can be tidied by \code{\link[broom]{tidy}}, or a list of such model objects.

Because the function takes a data.frame as input, it is easily employed for a wide range of models, including those not supported by \code{\link[broom]{tidy}}.
And because the output is a \code{ggplot} object, it can easily be further customized with any additional arguments and layers supported by \code{ggplot2}.
Together, these two features make \code{dwplot} extremely flexible.
}
\examples{
library(broom)
library(dplyr)

# Plot regression coefficients from a single model object
data(mtcars)
m1 <- lm(mpg ~ wt + cyl + disp, data = mtcars)

dwplot(m1) +
    scale_y_continuous(breaks = 3:1, labels=c("Weight", "Cylinders", "Displacement")) +
    labs(x = "Coefficient", y = "") +
    geom_vline(xintercept = 0, colour = "grey50", linetype = 2) +
    theme(legend.position="none")

# Plot regression coefficients from multiple models on the fly
m2 <- update(m1, . ~ . - disp)
dwplot(list(full = m1, nodisp = m2))

# Change the appearance of dots and whiskers
dwplot(m1, dot_args = list(size = 6, pch = 21, fill = "white"),
     whisker_args = list(lwd = 2))

# Plot regression coefficients from multiple models in a tidy data.frame
by_trans <- mtcars \%>\% group_by(am) \%>\%
    do(tidy(lm(mpg ~ wt + cyl + disp, data = .))) \%>\% rename(model=am)

dwplot(by_trans, dodge_size = .05) +
    scale_y_continuous(breaks = 3:1, labels=c("Weight", "Cylinders", "Displacement")) +
    theme_bw() + labs(x = "Coefficient Estimate", y = "") +
    geom_vline(xintercept = 0, colour = "grey60", linetype = 2) +
    ggtitle("Predicting Gas Mileage, OLS Estimates") +
    theme(plot.title = element_text(face = "bold"),
          legend.justification=c(0, 0), legend.position=c(0, 0),
          legend.background = element_rect(colour="grey80"),
          legend.title.align = .5) +
    scale_colour_grey(start = .4, end = .8,
                      name = "Transmission",
                      breaks = c(0, 1),
                      labels = c("Automatic", "Manual"))

}
\references{
Kastellec, Jonathan P. and Leoni, Eduardo L. 2007. "Using Graphs Instead of Tables in Political Science." Perspectives on Politics, 5(4):755-771.
}
