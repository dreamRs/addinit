

miniContentPanel(
  fluidRow(
    fluidRow(
      column(
        width = 12,
        tags$hr(style = "color:red;size:10;align:center;width:100%;border-top: 5px solid #eee; margin-top: 8px;margin-bottom: 1px;"),
        h4("Création de dossier", style = "color: rgb(51, 102, 153);text-align: center;font-size: 20px; margin-top: 5px;margin-bottom: 5px;"),
        tags$hr(style = "color:red;size:10;align:center;width:100%;border-top: 5px solid #eee;; margin-top: 1px;margin-bottom: 1px;")
      )
    ),
    fluidRow(
      column(
        width = 12,
        uiOutput('Modal_Glossaire_KPIGlobaux_output')
      )
    ),
    fluidRow(
      column(
        width = 8,
        tags$h4("Standards:", style = "color: rgb(51, 102, 153);"),
        tags$div(
          style = "width: 100%;",
          checkboxGroupButtons(
            inputId = "dossier_global",
            label = "",
            choices = c("R_fun","R_script","R_data","inputs","outputs","logs","Save","Sql"),
            #selected = c("R_fun","R_script","R_data","inputs","outputs","logs","Save","Sql"),
            #direction = "vertical",
            status = "info",
            fullwidth = TRUE
          )
        )
      ),
      column(
        width = 4,
        tags$h4("Autres dossiers:", style = "color: rgb(51, 102, 153);"),
        textInput(
          inputId = "dossier_perso",
          label = "",
          placeholder = "dossier1;dossier2 "
        )
      )
    ),
    fluidRow(
      column(
        width = 12,
        br(),
        tags$div(
          style = "float:right",
          actionButton(inputId = "crea", label = "Créer !", icon = icon("folder-o"))
        ),
        bsModal(
          id = "modalCreerProjet", title = "placeholder",
          tags$h1("placeholder", style = "color: forestgreen")
        ),
        tags$script(
          HTML(
            "Shiny.addCustomMessageHandler('testmessage', function(data) {
              var modal = $('#modalCreerProjet')
              modal.find('.modal-title').text(' Récap ')
              var texte = data.join(' <br> ');
              modal.find('.modal-body').html(texte);
              modal.modal();
            });"

          )
        )
      )
    ),
    fluidRow(
      column(
        width = 12,
        br(),
        tags$hr(style = "color:red;size:10;align:center;width:100%;border-top: 5px solid #eee; margin-top: 8px;margin-bottom: 1px;"),
        h4("Création de scripts", style = "color: rgb(51, 102, 153);text-align: center;font-size: 20px; margin-top: 5px;margin-bottom: 5px;"),
        tags$hr(style = "color:red;size:10;align:center;width:100%;border-top: 5px solid #eee;; margin-top: 1px;margin-bottom: 1px;")
      )
    ),
    fluidRow(
      column(
        width = 6,
        tags$h4("Paramètres:", style = "color: rgb(51, 102, 153);"),
        tags$div(
          style = "width: 100%;",
          awesomeCheckboxGroup(
            inputId = "fichier_param",
            label = "",
            choices = c(".gitignore", "00_Parametre.R"),
            #selected = c(".gitignore", "00_Parametre.R"),
            status = "warning",
            inline = FALSE
          )
        ),
        uiOutput("parametre_R"),
        tags$div(
          style = "float:right",
          actionButton(
            inputId = "crea_script",
            label = "Créer!",
            icon = icon("cog")
          )
        )
      ),
      column(
        width = 6,
        tags$h4("Autres script R:", style = "color: rgb(51, 102, 153);"),
        fluidRow(
          column(
            width = 6,
            tags$div(
              class="form-group",
              #class="form-group shiny-input-container",
              style="float:right;width: 100%;margin-bottom:3px",
              tags$label("Repertoire"),
              tags$input(
                class = "form-control shiny-bound-input",
                type = "text",
                id = "path",
                value = "",
                placeholder = "./R_data/"
              )
            )
          ),
          column(
            width = 6,
            tags$div(
              class="form-group",
              #class="form-group shiny-input-container",
              style="float:right;width: 100%;margin-bottom:3px",
              tags$label("Nom du fichier"),
              tags$input(
                class = "form-control shiny-bound-input",
                type = "text",
                id = "name",
                value = "",
                placeholder = "MonFichier.R"
              )
            )
          ),
          column(
            width = 6,
            tags$div(
              class="form-group",
              #class="form-group shiny-input-container",
              style="float:right;width: 100%;margin-bottom:3px",
              tags$label("Crée par :"),
              tags$input(
                class = "form-control shiny-bound-input",
                type = "text",
                id = "nom",
                value = "",
                placeholder = "Fanny Meyer"
              )
            )
          ),
          column(
            width = 6,
            tags$div(
              class="form-group",
              #class="form-group shiny-input-container",
              style="float:right;width: 100%;margin-bottom:3px",
              tags$label( "Description"),
              tags$input(
                class = "form-control shiny-bound-input",
                type = "text",
                id = "description",
                value = "",
                placeholder = "descriptif"
              )
            )
          )
        ),
        tags$div(
          style = "float:right",
          actionButton(
            inputId = "crea_script2",
            label = "Créer l'en-tête",
            icon = icon("file-code-o")
          )
        ),
        bsModal(
          id = "myModal2",
          title = "placeholder",
          tags$h1("placeholder", style = "color: forestgreen")
        ),
        tags$script(
          HTML(
            "Shiny.addCustomMessageHandler('testmessage3', function(data) {
              var modal = $('#myModal2')
              modal.find('.modal-title').text(' Récap ')
              var texte = data.join(' <br> ');
              modal.find('.modal-body').html(texte);
              modal.modal();
            });"
          )
        )
      )
    )
  )
)






miniContentPanel(
  # ou miniTabstripPanel et des miniTabPanel
  fluidRow(
    ,
    ,

  ),
  ,
  ,

  ,
  column(
    width = 6,
    br(),

  ),
  column(
    width = 6,
    br(),


    )
  )
