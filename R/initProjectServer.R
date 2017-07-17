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
      title = "Help",
      "Put help here"
    ))
  })
  
  # Project ----
  
  update_folders_project <- callModule(module = createFoldersServer, id = "project")
  
  observeEvent(input$config_script == TRUE, {
    toggleInputServer(session = session, inputId = "script_title", enable = !input$config_script)
  })
  
  observeEvent(update_folders_project$x, {
    shinyWidgets::updatePickerInput(session = session, inputId = "path",
                                     choices = c(".", list_dirs(recursive = FALSE)), 
                                     selected = ".")
  })
  
  
  
  observeEvent(input$script_create, {
    
    if (input$config_script){
      tryAlert(
        expr = create_config(
          author = input$author, 
          packages = input$packages,
          config = input$config, 
          funs = input$source_funs,
          path = input$config_path
        ), 
        success_text = "Script successfully created !",
        error_text = "Ooops... Something went wrong"
      )
    } else {
      tryAlert(
        create_script(path = input$path, 
                      name = input$script_name, 
                      author = input$author, 
                      title = input$script_title,
                      packages = input$packages), 
        success_text = "Script successfully created !",
        error_text = "Ooops... Something went wrong"
      )
    }
    
  })
  
  
  
  
  # App ----
  
  update_folders_shiny <- callModule(module = createFoldersServer, id = "application")
  
  observeEvent(input$basic_shiny_script == TRUE, {
    toggleInputServer(session = session, inputId = "script_title_shiny", enable = !input$basic_shiny_script)
    toggleInputServer(session = session, inputId = "path_shiny", enable = !input$basic_shiny_script)
    toggleInputServer(session = session, inputId = "script_name_shiny", enable = !input$basic_shiny_script)
  })
  
  observeEvent(update_folders_shiny$x, {
    shinyWidgets::updatePickerInput(session = session, inputId = "path_shiny",
                                    choices = c(".", list_dirs(recursive = FALSE)),
                                    selected = ".")
  })
  
  observeEvent(input$script_create_shiny, {
    
    if (input$basic_shiny_script){
      tryAlert(
        expr = create_shiny_script(
          type = input$type_shiny_app,
          author = input$author_shiny, 
          packages = input$packages_shiny
        ), 
        success_text = "Script successfully created !",
        error_text = "Ooops... Something went wrong"
      )
    } else {
      
      tryAlert(
        create_script(path = input$path_other_shiny, 
                      name = input$script_name_shiny, 
                      author = input$author_shiny, 
                      title = input$script_title_shiny,
                      packages = input$packages_shiny), 
        success_text = "Script successfully created !",
        error_text = "Ooops... Something went wrong"
      )
    }
   
  })

  

}
