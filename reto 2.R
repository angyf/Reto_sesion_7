# Ahora es momento de realizar la extracción de una tabla desde un html, realiza 
# este reto desde tu RStudio Desktop.De la siguiente dirección donde se muestran 
# los sueldos para Data Scientists
# 
# (https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm), 
# realiza las siguientes acciones:
# Extraer la tabla del HTML
# Quitar los caracteres no necesarios de la columna sueldos (todo lo que no sea número),
# para dejar solamente la cantidad mensual (Hint: la función gsub podría ser de utilidad)
# Asignar ésta columna como tipo numérico para poder realizar operaciones con ella
# Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y la que menos paga?
theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"
file <- read_html(theurl)    # Leemos el html

tables <- html_nodes(file, "table")  


table1 <- html_table(tables[1], fill = TRUE)

table <- na.omit(as.data.frame(table1))   

salario<-gsub("MXN","",table$Sueldo)
salario<-gsub("\\$","",salario)
salario<-gsub("\\/mes","",salario)
salario<-gsub(",","",salario)
salario<-as.numeric(as.character(salario))

b <- gsub("Sueldos para Data Scientist en ", "", table$Cargo)
table$Cargo <-b

max<-which.max(salario)
table[max,"Cargo"]

min<-which.min(salario)
table[min,"Cargo"]
