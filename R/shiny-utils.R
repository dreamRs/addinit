
# Utils Shiny ----


#' Tggle Input UI
#'
#'
#' @return a character
#' @noRd
#'

toggleInputUi <- function() {
  
  tags$script(
    "Shiny.addCustomMessageHandler('toggleInput',
   function(data) {
     $('#' + data.id).prop('disabled', !data.enable);
     if (data.picker) {
       $('#' + data.id).selectpicker('refresh');
     }
   }
);"
  )
  
}


#'  Toggle Input Server
#'
#' @param session shiny session
#' @param inputId shiny input id
#' @enable enable
#' @picker picker 
#'
#' @return a logical
#' @noRd
#'
#'

toggleInputServer <- function(session, inputId, enable = TRUE, picker = FALSE) {
  session$sendCustomMessage(
    type = 'toggleInput',
    message = list(id = inputId, enable = enable, picker = picker)
  )
}



