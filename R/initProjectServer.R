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
  
  # Project ----
  
  update_folders_project <- callModule(module = createFoldersServer, id = "project")
  
  
  observeEvent(update_folders_project$x, {
    shinyWidgets::updatePickerInput(session = session, inputId = "config_path",
                                     choices = c(".", list_dirs(recursive = FALSE)), 
                                     selected = ".")
    shinyWidgets::updatePickerInput(session = session, inputId = "path_other",
                                     choices = c(".", list_dirs(recursive = FALSE)), 
                                     selected = ".")
  })
  
  
  observeEvent(input$config_create, {
    
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
  })
  
  observeEvent(input$script_create, {
    
    tryAlert(
      create_script(path = input$path_other, 
                    name = input$script_name, 
                    author = input$author, 
                    title = input$script_title), 
      success_text = "Script successfully created !",
      error_text = "Ooops... Something went wrong"
    )
    
  })
  
  # App ----
  
  update_folders_shiny <- callModule(module = createFoldersServer, id = "application")
  
  observeEvent(update_folders_shiny$x, {
    # shinyWidgets::updatePickerInput(session = session, inputId = "config_path_shiny",
    #                                 choices = c(".", list_dirs(recursive = FALSE)), 
    #                                 selected = ".")
    shinyWidgets::updatePickerInput(session = session, inputId = "path_other_shiny",
                                    choices = c(".", list_dirs(recursive = FALSE)),
                                    selected = ".")
  })
  
  observeEvent(input$config_create_shiny, {
    
    tryAlert(
      expr = create_shiny_script(
        ui = input$ui,
        server = input$server,
        global = input$global,
        author = input$author, 
        packages = input$packages
      ), 
      success_text = "Script successfully created !",
      error_text = "Ooops... Something went wrong"
    )
  })
  
  observeEvent(input$script_create_shiny, {
    
    tryAlert(
      create_script(path = input$path_other_shiny, 
                    name = input$script_name_shiny, 
                    author = input$author_shiny, 
                    title = input$script_title_shiny), 
      success_text = "Script successfully created !",
      error_text = "Ooops... Something went wrong"
    )
    
  })
  

}
