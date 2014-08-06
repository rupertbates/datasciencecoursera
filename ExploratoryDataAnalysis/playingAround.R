library(lattice)
library(datasets)
data(airquality)
p <- bwplot(Ozone ~ Wind | factor(Month), data = airquality)


library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

if(!require(ggplot2))
  install.packages("ggplot2")
library(ggplot2)
library(datasets)
data(airquality)
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)

qplot(votes, rating, data = movies)

qplot(votes, rating, data = movies) + geom_smooth()

good <- movies[movies$ratings > 9.5, ]

qplot(rating, data=movies)





xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...) ## First call the default panel function for 'xyplot' panel.abline(h = median(y), lty = 2) ## Add a horizontal line at the median
})