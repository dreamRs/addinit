#' Evaluate an expression and send notification to UI
#'
#' @param expr Expression to evaluate
#' @param success_text The success message to display
#' @param error_text The error message to display
#'
#' @noRd
tryAlert <- function(expr, success_text = "", error_text = "") {
  tryCatch(
    {
      res <- eval(substitute(expr), envir = parent.frame())
      shiny::showNotification(ui = success_text, type = "message")
      res
    }, error = function(e) {
      shiny::showNotification(ui = error_text, type = "error")
      e
    }
  )
}






