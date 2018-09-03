### Arima Model
train = ts(df$valor_venda[5835:5996])
test = ts(df$valor_venda[5997:6067])

### autoarima
autoarim = auto.arima(test)

### Plot autorima method
autoplot(forecast(autoarim), h = 10)

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