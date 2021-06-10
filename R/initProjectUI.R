#' Ui for initProject Addin
#'
#' @noRd
#' 
#' @importFrom miniUI miniPage miniTabstripPanel miniTabPanel miniContentPanel
#' @importFrom shiny icon actionButton
#' @importFrom htmltools tags
#'
initProjectUI <- function(params) {
  
  miniPage(
    # CSS
    tags$link(rel="stylesheet", type="text/css", href="addinit/addinit.css"),
    
    # header
    tags$div(
      class = "gadget-title addinit-title-container",
      tags$div(icon("lightbulb-o"), "Initiate a project", class = "addinit-title"),
      tags$div(
        class = "pull-left",
        actionButton(
          inputId = "help",
          label = NULL,
          icon = icon("question", class = "fa-lg"),
          class = "btn-sm",
          title = "Help"
        )
      ),
      tags$div(
        class = "pull-right",
        actionButton(
          inputId = "close",
          label = NULL,
          icon = icon("times", class = "fa-lg"),
          class = "btn-sm",
          title = "Close Window"
        )
      )
    ),
    
    toggleInputUi(),
    
    # tabs
    miniTabstripPanel(
      id = "tabs",
      
      # tab organize project ----
      miniTabPanel(
        title = "Organize your project",
        value = "project",
        icon = icon("folder"),
        miniContentPanel(
          
          createFoldersUi(id = "project", params = params$project, title = "Create folders")
          
          , tags$br(),
          
          createScriptsProjectUI(
            id = "project-scripts", 
            params = params$project, 
            author  = getOption(x = "addinit.author", default = params$author)
          )
          
        ), 
        miniUI::miniButtonBlock(
          actionButton(
            inputId = "add_readme", 
            label = "Add README", 
            class = "btn-primary", 
            icon = icon("file-text")
          )
        )
      ),
      
      # tab organize shiny app ----
      miniTabPanel(
        title = "Organize your Shiny app",
        value = "application",
        icon = icon("cubes"),
        miniContentPanel(
          
          createFoldersUi(id = "application", params = params$application, title = "Create folders")
          
          , tags$br(),
          
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

