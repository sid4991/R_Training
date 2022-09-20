## ---------------------------
##
## Script name:DataVis_part2
##
## Purpose of script: Training on Data visualization
##
## Author: Siddharth Chaudhary
##
## Date Created: 2022-09-20
##
## Copyright (c) Siddharth Chaudhary, 2022
## Email: siddharth.chaudhary@wsu.edu
##
## ---------------------------
##
## Notes:
## Data visualization
## Customizing the look and feel
## In this tutorial, I discuss how to customize the looks of the 6 most important aesthetics of a plot.
## Put together, it provides a fairly comprehensive list of how to accomplish your plot customization tasks in detail.
## ---------------------------


options(scipen = 999)
library(ggplot2)
data("midwest", package = "ggplot2")
theme_set(theme_bw())


## Add plot components --------------------------------
gg <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point(aes(col = state, size = popdensity)) +
  geom_smooth(method = "loess", se = F) +
  xlim(c(0, 0.1)) +
  ylim(c(0, 500000)) +
  labs(title = "Area Vs Population", y = "Population", x = "Area", caption = "Source: midwest")

## Call plot ------------------------------------------
plot(gg)


## Base Plot
gg <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point(aes(col = state, size = popdensity)) +
  geom_smooth(method = "loess", se = F) +
  xlim(c(0, 0.1)) +
  ylim(c(0, 500000)) +
  labs(title = "Area Vs Population", y = "Population", x = "Area", caption = "Source: midwest")


# element_text():  Since the title, subtitle and captions are textual items, element_text() function is used to set it.
# element_line():  modify line based components such as the axis lines, major and minor grid lines, etc.
# element_rect():  Modifies rectangle components such as plot and panel background.
# element_blank(): Turns off displaying the theme item.

## Modify theme components -------------------------------------------
gg + theme(
  plot.title = element_text(
    size = 20,
    face = "bold",
    family = "American Typewriter",
    color = "tomato",
    hjust = 0.5,
    lineheight = 1.2
  ), # title
  plot.subtitle = element_text(
    size = 15,
    family = "American Typewriter",
    face = "bold",
    hjust = 0.5
  ), # subtitle
  plot.caption = element_text(size = 15), # caption
  axis.title.x = element_text(
    vjust = 10,
    size = 15
  ), # X axis title
  axis.title.y = element_text(size = 15), # Y axis title
  axis.text.x = element_text(
    size = 10,
    angle = 30,
    vjust = .5
  ), # X axis text
  axis.text.y = element_text(size = 10)
) # Y axis text
