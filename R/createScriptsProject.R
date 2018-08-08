#' Module for creating script(s) in the project tab
#' 
#' UI part
#'
#' @param id Module's id
#' @param params List of addinit options.
#' @param author Who should be credited as the author of the scripts ?
#'
#' @noRd
#' @importFrom shinyWidgets pickerInput awesomeCheckbox materialSwitch
#' @importFrom htmltools tags tagList
#' @importFrom shiny NS fluidRow column conditionalPanel actionButton icon
# @import shiny
createScriptsProjectUI <- function(id, params, author = NULL) {
  
  # Namespace
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(
        width = 12,
        tags$hr(class = "addInit-hr"),
        tags$h4("Create scripts", class = "addInit-h4"),
        tags$hr(class = "addInit-hr")
      )
    ),
    tags$br(),
    fluidRow(
      column(
        width = 6,
        pickerInput(
          inputId = ns("path"), label = "Where :", 
          choices = c(". (root)" = ".", list_dirs(recursive = FALSE)), selected = ".",
          options = list(size = 5)
        )
      ),
      column(
        width = 6,
        tags$div(
          class="form-group",
          style="float:right; width: 100%;margin-bottom:3px",
          tags$label("Script's name :"),
          tags$div(
            class="input-group",
            tags$input(
              class = "form-control shiny-bound-input",
              type = "text", id = ns("script_name"), value = "",
              placeholder = "Valid name"
            ),
            tags$span(class="input-group-addon", ".R")
          )
        )
      )
    ),
    fluidRow(
      column(
        width = 3,
        tags$div(
          class="form-group",
          style="float:right; width: 100%;margin-bottom:3px; ",
          tags$label("By :"),
          tags$input(
            class = "form-control shiny-bound-input",
            type = "text", id = ns("author"),
            value = author,
            placeholder = "Fanny Meyer"
          )
        )
      ),
      column(
        width = 3,
        tags$div(
          class="form-group",
          style="float:right; width: 100%; margin-bottom:3px; ",
          tags$label("Title :"),
          tags$input(
            class = "form-control shiny-bound-input",
            type = "text", id = ns("script_title"), value = "",
            placeholder = "Title"
          )
        )
      ),
      column(
        width = 6,
        pickerInput(
          inputId = ns("packages"), 
          label = "Packages to load :",
          choices = params$packages$default,
          multiple = TRUE, width = "100%",
          options = list(`live-search` = TRUE, 
                         size = 10, 
                         `selected-text-format` = "count > 3", 
                         `count-selected-text` = "{0} packages", 
                         `dropup-auto` = TRUE),
          selected = params$packages$selected
        )
      )
    ),
    actionButton(
      inputId = ns("script_create"),
      label = "Add script", 
      icon = icon("file-code-o"),
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



