library(ggplot2)

head(mpg)

ggplot(mpg, aes(x = displ, y = hwy))+geom_point()
#or
ggplot(mpg, aes(displ, hwy))+geom_point()


ggplot(mpg, aes(displ, cty, colour = class))+geom_point()
#vs
ggplot(mpg, aes(displ, hwy)) + geom_point(aes(colour = "blue"))
ggplot(mpg, aes(displ, hwy)) + geom_point(colour = "blue")

ggplot(mpg,aes(displ,cyl))+
  geom_point()+
  facet_wrap(~class)

ggplot(mpg,aes(displ,hwy))+
  geom_point()+
  geom_smooth()
#Turn off confidence intervals
ggplot(mpg,aes(displ,hwy))+
  geom_point()+
  geom_smooth(se=FALSE)

#Smoothing for n < 1000
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(span = 0.2)
#vs
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(span = 1)

#Smoothing for n > 1000
library(mgcv)
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x))
#vs. linear model
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  geom_smooth(method = "lm")
#vs. robust fiitng algorithm
library(MASS)
ggplot(mpg,aes(displ, hwy))+
  geom_point()+
  geom_smooth(method = "rlm")

#Boxplots and jittering
ggplot(mpg, aes(drv, hwy)) + geom_point()
ggplot(mpg, aes(drv, hwy)) + geom_jitter()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_violin()

#Histogram and frequency polygons
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 5)
ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth=5)
ggplot(mpg, aes(hwy)) + geom_density()


ggplot(mpg, aes(displ, colour = drv))+
  geom_freqpoly(binwidth = 0.5)
ggplot(mpg, aes(displ, fill = drv)) +
  geom_histogram(binwidth = 0.5) +
  facet_wrap(~drv, ncol = 1)

#Bar Charts
ggplot(mpg, aes(manufacturer)) +
  geom_bar()
#The above counts values in each category, to plot the value then
#+ geom_bar(stat = "identity") needs to be used - however, better to use
#+ geom_point()


#Time series with line and path plots
ggplot(economics, aes(date, unemploy / pop)) +
  geom_line()
ggplot(economics, aes(date, uempmed)) +
  geom_line()

ggplot(economics, aes(unemploy / pop, uempmed)) +
  geom_path() +
  geom_point()

year <- function(x) as.POSIXlt(x)$year + 1900
ggplot(economics, aes(unemploy / pop, uempmed)) +
  geom_path(colour = "grey50") +
  geom_point(aes(colour = year(date)))

#Modifying axes
ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1/3)
# Change axis labels
ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1 / 3) +
  xlab("city driving (mpg)") +
  ylab("highway driving (mpg)")
# Remove the axis labels with NULL
ggplot(mpg, aes(cty, hwy)) +
  geom_point(alpha = 1 / 3) +
  xlab(NULL) +
  ylab(NULL)

ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25)
#Modify axes limits
ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25) +
  xlim("f", "r") +
  ylim(20, 30)
# For continuous scales, use NA to set only one limit
ggplot(mpg, aes(drv, hwy)) +
  geom_jitter(width = 0.25, na.rm = TRUE) +
  ylim(NA, 30)

#Output
#assign plot to variable
p <- ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
  geom_point()

print(p)

ggsave("p.png", width = 5, height = 5)

saveRDS(p, "plot.rds")
q <- readRDS("plot.rds")

summary(p)
