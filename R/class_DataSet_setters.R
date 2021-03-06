#' @include utils_sharedGenerics.R classUnions.R
NULL

#' @rdname DataSet
#' 
#' @param keepNA \code{logical}, TRUE to keep NA values.
#' 
#' @examples
#' setDataProvider(.Object = dataSet(), data.frame(key = c("FR", "US"), value = c(20,10)))
#' 
setMethod(f = "setDataProvider", signature = c("DataSet", "ANY"),
          definition = function(.Object, dataProvider, keepNA = TRUE)
          {
            .Object@dataProvider <- .toList(.testFormatData(dataProvider), keepNA)
            validObject(.Object)
            return(.Object)
          })

# > @fieldMapping : setters ####

#' @rdname DataSet
#' @export
setGeneric(name = "setFieldMappings", def = function(.Object, fieldMappings) {standardGeneric("setFieldMappings")})
#' @examples
#' dataset <- addFieldMapping(.Object = dataSet(),
#'                            fieldMappings = list(fromField ="val1", toField ="value"))
#' print(dataset)
#' @rdname DataSet
setMethod(f = "setFieldMappings", signature = c("DataSet", "list"),
          definition = function(.Object, fieldMappings)
          {
            .Object@fieldMappings <- fieldMappings
            validObject(.Object)
            return(.Object)
          })

#' @rdname DataSet
#' @export
setGeneric(name = "addFieldMapping", def = function(.Object, ...) {standardGeneric("addFieldMapping")})
#' @examples
#' dataset <- addFieldMapping(.Object = dataSet(), fromField ="val1", toField ="value")
#' print(dataset)
#' @rdname DataSet
setMethod(f = "addFieldMapping", signature = c("DataSet"),
          definition = function(.Object, ...)
          {
            .Object@fieldMappings <- c(.Object@fieldMappings, list(list(...)))
            validObject(.Object)
            return(.Object)
          })

# > @stockEvents : setters ####

#' @rdname DataSet
#' @export
setGeneric(name = "setStockEvents", def = function(.Object, stockEvents) {standardGeneric("setStockEvents")})
#' @rdname DataSet
setMethod(f = "setStockEvents", signature = c("DataSet", "list"),
          definition = function(.Object, stockEvents)
          {
            rightClassElements <- all(sapply(stockEvents, function(element) {is(element, "StockEvent")}))
            if (!rightClassElements) {
              stop("Each element of setStockEvents must be of class StockEvent")
            } else {}
            .Object@stockEvents <- lapply(stockEvents, listProperties)
            validObject(.Object)
            return(.Object)
          })

#' @param stockEvent \linkS4class{StockEvent}.
#' Argument for method \code{addStockEvent}.
#' @examples
#' addStockEvent(.Object = dataSet(), backgroundAlpha = 1, backgroundColor = "#DADADA")
#' # equivalent to:
#' stockEvent_obj <- stockEvent(backgroundAlpha = 1, backgroundColor = "#DADADA")
#' chart <- addStockEvent(.Object = dataSet(), stockEvent = stockEvent_obj); print(chart)
#' @rdname DataSet
#' @export
setGeneric(name = "addStockEvent", def = function(.Object, stockEvent = NULL, ...) {standardGeneric("addStockEvent")})
#' @rdname DataSet
setMethod(f = "addStockEvent", signature = c("DataSet", "StockEventOrMissing"),
          definition = function(.Object, stockEvent = NULL, ...)
          {
            if (is.null(stockEvent) && !missing(...)) {
              stockEvent <- stockEvent(...)
            } else if (is.null(stockEvent) && missing(...)) {
              stop("You must provide either argument 'stockEvent' or its properties")
            } else {}
            
            .Object@stockEvents <- c(.Object@stockEvents, list(listProperties(stockEvent)))
            validObject(.Object)
            return(.Object)
          })
