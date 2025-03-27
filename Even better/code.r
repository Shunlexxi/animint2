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

# Publishing plot
animint2pages(
  plot.list,
  github_repo,
  owner = NULL,
  commit_message = "Commit from animint2pages",
  private = FALSE,
  required_opts = c("title", "source"),
  chromote_sleep_seconds = NULL,
  ...
)