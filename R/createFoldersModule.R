
# there is a place in the heart that
# will never be filled
# 
# a space
# 
# and even during the
# best moments
# and
# the greatest times
# times
# 
# we will know it
# 
# we will know it
# more than
# ever
# 
# there is a place in the heart that
# will never be filled
# and
# 
# we will wait
# and
# wait
# 
# in that space.


#' Module for creating folders
#'
#' @param id Module's id
#' @param params List of parameters, e.g. names of directory to create
#' @param title Title to display
#'
#' @return a \code{shiny::\link[shiny]{tagList}} containing UI elements
#' @noRd
#'
createFoldersUi <- function(id, params, title = "Create folders") {
  
  # Namespace
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(
        width = 12,
        tags$hr(class = "addInit-hr"),
        h4(title, class = "addInit-h4"),
        tags$hr(class = "addInit-hr")
      )
    ),
    fluidRow(
      column(
        width = 8,
        tags$h4("Folders :", class = "addInit-label"),
        shinyWidgets::checkboxGroupButtons(
          inputId = ns("folders"), label = NULL, choices = params$folders$default, justified = TRUE, 
          status = "info", selected = params$folders$selected,
          checkIcon = list(yes = tags$i(class = "fa fa-check-square"), no = tags$i(class = "fa fa-square-o"))
        )
      ),
      column(
        width = 4,
        tags$h4("Others :", class = "addInit-label"),
        textInput(
          inputId = ns("folders_other"),
          label = NULL,
          placeholder = "folder1;folder2 "
        )
      )
    ),
    fluidRow(
      column(
        width = 12,
        tags$div(
          class = "pull-right",
          br(),
          shiny::actionButton(
            inputId = ns("folders_create"), label = "Create folders !", 
            icon = icon("folder-o"), class = "btn-primary"
          )
        )
      )
    )
  )
}





#' Module for creating folders
#'
#' @param input   standard \code{shiny} input
#' @param output  standard \code{shiny} output
#' @param session standard \code{shiny} session
#'
#' @return a reactiveValues updated each time folders are created
#' @noRd
createFoldersServer <- function(input, output, session) {
  
  # Namespace
  ns <- session$ns
  
  res <- reactiveValues(x = NULL)
  
  observeEvent(input$folders_create, {
    folders <- c(input$folders, unlist(strsplit(input$folders_other, split = ";")))
    status_folders <- create_dirs(file.path(".", folders))
    shiny::showModal(shiny::modalDialog(
      title = "Folders creation",
      create_dirs_msg(
        folders,
        status_folders
      )
    ))
    
    res$x <- input$folders_create
  })
  
  return(res)
}



