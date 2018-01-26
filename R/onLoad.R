#' Adds the content of www to addinCron/
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath('addinit', system.file('www', package='addinit'))
}
