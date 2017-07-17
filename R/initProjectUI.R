#' Ui for initProject Addin
#'
#' @noRd
#' 
#' @import shiny miniUI
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
    
    
    # tabs
    miniUI::miniTabstripPanel(
      id = "tabs",
      
      # tab organize project ----
      miniUI::miniTabPanel(
        title = "Organize your project",
        value = "project",
        icon = icon("folder"),
        miniUI::miniContentPanel(
          
          toggleInputUi(),
          createFoldersUi(id = "project", params = params$project, title = "Create folders")
          
          ,
          br(),
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
            column(
              width = 6,
              shinyWidgets::pickerInput(
                inputId = "path", label = "Where :", 
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
                    type = "text", id = "script_name", value = "",
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
                  type = "text", id = "author", value = params$author,
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
                  type = "text", id = "script_title", value = "",
                  placeholder = "Title"
                )
              )
            ),
            column(
              width = 6,
              shinyWidgets::pickerInput(
                inputId = "packages", label = "Packages to load :", choices = params$project$packages$default, multiple = TRUE, 
                options = list(`live-search` = TRUE, size = 10, `selected-text-format` = "count > 3", 
                               `count-selected-text` = "{0} packages", `dropup-auto` = TRUE),
                selected = params$project$packages$selected
              )
            )
          ),
          fluidRow(
            column(
              width = 6,
              shinyWidgets::awesomeCheckbox(inputId = "config_script", 
                                            label = "Config Script", 
                                            value = FALSE, status = "info")
            ),
            column(
              width = 6,
              conditionalPanel(
                condition = "input.config_script == true",
                column(6, shinyWidgets::materialSwitch(inputId = "config", label = "Add config list", value = params$project$config, status = "warning", right = TRUE)),
                column(6, shinyWidgets::materialSwitch(inputId = "source_funs", label = "Source function", value = params$project$source_funs, status = "warning", right = TRUE))
              )
            )
          ),
          fluidRow(
            column(
              width = 12,
              br(),
              tags$div(
                style = "float:right",
                actionButton(inputId = "script_create", label = "Add script", icon = icon("file-code-o"), class = "btn-primary")
              )
            )
          )
        )
      ),
      
      # tab organize shiny app ----
      miniUI::miniTabPanel(
        title = "Organize your Shiny app",
        value = "application",
        icon = icon("cubes"),
        miniUI::miniContentPanel(
          
          
          createFoldersUi(id = "application", params = params$shiny, title = "Create folders")
          
          ,
          br(),
          fluidRow(
            column(
              width = 12,
              tags$hr(class = "addInit-hr"),
              h4("Create scripts", class = "addInit-h4"),
              tags$hr(class = "addInit-hr")
            )
          ),
          fluidRow(
            column(
              width = 6,
              shinyWidgets::awesomeCheckbox(inputId = "basic_shiny_script", 
                                            label = "Add Shiny script", 
                                            value = FALSE, status = "info")
            ),
            column(
              width = 6,
              conditionalPanel(
                condition = "input.basic_shiny_script == true",
                awesomeRadio(inputId = "type_shiny_app", 
                             label = "", choices = c("Shiny", "Shiny Dashboard", "Mini App"), selected = "Shiny Dashboard", 
                             inline = TRUE, checkbox = TRUE)
              )
            )
          ),
          fluidRow(
            column(
              width = 6,
              shinyWidgets::pickerInput(
                inputId = "path_shiny", label = "Where :", 
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
                    type = "text", id = "script_name_shiny", value = "",
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
                  type = "text", id = "author_shiny", value = params$author,
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
                  type = "text", id = "script_title_shiny", value = "",
                  placeholder = "Title"
                )
              )
            ),
            column(
              width = 6,
              shinyWidgets::pickerInput(
                inputId = "packages_shiny", label = "Packages to load :", choices = params$project$packages$default, multiple = TRUE, 
                options = list(`live-search` = TRUE, size = 10, `selected-text-format` = "count > 3", 
                               `count-selected-text` = "{0} packages", `dropup-auto` = TRUE),
                selected = params$project$packages$selected
              )
            )
          ),
          fluidRow(
            column(
              width = 12,
              br(),
              tags$div(
                style = "float:right",
                actionButton(inputId = "script_create_shiny", label = "Add script", icon = icon("file-code-o"), class = "btn-primary")
              )
            )
          )
        )
      )
    )
    
  )
  
}

