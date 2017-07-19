#' Server for initProject Addin
#'
#' @param input   standard \code{shiny} input
#' @param output  standard \code{shiny} output
#' @param session standard \code{shiny} session
#'
#' @noRd
#'

initProjectServer <- function(input, output, session) {
  
  # Help modal
  observeEvent(input$help, {
    shiny::showModal(shiny::modalDialog(
      title = NULL, easyClose = TRUE, size = "m",
      helpAddinit()
    ))
  })
  
  
  
  # Project ----
  
  callModule(
    module = createFoldersServer,
    id = "project"
  ) -> update_folders_project
  
  callModule(
    module = createScriptsProjectServer, 
    id = "project-scripts", 
    trigger = update_folders_project
  )
  
  
  
  
  # App ----
  
  callModule(
    module = createFoldersServer,
    id = "application"
  ) -> update_folders_shiny
  
  
  callModule(
    module = createScriptsAppServer, 
    id = "apps-scripts", 
    trigger = update_folders_shiny
  )

  

  
  # close app ----
  observeEvent(input$cancel, stopApp())
}
