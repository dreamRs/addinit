#' @title Init Project Addin
#' 
#' @description Initialize a structure for a new project
#'
#' @return the return of \code{\link[shiny]{runGadget}}
#' @export
#'
#' @examples 
#' \dontrun{
#' initProject()
#' }

initProject <- function() {
  
  # Parameters
  params_default <- list(
    project = list(
      folders = list(
        default = c("scripts", "datas", "funs", "inputs", "outputs", "logs")
      ),
      packages = list(
        default = rownames(installed.packages())
      ),
      config = TRUE,
      source_funs = FALSE
    ),
    shiny = list(
      folders = list(
        default = c("datas", "funs", "modules", "www")
      )
    )
  )
  
  params <- getOption(x = "addinit", default = params_default)
  
  # Addin ---
  viewer <- dialogViewer("Initialize a project.", width = 1000, height = 700)
  # viewer <- browserViewer()
  runGadget(app = initProjectUI(params), server = initProjectServer, viewer = viewer)
  
}
