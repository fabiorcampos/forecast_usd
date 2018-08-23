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

### Arima Model
train = ts(df$valor_venda[5823:5984])
test = ts(df$valor_venda[5985:6055])

### autoarima
autoarim = auto.arima(train)

### Plot autorima method
plot(forecast(autoarim), h = 10)

### Create a dataframe comparison the test set with forecasting
forecast = data.frame(forecast(autoarim, h=71))
forecast = ts(forecast$Point.Forecast)
data = data.frame(test, forecast)

### Calculate error
error = as.numeric(test - forecast)

### Combine
data = cbind(data, error)

### Summary
summary(data)

### Plot
plot(ts(data$test), xlab = "Período teste", ylab = "Taxa do Dólar")
lines(ts(data$forecast), col = "red")
