#' Addinit help
#'
#' @return a taglist
#' @noRd
#' @importFrom htmltools includeMarkdown tags tagList
#' @importFrom shiny tabsetPanel tabPanel HTML
#' @importFrom phosphoricons ph
helpAddinit <- function() {
  
  tagList(
    tabsetPanel(
      
      tabPanel(
        title = "Welcome",
        
        tags$h3("Welcome to addinit !"),
        tags$br(),
        tags$p("Simplify your project's and shiny application setup with ", tags$b("addinit"), " !"),
        tags$br(),
        tags$ol(
          tags$li("Create a project within RStudio"),
          tags$li("Launch addinit in the Addins menu"),
          tags$li("Structure your project by creating some directories"),
          tags$li("Initialize a template for a simple script or a Shiny application"),
          tags$li("Enjoy & start coding !")
        ),
        tags$br(),
        tags$br(),
        tags$p(
          "More information can be found on GitHub :",
          tags$a(ph("github-logo"), href = "https://github.com/dreamRs/addinit")
        ),
        tags$p(
          "If you have questions, you can ask them here :",
          tags$a(
            "https://github.com/dreamRs/addinit/issues",
            href = "https://github.com/dreamRs/addinit/issues"
          )
        ),
        tags$br()
      ),
      
      tabPanel(
        title = "Configuration",
        tags$br(),
        tags$p(
          "You can customize a lot of options in addinit, for example the names",
          "of the directories to create or a default author for the scripts.",
          "For this just modify the parameters list below and",
          "set the option addinit in your .Rprofile."
        ),
        tags$div(
          style = "max-height: 300px; overflow-y: scroll;",
          includeMarkdown(path = system.file("www/params.md", package='addinit'))
        )
      )
      
    ),
    tags$script(HTML("$('ul.nav-tabs').addClass('nav-justified');"))
  )
  
}

