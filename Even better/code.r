# loads package
library(animint2)

# loads data
data <- read.csv("daily-bike-share.csv")
attach(data)

# getting a description of the data
head(data)
tail(data)
str(data)
summary(data)
dim(data)

# R plot
plot(windspeed, rentals)

# converts workingday column to factor
data$workingday <- factor(x= workingday, levels = c(0, 1), labels = c("False", "True"))

# ggplot viz
scatter <- ggplot()+
  geom_point(
    mapping=aes(x=windspeed, y=rentals, color=workingday),
    data=data)
scatter

# interactive viz with animint
animint(scatter)

# animint plot saved in object Viz
viz <- animint(
  scatter,
  title = "Visualizing Rentals by Windspeed",
  source = "https://learn.microsoft.com/?WT.mc_id=%3Fwt.mc_id%3Dstudentamb_255353"
)
viz

# publish to GH pages
    # dependent packages
    # install.packages("chromote")
    # install.packages("magick")
    # httr2 ...

animint2pages(viz, "animint2")
