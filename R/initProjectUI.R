#' Ui for initProject Addin
#'
#' @noRd
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
    miniTabstripPanel(
      id = "tabs",
      
      # tab organize project ----
      miniTabPanel(
        title = "Organize your project",
        value = "project",
        icon = icon("folder"),
        miniContentPanel(
          
          
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
          fluidRow(
            column(
              width = 6,
              tags$h4("Config script :", class = "addInit-label"),
              shinyWidgets::pickerInput(
                inputId = "config_path", label = "Where :", 
                choices = c(". (root)" = ".", list_dirs(recursive = FALSE)), selected = ".",
                options = list(size = 5)
              ),
              # shinyWidgets::awesomeRadio(
              #   inputId = "config_path", label = "Where :", inline = TRUE, status = "warning",
              #   choices = c(". (root)" = ".", list_dirs(recursive = FALSE)), selected = "."
              # ),
              fluidRow(
                column(6, shinyWidgets::materialSwitch(inputId = "config", label = "Add config list", value = params$config, status = "warning", right = TRUE)),
                column(6, shinyWidgets::materialSwitch(inputId = "source_funs", label = "Source function", value = params$source_funs, status = "warning", right = TRUE))
              ),
              shinyWidgets::pickerInput(
                inputId = "packages", label = "Packages to load :", choices = params$packages$default, multiple = TRUE, 
                options = list(`live-search` = TRUE, size = 10, `selected-text-format` = "count > 3", 
                               `count-selected-text` = "{0} packages", `dropup-auto` = TRUE),
                selected = params$packages$selected
              )
            ),
            column(
              width = 6,
              column(
                width = 12,
                tags$div(
                  class="form-group",
                  style="float:right; width: 100%;margin-bottom:3px",
                  tags$h4("Other scripts :", class = "addInit-label"),
                  shinyWidgets::pickerInput(
                    inputId = "path_other", label = "Where :", 
                    choices = c(". (root)" = ".", list_dirs(recursive = FALSE)), selected = ".",
                    options = list(size = 5)
                  )
                )
              ),
              # shinyWidgets::awesomeRadio(
              #   inputId = "path_other", label = "Where :", inline = TRUE, status = "warning",
              #   choices = c(".", list_dirs(recursive = FALSE)), selected = "."
              # ),
              column(
                width = 12,
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
              ),
              column(
                width = 6,
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
                width = 6,
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
              )
            )
          ),
          fluidRow(
            column(
              width = 6,
              br(),
              tags$div(
                style = "float:right",
                actionButton(inputId = "config_create", label = "Create !", icon = icon("cog"), class = "btn-primary")
              )
            ),
            column(
              width = 6,
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
      miniTabPanel(
        title = "Organize your Shiny app",
        value = "application",
        icon = icon("cubes")
      )
    )
    
  )
  
}

