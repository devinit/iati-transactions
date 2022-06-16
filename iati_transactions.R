list.of.packages <- c("data.table","dotenv", "dplyr","httr","openxlsx")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only=T)
rm(list.of.packages,new.packages)

url_base = "https://countrydata.iatistandard.org/data-en/"

countries <- read.csv("countries_selected.csv")
isos <- countries$country_iso2

hold <- list()

for (i in c(1:length(isos))){
  url = paste0(url_base,isos[i],".xlsx")
  data = read.xlsx(url,sheet="Data")
  hold[[i]] = data
}

hold_df <- rbindlist(hold)

filename = paste0("transactions-",Sys.Date())

write.csv(hold_df,paste0(filename,".csv"))

save(hold_df, file=paste0(filename,".RDa"))

# We now have a dataset of iati-identifiers with their budget information for all budgets 2021 onwards.