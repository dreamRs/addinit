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
      title = NULL, easyClose = TRUE, size = "m", footer = tags$p(
        tags$a(tags$img(src = "addinit/logo.png", align = "left", style="width:13%"), href = "https://www.dreamrs.fr/"), 
        modalButton("Cancel")),
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
