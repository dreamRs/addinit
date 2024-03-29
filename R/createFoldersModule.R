
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
#' @importFrom shiny NS tagList fluidRow column tags textInput actionButton
#' @importFrom shinyWidgets checkboxGroupButtons
#' @importFrom htmltools tags
#' @importFrom phosphoricons ph
createFoldersUi <- function(id, params, title = "Create folders") {
  
  # Namespace
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(
        width = 12,
        tags$hr(class = "addinit-hr"),
        tags$h4(title, class = "addinit-h4"),
        tags$hr(class = "addinit-hr")
      )
    ),
    fluidRow(
      column(
        width = 8,
        tags$h4("Folders :", class = "addinit-label"),
        checkboxGroupButtons(
          inputId = ns("folders"), 
          label = NULL, 
          choices = params$folders$default, 
          selected = params$folders$selected,
          justified = TRUE, 
          status = "info",
          checkIcon = list(
            yes = ph("check-square"), 
            no = ph("square")
          )
        )
      ),
      column(
        width = 4,
        tags$h4("Others :", class = "addinit-label"),
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
          tags$br(),
          actionButton(
            inputId = ns("folders_create"), 
            label = tagList(ph("folder"), "Create folders"), 
            class = "btn-primary"
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
#' 
#' @importFrom htmltools tags
#' @importFrom shiny reactiveValues observeEvent showModal modalDialog updateTextInput
#' @importFrom shinyWidgets updateCheckboxGroupButtons
#' 
createFoldersServer <- function(input, output, session) {
  
  # Namespace
  ns <- session$ns
  
  res <- reactiveValues(x = NULL)
  
  observeEvent(input$folders_create, {
    folders <- c(input$folders, unlist(strsplit(input$folders_other, split = ";")))
    status_folders <- create_dirs(file.path(".", folders))
    showModal(modalDialog(
      title = "Folders creation",
      create_dirs_msg(
        folders,
        status_folders
      )
    ))
    updateCheckboxGroupButtons(
      session = session, 
      inputId = "folders", 
      selected = character(0), 
      status = "info"
    )
    updateTextInput(
      session = session, 
      inputId = "folders_other",
      value = ""
    )
    res$x <- c(res$x, input$folders_create)
  })
  
  return(res)
}



