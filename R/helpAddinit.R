#' Addinit help
#'
#' @return a taglist
#' @noRd
#' @importFrom htmltools includeMarkdown
helpAddinit <- function() {
  
  tagList(
    tabsetPanel(
      
      tabPanel(
        title = "Welcome",
        
        tags$h3("Welcome to addinit !"),
        br(),
        tags$p("Simplify your project's and shiny application setup with ", tags$b("addinit"), " !"),
        br(),
        tags$ol(
          tags$li("Create a project within RStudio"),
          tags$li("Launch addinit in the Addins menu"),
          tags$li("Structure your project by creating some directories"),
          tags$li("Initialize a template for a simple script or a Shiny application"),
          tags$li("Enjoy & start coding !")
        ),
        br(),
        br(),
        tags$p(
          "More information on :",
          tags$a(icon("github"), href = "https://github.com/dreamRs/addinit")
        ),
        tags$p(
          "If you have questions, you can ask them here :",
          tags$a(
            "https://github.com/dreamRs/addinit/issues",
            href = "https://github.com/dreamRs/addinit/issues"
          )
        )
      ),
      
      tabPanel(
        title = "Configuration",
        br(),
        tags$p(
          "You can customize a lot of options in addinit, for example the names",
          "of the directories to create or a default author for the scripts.",
          "For this just modify the parameters list below and",
          "set the option addinit in your .Rprofile."
        ),
        htmltools::includeMarkdown(path = system.file('www/params.md', package='addinit'))
      )
      
    ),
    
    tags$script(HTML("$('ul.nav-tabs').addClass('nav-justified');"))
  )
  
}

