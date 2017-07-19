#' Ui for initProject Addin
#'
#' @noRd
#' 
#' @import shiny miniUI
#' @importFrom shinyWidgets pickerInput awesomeCheckbox materialSwitch awesomeRadio
#'
initProjectUI <- function(params) {
  
  miniUI::miniPage(
    # CSS
    tags$link(rel="stylesheet", type="text/css", href="addinit/addinit.css"),
    
    # header
    tags$div(
      class = "gadget-title addInit-header",
      tags$div("Init Project", class = "addInit-title"),
      tags$div(
        class = "pull-left",
        miniTitleBarButton(inputId = "help", label = "Help")
      ),
      tags$div(
        class = "pull-right",
        miniTitleBarButton(inputId = "cancel", label = "Cancel")
      )
    ),
    
    toggleInputUi(),
    
    # tabs
    miniUI::miniTabstripPanel(
      id = "tabs",
      
      # tab organize project ----
      miniUI::miniTabPanel(
        title = "Organize your project",
        value = "project",
        icon = icon("folder"),
        miniUI::miniContentPanel(
          
          
          createFoldersUi(id = "project", params = params$project, title = "Create folders")
          
          , br(),
          
          createScriptsProjectUI(
            id = "project-scripts", 
            params = params$project, 
            author  = getOption(x = "addinit.author", default = params$author)
          )
          
        )
      ),
      
      # tab organize shiny app ----
      miniUI::miniTabPanel(
        title = "Organize your Shiny app",
        value = "application",
        icon = icon("cubes"),
        miniUI::miniContentPanel(
          
          
          createFoldersUi(id = "application", params = params$application, title = "Create folders")
          
          , br(),
          
          createScriptsAppUI(
            id = "apps-scripts", 
            params = params$application, 
            author  = getOption(x = "addinit.author", default = params$author)
          )
          
        )
      )
    )
    
  )
  
}

