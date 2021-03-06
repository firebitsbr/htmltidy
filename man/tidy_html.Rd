% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/response.r, R/tidy.r
\name{tidy_html.response}
\alias{tidy_html.response}
\alias{tidy_html}
\alias{tidy_html.default}
\alias{tidy_html.character}
\alias{tidy_html.raw}
\alias{tidy_html.xml_document}
\alias{tidy_html.HTMLInternalDocument}
\alias{tidy_html.connection}
\title{Tidy or "Pretty Print" HTML/XHTML Documents}
\usage{
\method{tidy_html}{response}(content, options = list(TidyXhtmlOut = TRUE),
  verbose = FALSE)

tidy_html(content, options = list(TidyXhtmlOut = TRUE), verbose = FALSE)

\method{tidy_html}{default}(content, options = list(TidyXhtmlOut = TRUE),
  verbose = FALSE)

\method{tidy_html}{character}(content, options = list(TidyXhtmlOut = TRUE),
  verbose = FALSE)

\method{tidy_html}{raw}(content, options = list(TidyXhtmlOut = TRUE),
  verbose = FALSE)

\method{tidy_html}{xml_document}(content, options = list(TidyXhtmlOut = TRUE),
  verbose = FALSE)

\method{tidy_html}{HTMLInternalDocument}(content, options = list(TidyXhtmlOut
  = TRUE), verbose = FALSE)

\method{tidy_html}{connection}(content, options = list(TidyXhtmlOut = TRUE),
  verbose = FALSE)
}
\arguments{
\item{content}{accepts a character vector, raw vector or parsed content from the \code{xml2}
or \code{XML} packages.}

\item{options}{named list of options}

\item{verbose}{output document errors? (default: \code{FALSE})}
}
\value{
Tidied HTML/XHTML content. The object type will be the same as that of the input type
        except when it is a \code{connection}, then a character vector will be returned.
}
\description{
Pass in HTML content as either plain or raw text or parsed objects (either with the
\code{XML} or \code{xml2} packages) or as an \code{httr} \code{response} object
along with an options list that specifies how the content will be tidied and get back
tidied content of the same object type as passed in to the function.
}
\details{
The default option \code{TixyXhtmlOut} will convert the input content to XHTML.

Currently supported options:

\itemize{
  \item{Ones taking a logical value: }{\code{TidyAltText}, \code{TidyBodyOnly}, \code{TidyBreakBeforeBR},
    \code{TidyCoerceEndTags}, \code{TidyDropEmptyElems}, \code{TidyDropEmptyParas},
    \code{TidyFixBackslash}, \code{TidyFixComments}, \code{TidyGDocClean}, \code{TidyHideComments},
    \code{TidyHtmlOut}, \code{TidyIndentContent}, \code{TidyJoinClasses}, \code{TidyJoinStyles},
    \code{TidyLogicalEmphasis}, \code{TidyMakeBare}, \code{TidyMakeClean}, \code{TidyMark},
    \code{TidyOmitOptionalTags}, \code{TidyReplaceColor}, \code{TidyUpperCaseAttrs},
    \code{TidyUpperCaseTags}, \code{TidyWord2000}, \code{TidyXhtmlOut}}
  \item{Ones taking a character value: }{\code{TidyDoctype}, \code{TidyInlineTags}, \code{TidyBlockTags},
    \code{TidyEmptyTags}, \code{TidyPreTags}}
  \item{Ones taking an integer value: }{\code{TidyIndentSpaces}, \code{TidyTabSize}, \code{TidyWrapLen}}
}

File \href{https://github.com/hrbrmstr/htmltidy/issues}{an issue} if there are other \code{libtidy}
options you'd like supported.

It is likely that the most used options will be:

\itemize{
  \item{\code{TidyXhtmlOut} (logical)},
  \item{\code{TidyHtmlOut} (logical)} and
  \item{\code{TidyDocType} which should be one of "\code{omit}",
    "\code{html5}", "\code{auto}", "\code{strict}" or "\code{loose}"}.
}

You can clean up Microsoft Word (2000) and Google Docs HTML via logical settings for
\code{TidyWord2000} and \code{TidyGDocClean}, respectively.

It may also be advantageous to remove all comments with \code{TidyHideComments}.
}
\note{
If document parsing errors are severe enough, \code{tidy_html()} will not be able
  to clean the document and will display the errors (this output can be captured with
  \code{sink()} or \code{capture.output()}) along with a warning and return a "best effort"
  cleaned version of the document.
}
\examples{
opts <- list(
  TidyDocType="html5",
  TidyMakeClean=TRUE,
  TidyHideComments=TRUE,
  TidyIndentContent=TRUE,
  TidyWrapLen=200
)

txt <- paste0(
  c("<html><head><style>p { color: red; }</style><body><!-- ===== body ====== -->",
"<p>Test</p></body><!--Default Zone --> <!--Default Zone End--></html>"),
  collapse="")

cat(tidy_html(txt, option=opts))

\dontrun{
library(httr)
res <- GET("https://rud.is/test/untidy.html")

# look at the original, un-tidy source
cat(content(res, as="text", encoding="UTF-8"))

# see the tidied version
cat(tidy_html(content(res, as="text", encoding="UTF-8"),
              list(TidyDocType="html5", TidyWrapLen=200)))

# but, you could also just do:
cat(tidy_html(url("https://rud.is/test/untidy.html")))
}
}
\references{
\url{http://api.html-tidy.org/tidy/quickref_5.1.25.html} &
  \url{https://github.com/htacg/tidy-html5/blob/master/include/tidyenum.h}
 for definitions of the options supported above and \url{https://www.w3.org/People/Raggett/tidy/}
 for an explanation of what "tidy" HTML is and some canonical examples of what it can do.
}
