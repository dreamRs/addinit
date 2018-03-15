

#  ------------------------------------------------------------------------
#
# Title : App - Global
#    By : {{author}}
#  Date : {{date}}
#    
#  ------------------------------------------------------------------------



{{packages}}



# Funs --------------------------------------------------------------------

for (i in list.files(path = "functions/", full.names = TRUE)) {
  source(file = i, encoding = "UTF-8")
}
rm(i)


# Modules -----------------------------------------------------------------

# for (i in list.files(path = "modules/", full.names = TRUE)) {
#   source(file = i, encoding = "UTF-8")
# }
# rm(i)



# Datas -------------------------------------------------------------------

