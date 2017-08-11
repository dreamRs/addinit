
# Utils ----


`%||%` <- function(a, b) {
  if (!is.null(a)) a else b
}


#' Create directories
#'
#' @param paths Valid path(s) 
#'
#' @return a logical
#' @noRd
#'

create_dirs <- function(paths) {
  status <- logical(0)
  for (i in seq_along(paths)) {
    status[i] <- dir.create(path = paths[i], showWarnings = FALSE)
  }
  return(status)
}


#' Message for modal on status of dirs creation
#'
#' @param dirs List of dirs
#' @param status Logical, status of creation
#'
#' @return a logical
#' @noRd
#' 
#' @importFrom htmltools tags HTML
#' 

create_dirs_msg <- function(dirs, status) {
  status_icone <- ifelse(
    status,
    yes = '<i class="fa fa-check-circle fa-2x" style="color: rgb(0, 102, 0);"></i>',
    no = '<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>'
  )
  status_text <- ifelse(
    status,
    yes = 'Folder successfully created',
    no = 'Error : the folder already exist or invalid path'
  )
  tags$ul(
    class="fa-ul",
    lapply(
      X = paste(paste(status_icone, paste0("<b>", dirs, "</b>"), sep = " "), status_text, sep = " : "),
      FUN = function(x) {
        tags$li(HTML(x))
      }
    )
  )
}


#' List directories excluding Rproj or git
#'
#' @param path Valid path
#'
#' @return a logical
#' @noRd
#' 

list_dirs <- function(path = ".", recursive = TRUE) {
  res <- list.dirs(path = path, recursive = recursive)
  res <- res[!grepl(pattern = "\\.Rproj", x = res)]
  res <- res[!grepl(pattern = "\\.git", x = res)]
  return(res)
}





#' Create a configuration script to initialize parameter of a project
#'
#' @param author Script's author
#' @param packages Packages to load
#' @param config Add a list of path
#' @param funs Source all functions in fun dir
#' @param path where to create the script
#'
#' @noRd
#' 
#' @importFrom whisker whisker.render
#' @importFrom rstudioapi navigateToFile
#'

create_config <- function(author = "", packages = "", config = FALSE, funs = FALSE, path = ".") {
  config_template <- readLines(con = system.file('www/templates/config.R', package='addinit'))
  # config_template <- readLines(con = 'inst/www/templates/config.R')
  config_template <- paste(config_template, collapse = "\n")
  
  
  # Packages
  if (is.null(packages))
    packages <- ""
  
  if (packages[1] != "") {
    packages <- paste("library(", packages, ")")
    packages <- paste(packages, collapse = "\n")
    packages <- paste(
      "# Packages ----------------------------------------------------------------", "",
      packages, sep = "\n"
    )
  }
  
  # Config
  create_config <- config
  if (config) {
    liste_config <- character()
    for (i in list.dirs(path = ".", recursive = FALSE, full.names = FALSE)){
      if (!is.null(i) && !grepl(pattern = "\\.Rproj", x = i)) {
        liste <- paste0("config$rep[[\"",i,"\"]] <- file.path( config$rep$base, \"", i, "\" )")
        liste_config <- c(liste_config, liste)
      }
    }
    config <- c(
      "",
      "",
      "# Config ------------------------------------------------------------------",
      "",
      paste0("config <- list()"),
      paste0("config$rep$base <- getwd()"),
      liste_config,
      "",
      ""
    )
    config <- paste(config, collapse = "\n")
  } else {
    config <- ""
  }
  
  
  # Functions
  if (funs & any(grepl(pattern = "fun", x = tolower(list.dirs(path = ".", recursive = FALSE, full.names = FALSE))))) {
    path_funs <- list.dirs(path = ".", recursive = FALSE, full.names = FALSE)
    path_funs <- path_funs[grepl(pattern = "fun", x = tolower(path_funs))]
    if (create_config) {
      path_funs <- paste0("config$rep$", path_funs)
    } else {
      path_funs <- paste0("\"", path_funs, "\"")
    }
    funs <- paste0("for (i in list.files(path = ", path_funs, ", pattern = \"\\\\.R$\", full.names = TRUE)) {")
    funs <- paste(
      funs,
      "  source(i)",
      "}",
      sep = "\n"
    )
    funs <- paste(
      c("# Functions ---------------------------------------------------------------", funs),
      collapse = "\n\n"
    )
  } else {
    funs <- ""
  }
  
  
  # Content
  content <- whisker::whisker.render(
    template = config_template, 
    data = list(
      author = author, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = packages,
      config = config, 
      funs = funs
    )
  )
  fileCon <- file(file.path(path, "config.R"))
  writeLines(text = content, con = fileCon)
  close(fileCon)
  rstudioapi::navigateToFile(file = file.path(path, "config.R"))
  invisible()
}

#' Create shiny script to initialize shiny app
#'
#' @param author Script's author
#' @param packages Packages to load
#' @param ui Create ui.R
#' @param server Create server.R
#' @param global Create global.R
#'
#' @noRd
#'
#' @importFrom whisker whisker.render
#' @importFrom rstudioapi navigateToFile

create_shiny_script <- function(author = "", packages = "", ui = TRUE, server = TRUE, global = TRUE) {
  
  # Packages
  if (is.null(packages))
    packages <- ""
  
  # Global.R
  if (global == TRUE | packages[1] != "") {
    global_template <- readLines(con = system.file('www/templates/shiny/global.R', package='addinit'))
    # config_template <- readLines(con = 'inst/www/templates/config.R')
    global_template <- paste(global_template, collapse = "\n")
    
    
    if (packages[1] != "") {
      packages <- paste("library(", packages, ")")
      packages <- paste(packages, collapse = "\n")
      packages <- paste(
        "# Packages ----------------------------------------------------------------", "",
        packages, sep = "\n"
      )
    }
    
    # Content
    content <- whisker::whisker.render(
      template = global_template, 
      data = list(
        author = author, 
        date = format(Sys.Date(), format = "%A %d %B %Y"),
        packages = packages
      )
    )
    fileCon <- file(file.path("global.R"))
    writeLines(text = content, con = fileCon)
    close(fileCon)
    rstudioapi::navigateToFile(file = file.path("global.R"))
    invisible()
  }

  # ui.R
  if (ui == TRUE) {
    ui_template <- readLines(con = system.file('www/templates/shiny/ui.R', package='addinit'))
    # config_template <- readLines(con = 'inst/www/templates/config.R')
    ui_template <- paste(ui_template, collapse = "\n")
    
    
    # Content
    content <- whisker::whisker.render(
      template = ui_template, 
      data = list(author = author, date = format(Sys.Date(), format = "%A %d %B %Y"))
    )
    fileCon <- file(file.path("ui.R"))
    writeLines(text = content, con = fileCon)
    close(fileCon)
    rstudioapi::navigateToFile(file = file.path("ui.R"))
    invisible()
  }
  
  # ui.R
  if (server == TRUE) {
    server_template <- readLines(con = system.file('www/templates/shiny/server.R', package='addinit'))
    # config_template <- readLines(con = 'inst/www/templates/config.R')
    server_template <- paste(server_template, collapse = "\n")
    
    
    # Content
    content <- whisker::whisker.render(
      template = server_template, 
      data = list(author = author, date = format(Sys.Date(), format = "%A %d %B %Y"))
    )
    fileCon <- file(file.path("server.R"))
    writeLines(text = content, con = fileCon)
    close(fileCon)
    rstudioapi::navigateToFile(file = file.path("server.R"))
    invisible()
  }
  

}


#' Create a script with header
#'
#' @param path Where to create the file.
#' @param name Script's name.
#' @param author Author of the script.
#' @param title Title of the script.
#' @param packages Package to load in the script.
#'
#' @noRd
#'
#' @importFrom whisker whisker.render
#' @importFrom rstudioapi navigateToFile

create_script <- function(path = ".", name = "script", author = "", title = "", packages = "") {
  script_template <- readLines(con = system.file('www/templates/script.R', package='addinit'))
  script_template <- paste(script_template, collapse = "\n")
  content <- whisker::whisker.render(
    template = script_template, 
    data = list(
      author = author %||% "",
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      title = title %||% "",
      packages = load_packages(packages)
    )
  )
  name <- paste0(name, ".R")
  fileCon <- file(file.path(path, name))
  writeLines(text = content, con = fileCon)
  close(fileCon)
  rstudioapi::navigateToFile(file = file.path(path, name))
  invisible()
}



#' Render a script frfom a template
#'
#' @param template Path to the template
#' @param path Path to the new script generated
#' @param name name of the script
#' @param ... additionnal arguments to the template
#'
#' @noRd
render_script <- function(template, path = ".", name = "script", ...) {
  script_template <- readLines(con = template)
  script_template <- paste(script_template, collapse = "\n")
  content <- whisker::whisker.render(
    template = script_template, 
    data = list(...)
  )
  name <- paste0(name, ".R")
  fileCon <- file(file.path(path, name))
  writeLines(text = content, con = fileCon)
  close(fileCon)
  rstudioapi::navigateToFile(file = file.path(path, name))
  invisible()
}





#' Generate script to load packages
#'
#' @param packages a character vector of packages to load
#'
#' @return a string
#' @noRd
#'
#' @examples
#' \dontrun{
#' load_packages(NULL)
#' load_packages("")
#' load_packages("data.table")
#' }
load_packages <- function(packages) {
  if (is.null(packages))
    packages <- ""
  
  if (packages[1] != "") {
    packages <- paste("library(", packages, ")")
    packages <- paste(packages, collapse = "\n")
    packages <- paste(
      "# Packages ----------------------------------------------------------------",
      "",
      packages, sep = "\n"
    )
  }
  
  return(packages)
}






#' Initialize a cript from a template
#'
#' @param type Tpe of script : script, shiny, dashboard, miniapp.
#' @param ... additionnal arguments to put in the template
#'
#' @noRd
init_script <- function(type, ...) {
  args <- list(...)
  args_default <- list(
    path = ".", 
    name = "script", 
    author = "",
    title = "",
    packages = ""
  )
  args <- modifyList(x = args_default, val = args)
  type <- match.arg(
    arg = type, 
    choices = c("shiny", "dashboard", "miniapp", "script")
  )
  if (type == "script") {
    render_script(
      template = system.file('www/templates/script.R', package='addinit'),
      path = args$path,
      name = args$name, 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
  } else if (type == "shiny") {
    render_script(
      template = system.file('www/templates/shiny/ui.R', package='addinit'),
      path = ".",
      name = "ui", 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
    render_script(
      template = system.file('www/templates/shiny/server.R', package='addinit'),
      path = ".",
      name = "server", 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
    render_script(
      template = system.file('www/templates/shiny/global.R', package='addinit'),
      path = ".",
      name = "global", 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
  } else if (type == "dashboard") {
    render_script(
      template = system.file('www/templates/dashboard/ui.R', package='addinit'),
      path = ".",
      name = "ui", 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
    render_script(
      template = system.file('www/templates/dashboard/server.R', package='addinit'),
      path = ".",
      name = "server", 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
    render_script(
      template = system.file('www/templates/dashboard/global.R', package='addinit'),
      path = ".",
      name = "global", 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
  } else if (type == "miniapp") {
    render_script(
      template = system.file('www/templates/app/app.R', package='addinit'),
      path = ".",
      name = "app", 
      author = args$author,
      title = args$title, 
      date = format(Sys.Date(), format = "%A %d %B %Y"),
      packages = load_packages(args$packages)
    )
  }
  invisible()
}









