% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/valid.R
\name{valid}
\alias{valid}
\alias{st_is_valid}
\alias{valid}
\alias{st_make_valid}
\title{Validity operations on simple feature geometries}
\usage{
st_is_valid(x, NA_on_exception = TRUE, reason = FALSE)

st_make_valid(x)
}
\arguments{
\item{x}{object of class \code{sfg}, \code{sfg} or \code{sf}}

\item{NA_on_exception}{logical; if TRUE, for polygons that would otherwise raise an GEOS error (exception, e.g. for a POLYGON having more than zero but less than 4 points, or a LINESTRING having one point) return an \code{NA} rather than raising an error, and suppress warning messages (e.g. about self-intersection); if FALSE, regular GEOS errors and warnings will be emitted.}

\item{reason}{logical; if \code{TRUE}, return a character with, for each geometry, the reason for invalidity, \code{NA} on exception, or \code{"Valid Geometry"} otherwise.}
}
\value{
matrix (sparse or dense); if dense: of type \code{character} for \code{relate}, \code{numeric} for \code{distance}, and \code{logical} for all others; matrix has dimension \code{x} by \code{y}; if sparse (only possible for those who return logical in case of dense): return list of length length(x) with indices of the TRUE values for matching \code{y}.

object of the same class as \code{x}
}
\description{
Check validity on simple feature geometries, or make geometries valid
}
\details{
\code{st_make_valid} uses the \code{lwgeom_makevalid} method also used by the PostGIS command \code{ST_makevalid}. It is only available if the package was linked against liblwgeom, which is currently not the case for the binary CRAN distributions; see the package source code repository for instructions how to install liblwgeom. The example below shows how to run-time check the availability of liblwgeom.
}
\examples{
p1 = st_as_sfc("POLYGON((0 0, 0 10, 10 0, 10 10, 0 0))")
st_is_valid(p1)
st_is_valid(st_sfc(st_point(0:1), p1[[1]]), reason = TRUE)
x = st_sfc(st_polygon(list(rbind(c(0,0),c(0.5,0),c(0.5,0.5),c(0.5,0),c(1,0),c(1,1),c(0,1),c(0,0)))))
if (!is.na(sf_extSoftVersion()["lwgeom"])) {
  suppressWarnings(st_is_valid(x))
  y = st_make_valid(x)
  st_is_valid(y)
  y \%>\% st_cast()
}
}
