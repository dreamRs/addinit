

library("roxygen2")
roxygenise(clean = TRUE)


devtools::use_package("miniUI")
devtools::use_package("rstudioapi")
devtools::use_package("shinyWidgets")
devtools::use_package("whisker")


library("devtools")
install(dependencies = FALSE)


library(addinit)
#initAddin() # old

initProject() # new


# # options("addInit.folders" = c("scripts", "datas", "funs", "inputs", "outputs", "logs"))
# options("addInit.folders.selected" = c("scripts", "datas"))
# options("addInit.packages.selected" = "data.table")
# 
# getOption("addInit.folders")



addinit_options <- list(
  author = NULL,
  project = list(
    folders = list(
      default = c("scripts", "datas", "funs", "inputs", "outputs", "logs"),
      selected = NULL
    ),
    packages = list(
      default = rownames(installed.packages()),
      selected = NULL
    ),
    config = TRUE,
    source_funs = FALSE
  ),
  app
)


options("addinit" = addinit_options)






