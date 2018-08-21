### Load Library
library(dplyr)
library(fpp2)

### Data Load
url_venda = ("http://api.bcb.gov.br/dados/serie/bcdata.sgs.1/dados?formato=csv")
url_compra = ("http://api.bcb.gov.br/dados/serie/bcdata.sgs.10813/dados?formato=csv")
cambio_venda = read.csv(url_venda, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ",")
cambio_compra = read.csv(url_compra, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ",")

### Adjust Names
names(cambio_venda)[names(cambio_venda) == "valor"] = "valor_venda"
names(cambio_compra)[names(cambio_compra) == "valor"] = "valor_compra"

### Merge Data
df = merge(cambio_venda, cambio_compra, by="data")

### Exclude Data
rm(cambio_venda)
rm(cambio_compra)

### Order temporal series
df$data = as.Date(df$data, format = "%d/%m/%Y")
df = df[order(as.Date(df$data, format="%d/%m/%Y")),]

### Filter Real mode
df = subset(df, data> "1994-07-01")


