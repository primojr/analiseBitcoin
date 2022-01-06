
# Fazer previsão do Bitcoin com base no ptk `prophet`

A ideia do projeto é fazer um analise dos dados de fechamento das duas principais clipto moedas

## Fechamento médio por mes e ano
![fonte:Yahoo Financias](img/plot_mes_ano.png)

## Relacão entre o BTC e ETH
> Apliqui a `N(1,0)` e `log1p()`

![Gráfico 1](img/BTCxETH.png)

ps. *No ultimo mes, vemos um descolamento entres a moedas*


## Estimativas para o proximos dias do BTC

* Projeção com base no pacote `prophet`
> Fazer tune dos parametros

|ds         |trend(BTC)|
|:----------|--------:|
|2022-01-02 | 52818.65|
|2022-01-03 | 52845.45|
|2022-01-04 | 52872.24|
|2022-01-05 | 52899.04|
|2022-01-06 | 52925.84|
|2022-01-07 | 52952.63|
|2022-01-08 | 52979.43|
|2022-01-09 | 53006.22|
|2022-01-10 | 53033.02|
|2022-01-11 | 53059.82|
|2022-01-12 | 53086.61|
|2022-01-13 | 53113.41|
|2022-01-14 | 53140.20|
|2022-01-15 | 53167.00|
|2022-01-16 | 53193.80|
|2022-01-17 | 53220.59|
|2022-01-18 | 53247.39|
|2022-01-19 | 53274.19|
|2022-01-20 | 53300.98|
|2022-01-21 | 53327.78|
|2022-01-22 | 53354.57|
|2022-01-23 | 53381.37|
|2022-01-24 | 53408.17|
|2022-01-25 | 53434.96|

![Estimativas para janeiro](img/Btc_projecao.png)


## Estimativas para o proximos dias do ETH

* Projeção com base no pacote `prophet`
> Fazer tune dos parametros
