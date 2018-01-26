

rst_create_study <- function(path, ...) {
  
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  
  # parameters
  dots <- list(...)
  
  # create sub-folders
  folders <- c("scripts", "datas", "funs", "inputs")
  folders <- folders[unlist(dots[folders], use.names = FALSE)]
  create_dirs(file.path(path, folders))
  
  # readme content
  readme <- paste0("# ", basename(path), "\n", "\n", "> ", dots[["description"]])
  
  # create a readme
  writeLines(readme, con = file.path(path, "README.md"))
}
