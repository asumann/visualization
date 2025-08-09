library(tidyverse)
library(RColorBrewer)

read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***") %>% 
  select(year = Year, t_diff = `J-D`) %>% 
  drop_na() %>% 
  ggplot(aes(year, t_diff, fill = t_diff)) +
  geom_col(show.legend = FALSE)+
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0) +
  theme_void()


library(tidyverse)
library(scales)

data <- read_csv("data/GLB.Ts+dSST.csv", skip = 1, na = "***") %>% 
  select(year = Year, t_diff = `J-D`) %>% 
  drop_na()

# Create a combined scale: normalize both t_diff and year
data <- data %>% 
  mutate(
    temp_scaled = rescale(t_diff, to = c(-1, 1)),
    year_scaled = rescale(year, to = c(0, 1)),
    # Blend them: 80% temp, 20% year tint
    blend_value = 0.8 * temp_scaled + 0.2 * (year_scaled - 0.5)
  )

ggplot(data, aes(year, t_diff, fill = blend_value)) +
  geom_col(show.legend = FALSE) +
  scale_fill_gradient2(low = "navy", mid = "white", high = "firebrick", midpoint = 0) +
  theme_void()


