

#  ------------------------------------------------------------------------
#
# Title : Config script
#    By : 
#  Date : jeudi 13 avril 2017
#    
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library( data.table )
library( ggplot2 )




# Config ------------------------------------------------------------------

config <- list()
config$rep$base <- getwd()
config$rep[["examples"]] <- file.path( config$rep$base, "examples" )
config$rep[["inst"]] <- file.path( config$rep$base, "inst" )
config$rep[["man"]] <- file.path( config$rep$base, "man" )
config$rep[["R"]] <- file.path( config$rep$base, "R" )
config$rep[["test"]] <- file.path( config$rep$base, "test" )






