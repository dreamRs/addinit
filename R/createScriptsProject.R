#' Module for creating script(s) in the project tab
#' 
#' UI part
#'
#' @param id Module's id
#' @param params List of addinit options.
#' @param author Who should be credited as the author of the scripts ?
#'
#' @noRd
#' @importFrom shinyWidgets pickerInput awesomeCheckbox materialSwitch textInputIcon
#' @importFrom htmltools tags tagList
#' @importFrom shiny NS fluidRow column conditionalPanel actionButton
#' @importFrom phosphoricons ph
createScriptsProjectUI <- function(id, params, author = NULL) {
  
  # Namespace
  ns <- NS(id)
  
  tagList(
    tags$hr(class = "addinit-hr"),
    tags$h4("Create scripts", class = "addinit-h4"),
    tags$hr(class = "addinit-hr"),
    tags$br(),
    fluidRow(
      column(
        width = 6,
        pickerInput(
          inputId = ns("path"), label = "Where :", 
          choices = c(". (root)" = ".", list_dirs(recursive = FALSE)),
          selected = ".",
          options = list(size = 5),
          width = "100%"
        )
      ),
      column(
        width = 6,
        tags$div(
          class = "form-group",
          style = "float:right; width: 100%;margin-bottom:3px",
          textInputIcon(
            inputId = ns("script_name"), 
            label = "Script's name :",
            value = "",
            placeholder = "00_init_project", 
            icon = list(NULL, ".R"),
            width = "100%"
          )
        )
      )
    ),
    fluidRow(
      column(
        width = 3,
        tags$div(
          class = "form-group",
          style = "float:right; width: 100%;margin-bottom:3px; ",
          textInputIcon(
            inputId = ns("author"), 
            label = "Author:",
            value = author,
            placeholder = "Fanny", 
            icon = ph("user"),
            width = "100%"
          )
        )
      ),
      column(
        width = 3,
        tags$div(
          class = "form-group",
          style = "float:right; width: 100%; margin-bottom:3px; ",
          textInputIcon(
            inputId = ns("script_title"), 
            label = "Title:",
            value = "",
            placeholder = "My awesome analysis", 
            icon = ph("text-t"),
            width = "100%"
          )
        )
      ),
      column(
        width = 6,
        pickerInput(
          inputId = ns("packages"), 
          label = "Packages to load :",
          choices = params$packages$default,
          multiple = TRUE,
          width = "100%",
          options = list(
            `live-search` = TRUE, 
            size = 10, 
            `selected-text-format` = "count > 3", 
            `count-selected-text` = "{0} packages", 
            `dropup-auto` = TRUE
          ),
          selected = params$packages$selected
        )
      )
    ),
    actionButton(
      inputId = ns("script_create"),
      label = tagList(ph("code"), "Create script"), 
      class = "btn-primary pull-right"
    )
  )
}




#' Module for creating script(s) in the project tab
#' 
#' Server part
#'
#' @param input   standard \code{shiny} input
#' @param output  standard \code{shiny} output
#' @param session standard \code{shiny} session
#' @param trigger ReactiveValues to trigger update of folders
#' 
#' @importFrom shiny observeEvent
#' @importFrom shinyWidgets updatePickerInput
#'
#' @noRd
createScriptsProjectServer <- function(input, output, session, trigger) {
  
  ns <- session$ns

  
  observeEvent(trigger$x, {
    updatePickerInput(
      session = session, 
      inputId = "path",
      choices = c(".", list_dirs(recursive = FALSE)), 
      selected = "."
    )
  })
  
  
  
  observeEvent(input$script_create, {
    
    tryAlert(
      expr = create_script(
        path = input$path, 
        name = input$script_name, 
        author = input$author, 
        title = input$script_title,
        packages = input$packages
      ), 
      success_text = "Script successfully created !",
      error_text = "Ooops... Something went wrong"
    )
    
  })
  
}



