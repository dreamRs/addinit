#' Server for initProject Addin
#'
#' @param input 
#' @param output 
#' @param server 
#'
#' @noRd
#'

initProjectServer <- function(input, output, session) {
  
  # Help modal
  observeEvent(input$help, {
    shiny::showModal(shiny::modalDialog(
      title = "Help",
      "Put help here"
    ))
  })
  
  
  
  update_folders_project <- callModule(module = createFoldersServer, id = "project")
  
  
  observeEvent(update_folders_project$x, {
    shinyWidgets::updateAwesomeRadio(session = session, inputId = "config_path",
                                     choices = c(".", list_dirs(recursive = FALSE)), 
                                     selected = ".", inline = TRUE, status = "warning")
    shinyWidgets::updateAwesomeRadio(session = session, inputId = "path_other",
                                     choices = c(".", list_dirs(recursive = FALSE)), 
                                     selected = ".", inline = TRUE, status = "warning")
  })
  
  
  observeEvent(input$config_create, {
    create_config(author = input$author, packages = input$packages, config = input$config, funs = input$source_funs, path = input$config_path)
    shiny::showNotification(ui = "Config script created !", type = "message")
  })
  
  observeEvent(input$script_create, {
    create_script(path = input$path_other, name = input$script_name, author = input$author, title = input$script_title)
    shiny::showNotification(ui = "Script created !", type = "message")
  })
}
