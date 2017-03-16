# ------------------------------------------------------------------------------
# Given a square with side length 'D', in which a circle is drawn, with
# diameter 'D', pi can be approximated by the fraction:
#     area_circle / area_square = pi x (D/2)^2 / D^2
#                               = pi x D^2 / 4D^2
#                               = pi / 4
# Hence if we calculate the above fraction and multiply it with 4, we get pi!
# Let's do it:
# ------------------------------------------------------------------------------

# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')

# Define functions
# ------------------------------------------------------------------------------
throw_dart = function(n = 1){
  return(tibble(x   = runif(n, min = -1, max = 1),
                y   = runif(n, min = -1, max = 1),
                hit = factor( ifelse(sqrt(x**2 + y**2) <= 1, 1, 0) ))
         )
}

# Set random seed
# ------------------------------------------------------------------------------
set.seed(201461)

# Compute pi using monte carlo simulations
# ------------------------------------------------------------------------------
n_sims  = 10000
darts   = throw_dart(n_sims)
pi_appr = darts %>%
  summarise(pi_appr = mean(as.numeric(hit)-1)) %>%
  as_vector * 4

# Plot results
# ------------------------------------------------------------------------------
label = paste("pi == ", pi_appr)
darts %>% 
  ggplot(aes(x = x, y = y, colour = hit)) +
  geom_point() +
  annotate("text", x = 0, y = 0, label = label, parse = TRUE) +
  coord_fixed() +
  theme_bw()
ggsave('pi_approximation.png')
