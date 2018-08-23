### Arima Model
train = ts(df$valor_venda[5827:5988])
test = ts(df$valor_venda[5989:6059])

### autoarima
autoarim = auto.arima(train)

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