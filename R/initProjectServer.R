#' Server for initProject Addin
#'
#' @param input   standard \code{shiny} input
#' @param output  standard \code{shiny} output
#' @param session standard \code{shiny} session
#'
#' @noRd
#' 
#' @importFrom shiny observeEvent showModal modalDialog callModule stopApp modalButton
#' @importFrom htmltools tags
#' @importFrom usethis use_readme_md
#'
initProjectServer <- function(input, output, session) {
  
  # Help modal
  observeEvent(input$help, {
    showModal(modalDialog(
      title = NULL,
      easyClose = TRUE, 
      fade = FALSE,
      size = "m", 
      footer = tags$p(
        tags$a(
          tags$img(src = "addinit/logo.png", align = "left", style="width:13%"),
          href = "https://www.dreamrs.fr/"
        ), 
        modalButton("Cancel")
      ),
      helpAddinit()
    ))
  })
  
  trigger_new_dirs <- reactiveValues(x = Sys.time())
  observeEvent(update_folders_project$x, {
    trigger_new_dirs$x <- Sys.time()
  })
  observeEvent(update_folders_shiny$x, {
    trigger_new_dirs$x <- Sys.time()
  })
  
  # Project ----
  
  callModule(
    module = createFoldersServer,
    id = "project"
  ) -> update_folders_project
  
  callModule(
    module = createScriptsProjectServer, 
    id = "project-scripts", 
    trigger = trigger_new_dirs
  )
  
  toggleInputServer(
    session = session, 
    inputId = "add_readme", 
    enable = !file.exists("README.md")
  )
  observeEvent(input$add_readme, usethis::use_readme_md())
  
  
  # App ----
  
  callModule(
    module = createFoldersServer,
    id = "application"
  ) -> update_folders_shiny
  
  
  callModule(
    module = createScriptsAppServer, 
    id = "apps-scripts", 
    trigger = trigger_new_dirs
  )
  
  # close app ----
  observeEvent(input$close, stopApp())
}
