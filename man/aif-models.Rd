% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/aif.R
\name{aif-models}
\alias{aif-models}
\alias{aif.orton.exp}
\alias{model.orton.exp}
\alias{orton.exp.lm}
\title{Arterial Input Functions}
\usage{
aif.orton.exp(tt, AB, muB, AG, muG)

orton.exp.lm(tt, aif, guess = c(log(100), log(10), log(1), log(0.1)),
  nprint = 0)

model.orton.exp(tt, aparams, kparams)
}
\arguments{
\item{tt}{is a vector of acquisition times (in minutes) relative to
injection of the contrast agent.  Negative values should be used prior to
the injection.}

\item{AB,muB,AG,muG}{are parameters of the double exponential function that
describe the AIF.}

\item{aif}{is the vector of observed contrast agent concentrations (data)
used to estimate the parametric model.}

\item{guess}{Initial parameter values for the nonlinear optimization.}

\item{nprint}{is an integer, that enables controlled printing of iterates if
it is positive.  In this case, estimates of \code{par} are printed at the
beginning of the first iteration and every \code{nprint} iterations
thereafter and immediately prior to return.  If \code{nprint} is not
positive, no tracing information on the progress of the optimization is
produced.}

\item{aparams}{is the vector of parameters (\eqn{A_B}, \eqn{\mu_B},
\eqn{A_G}, \eqn{\mu_G}) associated with the AIF.}

\item{kparams}{is the vector of parameters (\eqn{v_p}, \eqn{K^{trans}},
\eqn{k_{ep}}) associated with the \dQuote{extended Kety model} for contrast
agent concentration.}
}
\value{
\code{aif.orton.exp} and \code{model.orton.exp} return the AIF
associated with the pre-specified parameter values.

\code{orton.exp.lm} returns a list structure with \item{AB}{The amplitude of
the first exponential function.} \item{muB}{The decay rate of the first
exponential function.} \item{AG}{The amplitude of the second exponential
function.} \item{muG}{The decay rate of the second exponential function.}
\item{info}{The success (or failure) code from the Levenburg-Marquardt
algorithm \code{nls.lm}.} \item{message}{The text message associated with
the \code{info} paramters.}
}
\description{
Parametric models for arterial input functions (AIFs) that are compatible
with single compartment models for dynamic contrast-enhanced MRI (DCE-MRI).
}
\details{
\code{aif.orton.exp} displays the exponential AIF from Orton \emph{et al.}
(2008) for a known set of AIF parameter values.  \code{model.orton.exp}
displays the exponential AIF from Orton \emph{et al.} (2008) for a known set
of AIF and compartmental model parameter values.  \code{orton.exp.lm}
estimates the AIF parameters, using nonlinear optimization, using a vector
of observed contrast agent concentrations.
}
\examples{
data("buckley")
## Generate AIF params using the orton.exp function from Buckley's AIF
xi <- seq(5, 300, by=5)
time <- buckley$time.min[xi]
aif <- buckley$input[xi]
aifparams <- orton.exp.lm(time, aif)
aifparams$D <- 1
unlist(aifparams[1:4])

aoe <- aif.orton.exp(time, aifparams$AB, aifparams$muB, aifparams$AG,
                     aifparams$muG)
with(buckley, plot(time.min, input, type="l", lwd=2))
lines(time, aoe, lwd=2, col=2)
legend("right", c("Buckley's AIF", "Our approximation"), lty=1,
       lwd=2, col=1:2)
cbind(time, aif, aoe)[1:10,]
}
\author{
Brandon Whitcher \email{bwhitcher@gmail.com}
}
\references{
Orton, M.R., Collins, D.J., Walker-Samuel, S., d'Arcy, J.A.,
Hawkes, D.J., Atkinson, D. and Leach, M.O. (2007) Bayesian estimation of
pharmacokinetic parameters for DCE-MRI with a robust treatment of
enhancement onset time, \emph{Physics in Medicine and Biology} \bold{52},
2393-2408.

Orton, M.R., d'Arcy, J.A., Walker-Samuel, S., Hawkes, D.J., Atkinson, D.,
Collins, D.J. and Leach, M.O. (2008) Computationally efficient vascular
input function models for quantitative kinetic modelling using DCE-MRI,
\emph{Physics in Medicine and Biology} \bold{53}, 1225-1239.
}
\seealso{
\code{\link{dcemri.lm}}, \code{\link{extractAIF}},
\code{\link[minpack.lm]{nls.lm}}
}
\keyword{models}

