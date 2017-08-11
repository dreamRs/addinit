#' Module for creating script(s) in the application tab
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
#' @import shiny
createScriptsAppUI <- function(id, params, author = NULL) {
  
  # Namespace
  ns <- NS(id)
  
  htmltools::tagList(
    fluidRow(
      column(
        width = 12,
        tags$hr(class = "addInit-hr"),
        h4("Create scripts", class = "addInit-h4"),
        tags$hr(class = "addInit-hr")
      )
    ),
    br(),
    fluidRow(
      style = "min-height: 70px;",
      column(
        width = 6,
        shinyWidgets::awesomeCheckbox(
          inputId = ns("basic_shiny_script"), 
          label = "Add Shiny template", 
          value = params$create_template, status = "info"
        )
      ),
      column(
        width = 6,
        conditionalPanel(
          condition = paste0("input['", ns("basic_shiny_script"), "'] == true"),
          shinyWidgets::awesomeRadio(
            inputId = ns("type_shiny_app"), 
            label = "Choose a template :", 
            choices = c("Shiny" = "shiny",
                        "Shiny Dashboard" = "dashboard", 
                        "Single file app" = "miniapp"),
            selected = params$template, 
            inline = TRUE, checkbox = TRUE
          )
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        shinyWidgets::pickerInput(
          inputId = ns("path_shiny"), label = "Where :", 
          choices = c(". (root)" = ".", list_dirs(recursive = FALSE)),
          selected = ".",
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
              type = "text", id = ns("script_name_shiny"), value = "",
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
            type = "text", id = ns("author_shiny"), 
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
            type = "text", id = ns("script_title_shiny"), value = "",
            placeholder = "Title"
          )
        )
      ),
      column(
        width = 6,
        shinyWidgets::pickerInput(
          inputId = ns("packages_shiny"), 
          label = "Packages to load :",
          choices = params$packages$default, multiple = TRUE, 
          options = list(`live-search` = TRUE, size = 10, 
                         `selected-text-format` = "count > 3", 
                         `count-selected-text` = "{0} packages", 
                         `dropup-auto` = TRUE),
          selected = params$packages$selected
        )
      )
    ),
    fluidRow(
      column(
        width = 12,
        br(),
        tags$div(
          style = "float:right",
          actionButton(
            inputId = ns("script_create_shiny"), 
            label = "Add script",
            icon = icon("file-code-o"), 
            class = "btn-primary"
          )
        )
      )
    )
  )
}


#' Module for creating script(s) in the application tab
#' 
#' Server part
#'
#' @param input   standard \code{shiny} input
#' @param output  standard \code{shiny} output
#' @param session standard \code{shiny} session
#' @param trigger ReactiveValues to trigger update of folders
#'
#' @noRd
#' @importFrom shinyWidgets updatePickerInput
createScriptsAppServer <- function(input, output, session, trigger) {
  
  ns <- session$ns
  
  
  observeEvent(input$basic_shiny_script, {
    if (!is.null(input$basic_shiny_script)) {
      # toggleInputServer(
      #   session = session, 
      #   inputId = ns("script_title_shiny"), 
      #   enable = !input$basic_shiny_script
      # )
      toggleInputServer(
        session = session,
        inputId = ns("path_shiny"),
        enable = !input$basic_shiny_script, 
        picker = TRUE
      )
      toggleInputServer(
        session = session, 
        inputId = ns("script_name_shiny"), 
        enable = !input$basic_shiny_script
      )
    }
  }, ignoreInit = FALSE)
  
  observeEvent(trigger$x, {
    shinyWidgets::updatePickerInput(
      session = session, 
      inputId = "path_shiny",
      choices = c(".", list_dirs(recursive = FALSE)),
      selected = "."
    )
  })
  
  observeEvent(input$script_create_shiny, {
    
    if (input$basic_shiny_script){
      tryAlert(
        expr = init_script(
          type = input$type_shiny_app,
          author = input$author_shiny, 
          packages = input$packages_shiny
        ), 
        success_text = "Script successfully created !",
        error_text = "Ooops... Something went wrong"
      )
    } else {
      tryAlert(
        expr = create_script(
          path = input$path_other_shiny, 
          name = input$script_name_shiny, 
          author = input$author_shiny, 
          title = input$script_title_shiny,
          packages = input$packages_shiny
        ), 
        success_text = "Script successfully created !",
        error_text = "Ooops... Something went wrong"
      )
    }
    
  })
  
}