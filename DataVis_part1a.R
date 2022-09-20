## ---------------------------
##
## Script name: DataVis_part1
##
## Purpose of script:Training on Data visualization
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
## Data Visualization
## R Workshop
## Basics of ggplot
## ---------------------------



## Required Packages for creating plots

install.packages("ggplot2")
install.packages("RColorBrewer")

## lets call these packages
library(ggplot2)
library(RColorBrewer)


## learn more about color codes
## https://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3


## Sometimes we dont need scientific notations and
## we can turn off scientific notation like 1e+06

options(scipen = 999)

## Read the dataset using read.csv()
## reading csv file which is availble online

midwest <- read.csv("http://goo.gl/G1K41K")
head(midwest)

## mpg dataset is availble in ggplot package
## on executing the next line you will see the dataset mpg in your environment (values)

data(mpg, package = "ggplot2")

## on clicking the mpg in values it will be shown in environment (data)


##### Crate a ggplot #####

## Initialize a ggplot

## ggplot(data = <DATA>, aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()

## Time to add the graphical representations of our data
## We will accomplish this by using geom_ commands,
## there are many to choose from but we will stick to some of the most common ones today.

## aes: describing which variables in the layer data
## should be mapped to which aesthetics used by the paired geom/stat

ggplot(midwest, aes(x = area, y = poptotal))

## A blank ggplot is drawn. Even though the x and y are specified, there are no points or lines in it.
## This is because, ggplot doesn’t assume that you meant a scatterplot or a line chart to be drawn.



ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point()

## WHAT IS MISSING IN THIS PLOT
## WHAT IS WIERD ??
## CAN WE MAKE IT MORE VISAULLY APPLEALING


## lacks some basic components such as the plot title, meaningful axis labels etc
## let’s just add a smoothing layer using geom_smooth(method='lm').
## Since the method is set as lm (short for linear model), it draws the line of best fit.

g <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point() +
  geom_smooth(method = "lm") # set se=FALSE to turnoff confidence bands
plot(g)

###### TRY THIS #####
## Can you find out what other method options are available for geom_smooth?
## and implement it on mpg data and save it in a object try


## Adjusting the X and Y axis limits
## Delete the points outside the limits

g <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point() +
  geom_smooth(method = "lm")
g <- g + xlim(c(0, 0.1)) + ylim(c(0, 1000000)) # deletes points


## the chart was not built from scratch but rather was built on top of g.

g <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point() +
  geom_smooth(method = "lm") # set se=FALSE to turnoff confidence bands

## Zoom in without deleting the points outside the limits.
## As a result, the line of best fit is the same as the original plot.

g1 <- g + coord_cartesian(xlim = c(0, 0.1), ylim = c(0, 1000000)) # zooms in
plot(g1)

## Change the Title and Axis Label
g <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point() +
  geom_smooth(method = "lm") # set se=FALSE to turnoff confidence bands
g1 <- g + coord_cartesian(xlim = c(0, 0.1), ylim = c(0, 1000000)) # zooms in

## Add Title and Labels
g1 + labs(title = "Area Vs Population", subtitle = "From midwest dataset", y = "Population", x = "Area", caption = "Midwest Demographics")

## or
g1 + ggtitle("Area Vs Population", subtitle = "From midwest dataset") + xlab("Area") + ylab("Population")



## Change the Color and Size To Static

ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point(col = "steelblue", size = 3) + ## Set static color and size for points
  geom_smooth(method = "lm", col = "firebrick") + ## change the color of line
  coord_cartesian(xlim = c(0, 0.1), ylim = c(0, 1000000)) +
  labs(title = "Area Vs Population", subtitle = "From midwest dataset", y = "Population", x = "Area", caption = "Midwest Demographics")


## Change the Color To Reflect Categories in Another Column?
## any information that is part of the source dataframe has to be specified inside the aes() function.

gg <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point(aes(col = state), size = 3) + # Set color to vary based on state categories.
  geom_smooth(method = "lm", col = "firebrick", size = 2) +
  coord_cartesian(xlim = c(0, 0.1), ylim = c(0, 1000000)) +
  labs(title = "Area Vs Population", subtitle = "From midwest dataset", y = "Population", x = "Area", caption = "Midwest Demographics")
plot(gg)

## Now each point is colored based on the state it belongs because of aes(col=state).
## Not just color, but size, shape, stroke (thickness of boundary) and fill (fill color) can be used to discriminate groupings.

gg + theme(legend.position = "None")
gg + scale_colour_brewer(palette = "Set1")
head(brewer.pal.info, 10)


## Lets recreate thing for the plot based on mpg data, object was stored in try
## color,size,shape, palette
## 10 MINS


## The breaks on the axis should be of the same scale as the X axis variable.
## Note that I am using scale_x_continuous because, the X axis variable is a continuous variable.
## Like scale_x_continuous() an equivalent scale_y_continuous() is available for Y axis.

gg <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point(aes(col = state), size = 3) + # Set color to vary based on state categories.
  geom_smooth(method = "lm", col = "firebrick", size = 2) +
  coord_cartesian(xlim = c(0, 0.1), ylim = c(0, 1000000)) +
  labs(title = "Area Vs Population", subtitle = "From midwest dataset", y = "Population", x = "Area", caption = "Midwest Demographics")

# Change breaks
gg + scale_x_continuous(breaks = seq(0, 0.1, 0.01))

## Customize the Entire Theme in One Shot using Pre-Built Themes
gg <- ggplot(midwest, aes(x = area, y = poptotal)) +
  geom_point(aes(col = state), size = 3) + # Set color to vary based on state categories.
  geom_smooth(method = "lm", col = "firebrick", size = 2) +
  coord_cartesian(xlim = c(0, 0.1), ylim = c(0, 1000000)) +
  scale_x_continuous(breaks = seq(0, 0.1, 0.01)) +
  labs(title = "Area Vs Population", subtitle = "From midwest dataset", y = "Population", x = "Area", caption = "Midwest Demographics")

## Adding theme Layer itself.
gg + theme_bw() + labs(subtitle = "BW Theme")
gg + theme_classic() + labs(subtitle = "Classic Theme")

## For more customized and fancy themes have a look at the ggthemes package and the ggthemr package.

### Resources
## pch
# http://www.sthda.com/english/wiki/r-plot-pch-symbols-the-different-point-shapes-available-in-r

## ggplot colors
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

## ggplot cheat sheet
# https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf

## r graphics cookbok
# https://r-graphics.org/

## print out your plots!
# https://twitter.com/skyetetra/status/1402267922404282368?s=20
