# Installation ----

install.packages("modelStudio")
install.packages("DALEX")

# Libraries ----

library(modelStudio)
library(DALEX)
library(tidymodels)
library(tidyverse)

# Data ----

data_tbl <- mpg %>% 
  select(hwy, manufacturer: drv, fl, class)

# Model ----

fit_xgboost <- boost_tree(learn_rate = 0.3) %>% 
  set_mode("regression") %>% 
  set_engine("xgboost") %>% 
  fit(hwy ~., data = data_tbl)

fit_xgboost

# Explainer ----

explainer <- DALEX::explain(
  model = fit_xgboost, 
  data = data_tbl,
  y = data_tbl$hwy,
  label = "XGBoost"
)

# Model Studio ----

modelStudio::modelStudio(explainer)

