

# Addin for quickly creating a new script

#' @importFrom rstudioapi showPrompt
quick_script <- function() {
  if (dir.exists("scripts")) {
    path <- "scripts"
  } else {
    path <- "."
  }
  opts <- getOption("addinit", default = list())
  name <- rstudioapi::showPrompt(
    title = "Create a new script",
    message = "Name (without extension) :", 
    default = "script"
  )
  if (is.null(name))
    return(invisible())
  create_script(path = path, name = name, author = opts$author)
}



# Addin for quickly add an header to a script
#' @importFrom rstudioapi showPrompt
quick_header <- function() {
  title <- rstudioapi::showPrompt(
    title = "Add a header",
    message = "Title :", 
    default = " "
  )
  opts <- getOption("addinit", default = list())
  header <- paste(
    "",
    "#  ------------------------------------------------------------------------",
    "#",
    paste0("# Title : ", title),
    paste0("#    By : ", opts$author),
    paste0("#  Date : ", format(Sys.Date(), format = "%F")),
    "#",
    "#  ------------------------------------------------------------------------",
    "",
    sep = "\n"
  )
  rstudioapi::insertText(location = c(1, 1), text = header)
}



