#' @title Initialize an 'RStudio' Project or a Shiny Application
#' 
#' @description Create a new RStudio project then launch this addin. 
#' You will be able to create folders and scripts to start your analysis/project/application in no time.
#' 
#' @details You can change some default parameters if you want, look at example below, here's the full list of parameters :
#' \itemize{
#'  \item \strong{author:} The value to use by default for author input, used when creating a script from template.
#'  \item \strong{folders.default:} The names of the directories to create.
#'  \item \strong{folders.selected:} Select folders to create by default.
#'  \item \strong{packages.default:} A vector of packages to load in scripts, by default all packages installed.
#'  \item \strong{packages.selected:} Select packages to load by default.
#'  \item \strong{config:} Add a config script or not at the root of the projects for loading data, sourcing funs, ...
#'  \item \strong{source_funs:} Add code to source functions.
#'  \item \strong{create_template:} Make Shiny template selection appear.
#'  \item \strong{template:} Template to create, `shiny` for a classic shiny app (ui, server, global), `dashboard` for use shinydashboard, `miniapp` for a single file app (app.R)
#' }
#' 
#' @param author_name Name of the author
#' @return the return of \code{\link[shiny]{runGadget}}
#' @export
#' 
#' @importFrom utils installed.packages modifyList
#' @importFrom shiny runGadget dialogViewer
#'
#' @examples 
#' \dontrun{
#' # you can launch the addin via the RStudio Addins menu
#' # or in the console :
#' addinit::initProject(author_name)
#' 
#' # Change default parameters
#' # (you can put this in your Rprofile) :
#' my_custom_params <- list(
#'   author = "Your Name",
#'   project = list(
#'     folders = list(
#'       default = c("R", "inst", "man", "data-raw", "data", "tests"),
#'       selected = c("R", "man")
#'     ),
#'     packages = list(
#'       default = rownames(installed.packages()),
#'       selected = "shiny"
#'     )
#'   )
#' )
#' options("addinit" = my_custom_params)
#' 
#' # Then relaunch the addin
#' }
initProject <- function(author_name) {
  
  # Parameters
  params_default <- list(
    author = author_name,
    project = list(
      folders = list(
        default = c("scripts", "data", "functions", "inputs", "outputs", "logs", "reports"),
        selected = c("scripts", "data", "functions", "inputs", "outputs", "logs", "reports")
      ),
      packages = list(
        default = rownames(utils::installed.packages()),
        selected = c("data.table","lubridate","openxlsx"  )
      ),
      config = TRUE,
      source_funs = FALSE
    ),
    application = list(
      folders = list(
        default = c("datas", "funs", "modules", "www")
      ),
      packages = list(
        default = rownames(utils::installed.packages()),
        selected = c("data.table","lubridate","openxlsx"  )
      ),
      create_template = TRUE,
      template = "dashboard"
    )
  )
  
  params <- utils::modifyList(x = params_default, val = getOption(x = "addinit", default = list()))
  
  # Addin ---
  viewer <- shiny::dialogViewer("Initialize a project.", width = 1000, height = 700)
  # viewer <- browserViewer()
  shiny::runGadget(app = initProjectUI(params), server = initProjectServer, viewer = viewer)
  
}
