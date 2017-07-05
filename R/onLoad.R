#' Adds the content of www to addinCron/
#'
#' @import shiny
#'
#' @noRd
#'

.onLoad <- function(...) {
  addResourcePath('addinit', system.file('www', package='addinit'))
}
