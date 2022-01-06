# Pacotes
library(tidyverse)
library(prophet)


# Base de dados
coin = tidyquant::tq_get(c('BTC-USD','ETH-USD')
              ,from = '2011-12-15'
              ,end  = '2022-01-04'
              ) %>%
  select(date, symbol, close) %>%
  mutate(symbol = str_remove_all(symbol,"-USD"))

glimpse(coin)


# Identificar sasonalidade


## Grafico sazonalidade
df %>%
  mutate( mes = lubridate::month(ds,label = TRUE)
          ,ano = lubridate::year(ds) %>% as.factor()) %>%
  group_by(mes, ano) %>%
  summarise(y = mean(y)) %>%
  ggplot(aes(x = mes, y = y, group = ano, col=ano)) +
  geom_line() +
  geom_point()

