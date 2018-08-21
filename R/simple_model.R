### Simple Forecast Model

## Forecast methods 

### Set training data from 1992 to 2007
win_mf = ts(df$valor_venda[5500:6056])

### rwf method
rwf = rwf(win_mf, drift = TRUE)

### Lambda modeling
lambda = BoxCox.lambda(win_mf)
autoplot(BoxCox(win_mf,lambda))

### Bias Adjustment
fc = rwf(win_mf, drift=TRUE, lambda=-0.9999, h=15, level=80)
fc2 = rwf(win_mf, drift=TRUE, lambda=-0.9999, h=15, level=80,
          biasadj=TRUE)

autoplot(win_mf) +
  autolayer(fc, series="Simple back transformation") +
  autolayer(fc2, series="Bias adjusted", PI=FALSE) +
  guides(colour=guide_legend(title="Forecast"))

### Residuals analysis
res = residuals(rwf(win_mf))
autoplot(res) + xlab("Day") + ylab("") +
  ggtitle("Residuals from Random Walk Method")