```r
my_custom_params <- list(
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
  application = list(
    folders = list(
      default = c("datas", "funs", "modules", "www"),
      selected = NULL
    ),
    packages = list(
      default = rownames(installed.packages()),
      selected = NULL
    ),
    create_template = TRUE,
    template = "dashboard"
  )
)
options("addinit" = my_custom_params)
```
