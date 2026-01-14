library(tidyverse)
library(haven)
library(writexl)


# get_labels <- function(df) {
#   labels <- sapply(df, function(x) {
#     lab <- attr(x, "label")
#     if (is.null(lab)) NA else lab
#   })
#   data.frame(variable = names(df), label = labels, row.names = NULL)
# }
# 
# variable_labels <- get_labels(data)
# 
# glimpse(data)
# 
# data %>% select(year, cname_i, cname_j, trade, gatt_o, gatt_d, wto_o, wto_d)
#
# 
path <- "C:/Users/alexa/Documents/Cours Dauphine/Quantitative International Economics/TeamExam/Data/"
data <- read_dta(paste0(path, "Gravity_M2IT.dta"))

# 
# # Fonction robuste pour nettoyer les colonnes
# clean_column <- function(x) {
#   # Convertir haven_labelled en caractère ou numérique
#   if (inherits(x, "haven_labelled")) {
#     # Si c'est numérique à la base, garder numérique
#     if (is.numeric(as.vector(x))) {
#       return(as.numeric(x))
#     } else {
#       x <- as.character(x)
#     }
#   }
#   
#   # Pour les colonnes caractères, nettoyer l'encodage
#   if (is.character(x)) {
#     # Convertir en UTF-8 en remplaçant les caractères invalides
#     x <- iconv(x, from = "", to = "UTF-8", sub = "")
#     # Supprimer les caractères de contrôle restants
#     x <- gsub("[[:cntrl:]]", "", x)
#   }
#   
#   return(x)
# }
# 
# # Appliquer à toutes les colonnes
# data_clean <- as.data.frame(lapply(data, clean_column))
# 
# # Exporter
# write_xlsx(data_clean, paste0(path, "Gravity_M2IT.xlsx"))

selected_variables <- c("trade", "wto_o", "wto_d", "iso3_i", "iso3_j", 
                        "cname_i", "cname_j", "rta", 
                        "gdp_i", "gdp_j", "pop_i", "pop_j",
                        "dist", "contig", "col_mt", "col_dep_ever",
                        "inc_i", "inc_j", "gatt_o", "gatt_o")

trade_data <- data %>% select(all_of(selected_variables))





