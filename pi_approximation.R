# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')

# Define functions
# ------------------------------------------------------------------------------
throw_dart = function(n=1){
  return(tibble(x   = runif(n,min = -1, max = 1),
                y   = runif(n,min = -1, max = 1),
                hit = factor(ifelse(sqrt(x**2+y**2)<=1,1,0))))
}

# Set random seed
# ------------------------------------------------------------------------------
set.seed(201461)

# Compute pi using monte carlo approximation
# ------------------------------------------------------------------------------
darts   = throw_dart(10000)
pi_appr = darts %>%
  select(hit) %>%
  as_vector %>%
  unname %>%
  as.character %>%
  as.numeric %>%
  mean * 4

# Plot results
# ------------------------------------------------------------------------------
label = paste("pi == ", pi_appr)
darts %>% 
  ggplot(aes(x=x,y=y,colour=hit)) +
  geom_point() +
  annotate("text",x=0,y=0,label=label,parse=TRUE) +
  coord_fixed() +
  theme_bw()
