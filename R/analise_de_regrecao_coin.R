# Pacotes
library(tidymodels)
library(tidyverse)

# Contrução do df

df = coin %>%
  pivot_wider(names_from = symbol, values_from = close) %>%
  drop_na() %>%
  mutate(ano_mes =  str_sub(date,1,7)) %>%
  group_by(ano_mes) %>%
  summarise(avg_btc = mean(log1p(BTC))
            ,avg_eth = mean(log1p(ETH))
  )

# Correlacao
cor(df$avg_btc, df$avg_eth)



# Ajuste
mod = lm(avg_eth ~ avg_btc, data =df)
summary(mod)

