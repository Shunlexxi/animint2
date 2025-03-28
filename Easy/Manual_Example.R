# https://rcdata.nau.edu/genomic-ml/animint2-manual/Ch02-ggplot2.html

# loads package
library(animint2)

# creating a Region column, strip unwanted text
data(WorldBank, package = "animint2")
WorldBank$Region <- sub(" (all income levels)",
  "", WorldBank$region,
  fixed = TRUE
)

# subset of data based on year (5 years interval)
WorldBankSome <- subset(WorldBank, year %% 5 == 0)
table(WorldBankSome$year)

# previewing the data (top & bottom)
head(WorldBankSome)
tail(WorldBankSome)

# data dimension - row and column
dim(WorldBankSome)


# Suppose that we are interested to see if there is any relationship between
# life expectancy and fertility rate. We could fix one year, then use those
# two data variables in a scatterplot. Consider the figure below which sketches
# the main components of that data visualization.

plot(WorldBankSome$life.expectancy, WorldBankSome$fertility.rate)

# The sketch above shows life expectancy on the horizontal (x) axis, fertility
# rate on the vertical (y) axis, and a legend for the region. These elements of
# the sketch can be directly translated into R code using the following method.

# First, we need to construct a data table that has one row for every country in
# 1975, and columns named life.expectancy, fertility.rate, and region. The
# WorldBank data already has these columns, so all we need to do is consider the
# subset for the year 1975:

WorldBank1975 <- subset(WorldBank, year == 1975)
head(WorldBank1975)

# The code above prints the data for 1975, which clearly has the appropriate
# columns, and one row for each country. The next step is to use the notes in the
# sketch to code a ggplot with a corresponding aes or aesthetic mapping of data
# variables to visual properties:

scatter <- ggplot() +
  geom_point(
    mapping = aes(x = life.expectancy, y = fertility.rate, color = Region),
    data = WorldBank1975
  )
scatter

# The aes function is called with names for visual properties (x, y, color) and
# values for the corresponding data variables (life.expectancy, fertility.rate,
# region). This mapping is applied to the variables in the WorldBank1975 data
# table, in order to create the visual properties of the geom_point. The ggplot
# was saved as the scatter object, which when printed on the R command line shows
# the plot on a graphics device. Note that we automatically have a region color
# legend.

# Rendering ggplots on web pages using animint
# This section explains how the animint2 package can be used to render ggplots on
# web pages. The ggplot from the previous section can be rendered with animint2,
# by using the animint function.

animint(scatter)

# Exercise: try changing the aes mapping of the ggplot,
scatter2 <- ggplot() +
  geom_point(
    mapping = aes(x = life.expectancy, y = population, color = Region),
    data = WorldBank1975
  )
scatter2


# and then making a new animint. Quantitative variables like population are best
# shown using the x/y axes or point size. Qualitative variables like lending are
# best shown using point color or fill.
scatter3 <- ggplot() +
  geom_point(
    mapping = aes(x = population, y = GDP.per.capita.Current.USD, color = lending),
    data = WorldBank1975
  )
scatter3
animint(scatter3)

# Multi-layer data visualization (multiple geoms)
WorldBankBefore1975 <- subset(WorldBank, 1970 <= year & year <= 1975)
two.layers <- scatter +
  geom_path(
    aes(
      x = life.expectancy,
      y = fertility.rate,
      color = Region,
      group = country
    ),
    data = WorldBankBefore1975
  )
(viz.two.layers <- animint(two.layers))

# dependent packages
# install.packages("chromote")
# install.packages("magick")
# install.packages("httr2")

# publishing scatter 3
viz3 <- animint(
  scatter3,
  title = "Visualizing GDP per Capital by Population and Lending",
  source = "https://rcdata.nau.edu/genomic-ml/animint2-manual/Ch02-ggplot2.html"
)
viz3

animint2pages(
  viz3,
  "animint2",
  owner = NULL,
  commit_message = "Commit from animint2pages",
  private = FALSE,
  required_opts = c("title", "source"),
  chromote_sleep_seconds = NULL
)




# Exercise: try changing the region legend to an income legend.
# Hint: you need to use the same aes(color=income) specification for
# all geoms. You may want to use scale_color_manual with a sequential
# color palette, see RColorBrewer::display.brewer.all(type="seq") and
# read the appendix for more details.
