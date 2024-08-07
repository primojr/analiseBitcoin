# Pacotes
#install.packages(c('prophet','patchwork')
library(tidyverse)

library(prophet)
library(patchwork)

# Base de dados
coin = tidyquant::tq_get(c('BTC-USD','ETH-USD', 'SOL-USD')
              ,from = '2022-01-01'
              ,end  = '2024-08-04'
              ) %>%
  select(date, symbol, close) %>%
  mutate(symbol = str_remove_all(symbol,"-USD"))

glimpse(coin)


# Identificar sasonalidade
## Grafico sazonalidade
# BTC
a = coin %>% filter(symbol == 'BTC') %>%
  mutate( mes = lubridate::month(date,label = TRUE)
          ,ano = lubridate::year(date) %>% as.factor()) %>%
  group_by(mes, ano) %>%
  summarise(close = mean(close)) %>%
  ggplot(aes(x = mes, y = log(close), group = ano, col=ano)) +
  geom_line() +
  geom_point() +
  ggtitle("BTC")

# ETH
b = coin %>% filter(symbol == 'ETH') %>%
  mutate( mes = lubridate::month(date,label = TRUE)
          ,ano = lubridate::year(date) %>% as.factor()) %>%
  group_by(mes, ano) %>%
  summarise(close = mean(close)) %>%
  ggplot(aes(x = mes, y = log(close), group = ano, col=ano)) +
  geom_line() +
  geom_point() +
  ggtitle("ETH")

# SOL
c = coin %>% filter(symbol == 'SOL') %>%
  mutate( mes = lubridate::month(date,label = TRUE)
          ,ano = lubridate::year(date) %>% as.factor()) %>%
  group_by(mes, ano) %>%
  summarise(close = mean(close)) %>%
  ggplot(aes(x = mes, y = log(close), group = ano, col=ano)) +
  geom_line() +
  geom_point() +
  ggtitle("SOL")

a / b / c

# Plot da relação
coin %>%
  group_by(symbol) %>%
  mutate(close_normalizado = timetk::standardize_vec(log1p(close))) %>%
  ungroup() %>%
  timetk::plot_time_series(date
                           ,close_normalizado
                           ,symbol
                           ,.smooth = FALSE
                           ,.title = 'Log - normalizado')


## Correlação

## Estimativa BTC
btc = coin %>%
  filter(symbol == 'BTC') %>%
  select(date, close) %>%
rename(ds = date, y = close) %>%
  arrange(ds)
glimpse(btc)

btc$ds %>% max()

## Predicao
model <- prophet(btc)
future <- make_future_dataframe(model, periods = 30)
forecast_btc <- predict(model, future)

## polt
dyplot.prophet(model, forecast_btc)
prophet_plot_components(model, forecast_btc)
#plot(forecast$trend[forecast$ds <= max(btc$ds)],btc$y)


## Estimativa ETH
eth = coin %>%
  filter(symbol == 'ETH') %>%
  select(date, close) %>%
  rename(ds = date, y = close) %>%
  arrange(ds)
glimpse(eth)


eth$ds %>% max()

## Predicao
model <- prophet(eth)
future <- make_future_dataframe(model, periods = 30)
forecast_eth <- predict(model, future)

## polt
dyplot.prophet(model, forecast_eth)
prophet_plot_components(model, forecast_eth)

## Gerar tabelas
cbind(
  forecast_btc %>%
    filter(ds >= '2022-01-01') %>%
    select(ds = ds,trend_btc = trend)
  ,forecast_eth %>%
    filter(ds >= '2022-01-01') %>%
    select(ds1 = ds,trend_eth = trend)
  ) %>%
  select(ds, trend_btc, trend_eth) %>%
  knitr::kable()




# Carregando os dados da série temporal (substitua "seus_dados.csv" pelo nome do seu arquivo)


dplyr::glimpse(btc)
# Convertendo a coluna de data para o formato de data no R, se necessário
dados$data <- as.Date(dados$data)

# Adicionando colunas de dia da semana e mês
btc$dia_semana <- weekdays(btc$ds)
btc$mes <- format(btc$ds, "%b")

# Agrupando os dados por dia da semana e mês e calculando a média (ou outra estatística relevante)
library(dplyr)
dados_resumidos <- btc %>%
  group_by(dia_semana, mes) %>%
  summarise(resultado_medio = mean(y)) # Você pode usar sum(), median(), sd() ou outra função, conforme necessário

# Plotando o gráfico

library(ggplot2)
ggplot(dados_resumidos, aes(x = dia_semana, y = resultado_medio, fill = mes)) +
  geom_line(stat = "identity", position = "dodge") +
  labs(title = "Resultado por Dia da Semana e Mês",
       x = "Dia da Semana",
       y = "Resultado Médio",
       fill = "Mês") +
  theme_minimal() +
  facet_grid(. ~ mes,)

