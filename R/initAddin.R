#' @title Init project
#'
#' @description ton addin
#'
#'
#'
#' @import shiny
#' @import miniUI
#'
#' @export


initAddin <- function() {
  # Package

  library("miniUI")
  library("shiny")

  # Interface addin
  ui <- miniPage(

    # En tête de l'addin
    tags$div(
      class = "gadget-title",
      style = "background-color: rgb(51, 122, 183);height: 50px;",
      tags$h1("Init Projet", style = "color: white;text-align: center;font-size: 30px;font-weigth: bold;"),
      tags$button(
        id = "aide",
        class = "btn btn-primary btn-sm action-button pull-left",
        type = "button",
        "Aide",
        onclick = '$("#Modal_Aide").modal();'
      ),
      tags$div(
        class = "pull-right",
        miniTitleBarButton(inputId = "fermer", label = "Fermer")
      )
    ),

    bsModal(
      id = "Modal_Aide",
      title = "Aide",
      uiOutput(outputId = "Modal_Aide_output")
    ),

    useSelectPicker(),

    #gadgetTitleBar("Init Projet", left = NULL, right = miniTitleBarButton("done", "Done", primary = TRUE)),
    #miniTitleBarCancelButton(),



    miniTabstripPanel(
      id = "onglets",

      # UI - Organisation d'un projet -------------------------------------------------------------------------------------
      miniTabPanel(
        title = "Organisation d'un projet",
        value = "projet",
        icon = icon("folder"),
        miniContentPanel(
          # fluidRow(
          fluidRow(
            column(
              width = 12,
              tags$hr(style = "color:red; size:10; align:center; width:100%; border-top: 5px solid #eee; margin-top: 8px; margin-bottom: 1px;"),
              h4("Création de dossier(s)", style = "color: rgb(51, 102, 153);text-align: center; font-size: 20px; margin-top: 5px; margin-bottom: 5px;"),
              tags$hr(style = "color:red; size:10; align:center; width:100%; border-top: 5px solid #eee; margin-top: 1px; margin-bottom: 1px;")
            )
          ),
          fluidRow(
            column(
              width = 8,
              tags$h4("Standards :", style = "color: rgb(51, 102, 153);"),
              tags$div(
                style = "width: 100%;",
                checkboxGroupButtons(
                  inputId = "PR_dossier_global",
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
              tags$h4("Autres dossiers :", style = "color: rgb(51, 102, 153);"),
              textInput(
                inputId = "PR_dossier_perso", label = "",
                placeholder = "dossier1;dossier2 "
              )
            )
          ),
          fluidRow(
            column(
              width = 12,
              br(),
              tags$div(
                style = "float:right; ",
                actionButton(inputId = "PR_dossier_crea", label = "Créer !", icon = icon("folder-o"), class = "btn-primary")
              ),
              bsModal(
                id = "PR_dossier_modal", title = "placeholder",
                tags$h1("placeholder", style = "color: forestgreen")
              ),
              messageToModal(idModal = "PR_dossier_modal", message = "PR_dossier_mess")
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
                  inputId = "PR_fichier_param",
                  label = "",
                  choices = c(".gitignore", "00_Parametre.R"),
                  #selected = c(".gitignore", "00_Parametre.R"),
                  status = "warning",
                  inline = FALSE
                )
              ),
              uiOutput("PR_parametre_R")
            ),
            column(
              width = 6,
              tags$h4("Autres script R:", style = "color: rgb(51, 102, 153);"),
              #fluidRow(
              column(
                width = 6,
                tags$div(
                  class="form-group",
                  #class="form-group shiny-input-container",
                  style="float:right;width: 100%; margin-bottom:3px !important",
                  tags$label("Répertoire :"),
                  # tags$input(
                  #   class = "form-control shiny-bound-input",
                  #   type = "text",
                  #   id = "path",
                  #   value = "",
                  #   placeholder = "./R_data/"
                  # )
                  selectizeInput(
                    inputId = "path", label = NULL, choices = list_dirs(), width = "100%",
                    options = list(placeholder = './R_data/', onInitialize = I('function() { this.setValue(""); }'))
                  )
                )
              ),
              column(
                width = 6,
                tags$div(
                  class="form-group",
                  #class="form-group shiny-input-container",
                  style="float:right;width: 100%;margin-bottom:3px",
                  tags$label("Nom du fichier :"),
                  tags$input(
                    class = "form-control shiny-bound-input",
                    type = "text", id = "name", value = "",
                    placeholder = "Sans extension"
                  )
                )
              ),
              column(
                width = 6,
                tags$div(
                  class="form-group",
                  #class="form-group shiny-input-container",
                  style="float:right;width: 100%;margin-bottom:3px; ",
                  tags$label("Crée par :"),
                  tags$input(
                    class = "form-control shiny-bound-input",
                    type = "text", id = "nom", value = "",
                    placeholder = "Fanny Meyer"
                  )
                )
              ),
              column(
                width = 6,
                tags$div(
                  class="form-group",
                  #class="form-group shiny-input-container",
                  style="float:right;width: 100%;margin-bottom:3px; margin-top: -62px;",
                  tags$label( "Description :"),
                  tags$input(
                    class = "form-control shiny-bound-input",
                    type = "text", id = "descriptif", value = "",
                    placeholder = "descriptif"
                  )
                )
              )
            )
          )
          ,
          fluidRow(
            column(
              width = 6,
              br(),
              tags$div(
                style = "float:right",
                actionButton(inputId = "PR_param_crea", label = "Créer!", icon = icon("cog"), class = "btn-primary")
              ),
              bsModal(
                id = "PR_param_modal", title = "placeholder",
                tags$h1("placeholder", style = "color: forestgreen")
              ),
              messageToModal(idModal = "PR_param_modal", message = "PR_param_mess")
            ),
            column(
              width = 6,
              br(),
              tags$div(
                style = "float:right",
                actionButton(inputId = "PR_script_crea", label = "Créer l'en-tête",
                             icon = icon("file-code-o"), class = "btn-primary")
              ),
              bsModal(
                id = "PR_script_modal",
                title = "placeholder",
                tags$h1("placeholder", style = "color: forestgreen")
              ),
              messageToModal(idModal = "PR_script_modal", message = "PR_script_mess")
            )
          )

        )

        # )

      ),

      # UI - Organisation d'une application ----------------------------------------------------------------------------------------
      miniUI::miniTabPanel(
        title = "Organisation d'une application" ,
        value = "application",
        icon = icon("chrome"),
        miniContentPanel(
          # fluidRow(
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
              width = 8,
              tags$h4("Standards :", style = "color: rgb(51, 102, 153);"),
              tags$div(
                style = "width: 100%;",
                checkboxGroupButtons(
                  inputId = "SH_dossier_global",
                  label = "",
                  choices =  c("www","01_Datas","02_Funs","03_Views","04_Global","05_Modules"),
                  #selected = c("R_fun","R_script","R_data","inputs","outputs","logs","Save","Sql"),
                  #direction = "vertical",
                  status = "info",
                  fullwidth = TRUE
                )
              )
            ),
            column(
              width = 4,
              tags$h4("Autres dossiers :", style = "color: rgb(51, 102, 153);"),
              textInput(
                inputId = "SH_dossier_perso",
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
                actionButton(inputId = "SH_dossier_crea", label = "Créer !", icon = icon("folder-o"))
              ),
              bsModal(
                id = "SH_dossier_modal", title = "placeholder",
                tags$h1("placeholder", style = "color: forestgreen")
              ),
              messageToModal(idModal = "SH_dossier_modal", message = "SH_dossier_mess")
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
              tags$h4("Script Shiny:", style = "color: rgb(51, 102, 153);"),
              tags$div(
                style = "width: 100%;",
                awesomeCheckboxGroup(
                  inputId = "SH_fichier_param",
                  label = "",
                  choices = c("ui.R", "server.R", "global.R", "autres"),
                  #selected = c(".gitignore", "00_Parametre.R"),
                  status = "warning",
                  inline = FALSE
                )
              ),
              uiOutput("SH_parametre_R")
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
                      id = "path_shiny",
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
                      id = "name_shiny",
                      value = "",
                      placeholder = "MonFichier"
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
                      id = "nom_shiny",
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
                      id = "description_shiny",
                      value = "",
                      placeholder = "descriptif"
                    )
                  )
                )
              )
            )
          ),
          fluidRow(
            column(
              width = 6,
              br(),
              tags$div(
                style = "float:right",
                actionButton(
                  inputId = "SH_param_crea",
                  label = "Créer!",
                  icon = icon("cog")
                )
              ),
              bsModal(
                id = "SH_param_modal",
                title = "placeholder",
                tags$h1("placeholder", style = "color: forestgreen")
              ),
              messageToModal(idModal = "SH_param_modal", message = "SH_param_mess")
            ),
            column(
              width = 6,
              br(),
              tags$div(
                style = "float:right",
                actionButton(
                  inputId = "SH_script_crea",
                  label = "Créer!",
                  icon = icon("cog")
                )
              ),
              bsModal(
                id = "SH_script_modal",
                title = "placeholder",
                tags$h1("placeholder", style = "color: forestgreen")
              ),
              messageToModal(idModal = "SH_script_modal", message = "SH_script_mess")
            )
          )

        )
      )
    )
  )



  # Serveur addin
  server <- function(input, output, session) {


    # SERVER - Organisation d'un projet -------------------------------------------------------------------------------------

    output$PR_parametre_R <- renderUI({
      if ("00_Parametre.R" %in% input$PR_fichier_param){
        pickerInput(
          inputId = "PR_fichier_param_det", label = "",
          choices = c("liste de config", "Connexion Verone", "Connexion Verone Miroir", "Connexion Hadoop",
                      "Connexion Datashop", "Connexion Datashop Internet", "Connexion Score", "Connexion geodatabase",
                      "Connexion dac temp"),
          options = list(`actions-box` = TRUE, title = "Eléments à ajouter",
                         `deselect-all-text` = "Désélectionner tout", `select-all-text` = "Sélectionner tout"),
          multiple = TRUE
        )
      }

    })


    observeEvent(input$PR_dossier_crea, {
      #initDossiers_Perso(dirs = input$dossier_perso)
      messageDossiers <- capture.output(
        c(initDossiers(dirs = input$PR_dossier_global), initDossiers_Perso(dirs = input$PR_dossier_perso))
      )

      messageDossiers <- messageDossiers[messageDossiers != "NULL"]

      messageDossiers <- messageDossier(X = messageDossiers)

      messageDossiers <- paste(messageDossiers, collapse = " <br> ")
      session$sendCustomMessage(type = "PR_dossier_mess", message = messageDossiers)
      updateSelectizeInput(session = session, inputId = "path", choices = list_dirs())
    })



    observeEvent(input$PR_script_crea, {

      if (input$path == ""){
        messageFichier <- paste('<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>','Pas de chemin')
      } else if (input$name == ""){
        messageFichier <- paste('<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>','Pas de nom de fichier')
      } else {
        messageFichier <- capture.output(
          createHeader(path = input$path, file.name = input$name, descriptif = input$descriptif, auteur = neAuteur(input$nom))
        )
        messageFichier <- messageFichier[messageFichier != "NULL"]
        messageFichier <- paste('<i class="fa fa-info-circle fa-2x" style="color: rgb(51, 122, 183);"></i>', messageFichier)
      }

      messageFichier <- paste(messageFichier, collapse = " <br> ")
      session$sendCustomMessage(type = 'PR_script_mess', message = messageFichier)

    })

    observeEvent(input$PR_param_crea, {

      if (is.null(input$PR_fichier_param) ){
        messageParam <- paste('<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>','Aucune selection ! ')
      }
      if (".gitignore" %in% input$PR_fichier_param){
        messageParam1 <- capture.output(initGitignore())
      } else {
        messageParam1 <- character(0)
      }

      # Config
      config <- input$PR_fichier_param_det[input$PR_fichier_param_det == "liste de config"]
      if (length(config)>0) {
        config = TRUE
      } else {
        config = FALSE
      }

      # Connexion
      if ("00_Parametre.R" %in% input$PR_fichier_param){
        connexion <- input$PR_fichier_param_det[!(input$PR_fichier_param_det %in% c("liste de config"))]
        if (length(connexion) > 0) {
          # Plus besoin des switchs : on passe directement a create_params le nom des connexion a ajouter
          messageParam2 <- capture.output(
            createParam(connecter_db = connexion, configuration = config, auteur = neAuteur(input$nom))
          )
        } else {
          messageParam2 <- capture.output(
            createParam(connecter_db = NULL, configuration = config, auteur = neAuteur(input$nom))
          )
        }
      } else {
        messageParam2 <- capture.output(
          createParam(connecter_db = NULL, configuration = config, auteur = neAuteur(input$nom))
        )
      }


      if ("00_Parametre.R" %in% input$PR_fichier_param & (length(input$PR_fichier_param_det) == 1 && input$PR_fichier_param_det == "")){
        messageParam2 <- paste(
          '<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>','Aucune selection dans les config! '
        )
      }
      # if (!file.exists("./R_script/")){
      #   messageParam2 <- paste('<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>',
      #                          "Le dossier R_script n'existe pas ! ")
      # }

      messageParam <- c(messageParam1, messageParam2)
      messageParam <- messageParam[messageParam != "NULL"]

      messageParam <- messageDossier(X = messageParam)

      messageParam <- paste(messageParam, collapse = " <br> ")
      session$sendCustomMessage(type = 'PR_param_mess', message = messageParam)

    })



    # SERVER - Organisation d'une application -------------------------------------------------------------------------------

    output$SH_parametre_R <- renderUI({
      if ("autres" %in% input$SH_fichier_param){
        pickerInput(
          inputId = "SH_fichier_param_det", label = "",
          choices = c("04_Global/00_Packages.R", "04_Global/01_Datas.R", "04_Global/02_Functions.R", "04_Global/03_Vues.R",
                      "03_Views/01_header.R", "03_Views/02_sidebar.R", "03_Views/03_body.R"),
          options = list(`actions-box` = TRUE, title = "Eléments à ajouter"), multiple = TRUE
        )
      }

    })



    observeEvent(input$SH_dossier_crea, {
      #initDossiers_Perso(dirs = input$dossier_perso)
      messageDossiersShiny <- capture.output(
        c(initDossiers(dirs = input$SH_dossier_global), initDossiers_Perso(dirs = input$SH_dossier_perso))
      )
      messageDossiersShiny  <- messageDossiersShiny[messageDossiersShiny  != "NULL"]
      messageDossiersShiny  <- messageDossier(X = messageDossiersShiny)
      messageDossiersShiny  <- paste(messageDossiersShiny , collapse = " <br> ")
      session$sendCustomMessage(type = "SH_dossier_mess", message = messageDossiersShiny)
    })

    observeEvent(input$SH_param_crea, {
      #initDossiers_Perso(dirs = input$dossier_perso)

      messageParamShiny  <- messageShiny(input = input)
      messageParamShiny  <- messageParamShiny[messageParamShiny  != "NULL"]
      messageParamShiny  <- messageDossier(X = messageParamShiny)
      messageParamShiny  <- paste(messageParamShiny , collapse = " <br> ")
      session$sendCustomMessage(type = "SH_param_mess", message = messageParamShiny)
    })

    observeEvent(input$SH_script_crea, {
      if (input$path_shiny == ""){
        messageFichier <- paste('<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>','Pas de chemin')
      } else if (input$name_shiny == ""){
        messageFichier <- paste('<i class="fa fa-exclamation-circle fa-2x" style="color: rgb(255, 0, 0);"></i>','Pas de nom de fichier')
      } else {
        messageFichier <-
          capture.output(c(
            createHeader(path = input$path_shiny, file.name = input$name_shiny,
                         descriptif = input$descriptif_shiny, auteur = input$nom_shiny)
          ))
        messageFichier <- messageFichier[messageFichier != "NULL"]
        messageFichier <- paste('<i class="fa fa-info-circle fa-2x" style="color: rgb(51, 122, 183);"></i>', messageFichier)
      }
      messageFichier <- paste(messageFichier, collapse = " <br> ")
      session$sendCustomMessage(type = 'SH_script_mess', message = messageFichier)
    })




    # SERVER - AIDE ----------------------------------------------------------------------------------------------------

    observeEvent(input$aide, {
      session$sendCustomMessage('ShowModal', list(eltID = "Modal_Aide"))
    })

    output$Modal_Aide_output <- renderUI({
      if (grepl(pattern = "projet", x = input$onglets)) {
        tags$div(

          tags$h4("Aide à l'organisation d'un projet", style = "color: rgb(51, 102, 153);"),

          tags$h6("Création de dossier(s)", style = "color: rgb(51, 102, 153);"),

          tags$p(
            "Cliquez sur les boutons pour sélectionner le(s) dossier(s) à créer.",
            "Il est également possible de saisir des noms de dossiers manuellement dans le champ texte,",
            " en les séparant d'un point-virgule s'il y en a plusieurs."
          ),
          tags$p(
            "Cliquez sur ",
            actionButton(inputId = "btn_aide", label = "Créer !", class = "btn-primary btn-xs", icon = icon("folder-o")),
            "pour les créer !"
          )

        )
      } else {
        tags$div(
          tags$h4("Aide à l'organisation d'une application", style = "color: rgb(51, 102, 153);")
        )
      }
    })



    # Close addin
    observeEvent(input$fermer, stopApp())

  }


  # Dans un modal
  viewer <- dialogViewer("Fais de ta vie un rêve, et d'un rêve, une réalité.", width = 1000, height = 700)
  runGadget(ui, server, viewer = viewer)

  # # Dans le viewer
  # viewer <- paneViewer(300)
  # runGadget(ui, server, viewer = viewer)
}
