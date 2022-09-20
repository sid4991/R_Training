## ---------------------------
##
## Script name: DataVis_part3
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
## R Workshop
## Scatter plot and correlation matrix, density plots
## ---------------------------


p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()
p
p + annotate("rect",
  xmin = c(2, 4), xmax = c(3, 5), ymin = c(20, 10), ymax = c(30, 20),
  alpha = 0.2, color = "blue", fill = "blue"
)
p + annotate("segment",
  x = 1, xend = 3, y = 25, yend = 15,
  colour = "purple", size = 3, alpha = 0.6
)
p + geom_hline(yintercept = 25, color = "orange", size = 1) +
  geom_vline(xintercept = 3, color = "orange", size = 1)
ggsave("Plot.png", p, width = 10, dpi = 300)


## Correlation
## Scatterplot With Encircling

install.packages("ggalt")
library(ggplot2)
library(ggalt)
options(scipen = 999)

midwest_select <- midwest[midwest$poptotal > 350000 &
  midwest$poptotal <= 500000 &
  midwest$area > 0.01 &
  midwest$area < 0.1, ]
ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point(aes(col = state, size = popdensity)) + # draw points
  geom_smooth(method = "loess", se = F) +
  xlim(c(0, 0.1)) +
  ylim(c(0, 500000)) + # draw smoothing line
  geom_encircle(aes(x = area, y = poptotal),
    data = midwest_select,
    color = "red",
    size = 2,
    expand = 0.08
  ) + # encircle
  labs(subtitle = "Area Vs Population", y = "Population", x = "Area", title = "Scatterplot + Encircle", caption = "Source: midwest")



## Correlation matrix

install.packages("ggcorrplot")
library(ggcorrplot)
data(mtcars)
corr <- round(cor(mtcars), 1)

ggcorrplot(corr,
  hc.order = TRUE,
  type = "lower",
  lab = TRUE,
  lab_size = 3,
  method = "circle",
  colors = c("tomato2", "white", "springgreen3"),
  title = "Correlogram of mtcars",
  ggtheme = theme_bw
)

## Deviation
theme_set(theme_bw())

## Data Prep

data("mtcars")                                                              # load data
mtcars$`car name` <- rownames(mtcars)                                       # create new column for car names
mtcars$mpg_z <- round((mtcars$mpg - mean(mtcars$mpg)) / sd(mtcars$mpg), 2)  # compute normalized mpg
mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "below", "above")               # above / below avg flag
mtcars <- mtcars[order(mtcars$mpg_z), ] # sort
mtcars$`car name` <- factor(mtcars$`car name`, levels = mtcars$`car name`)  # convert to factor to retain sorted order in plot.

## Diverging Barcharts
ggplot(mtcars, aes(x = `car name`, y = mpg_z, label = mpg_z)) +
  geom_bar(stat = "identity", aes(fill = mpg_type), width = .5) +
  scale_fill_manual(
    name = "Mileage",
    labels = c("Above Average", "Below Average"),
    values = c("above" = "#00ba38", "below" = "#f8766d")
  ) +
  labs(
    subtitle = "Normalised mileage from 'mtcars'",
    title = "Diverging Bars"
  ) +
  coord_flip()


## Ranking
## Ordered bar Chart

data("mpg")
cty_mpg <- aggregate(mpg$cty, by = list(mpg$manufacturer), FUN = mean)
colnames(cty_mpg) <- c("make", "mileage") # change column names
cty_mpg <- cty_mpg[order(cty_mpg$mileage), ] # sort
cty_mpg$make <- factor(cty_mpg$make, levels = cty_mpg$make) # to retain the order in plot.
head(cty_mpg, 4)

ggplot(cty_mpg, aes(x = make, y = mileage)) +
  geom_bar(stat = "identity", width = .5, fill = "tomato3") +
  labs(
    title = "Ordered Bar Chart",
    subtitle = "Make Vs Avg. Mileage",
    caption = "source: mpg"
  ) +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6))


## Distribution
## Histogram
## When you have lots and lots of data points and want to study where and how the data points are distributed.

g <- ggplot(mpg, aes(manufacturer)) #+ scale_fill_brewer(palette = "Spectral")
g + geom_bar(aes(fill = class), width = 0.5) +
  theme(axis.text.x = element_text(angle = 65, vjust = 0.6)) +
  labs(
    title = "Histogram on Categorical Variable",
    subtitle = "Manufacturer across Vehicle Classes"
  )

## Density Plots
g <- ggplot(mpg, aes(cty))
g + geom_density(aes(fill = factor(cyl)), alpha = 0.8) +
  labs(
    title = "Density plot",
    subtitle = "City Mileage Grouped by Number of cylinders",
    caption = "Source: mpg",
    x = "City Mileage",
    fill = "# Cylinders"
  )
