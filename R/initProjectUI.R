#' Ui for initProject Addin
#'
#' @noRd
#' 
#' @importFrom miniUI miniPage miniTitleBarButton miniTabstripPanel miniTabPanel miniContentPanel
#' @importFrom shiny icon
#' @importFrom htmltools tags
#'
initProjectUI <- function(params) {
  
  miniPage(
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

