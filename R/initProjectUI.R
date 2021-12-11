#' Ui for initProject Addin
#'
#' @noRd
#' 
#' @importFrom miniUI miniPage miniTabstripPanel miniTabPanel miniContentPanel
#' @importFrom shiny actionButton
#' @importFrom htmltools tags
#' @importFrom phosphoricons ph ph_i html_dependency_phosphor
initProjectUI <- function(params) {
  
  miniPage(
    # CSS
    tags$link(rel="stylesheet", type="text/css", href="addinit/addinit.css"),
    html_dependency_phosphor(),
    
    # header
    tags$div(
      class = "gadget-title addinit-title-container",
      tags$div(ph("lightbulb"), "Initiate a project", class = "addinit-title"),
      tags$div(
        class = "pull-left",
        actionButton(
          inputId = "help",
          label = ph("question"),
          title = "Help"
        )
      ),
      tags$div(
        class = "pull-right",
        actionButton(
          inputId = "close",
          label = ph("x", title = "Close Window"),
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
        icon = ph_i("folder"),
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
            label = tagList(ph("file"), "Add README"), 
            class = "btn-primary"
          )
        )
      ),
      
      # tab organize shiny app ----
      miniTabPanel(
        title = "Organize your Shiny app",
        value = "application",
        icon = ph_i("app-window"),
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

