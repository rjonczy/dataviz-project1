# install
devtools::install_github("hrbrmstr/streamgraph")

library(streamgraph)
library(dplyr)
library(babynames)


# check current version of package
packageVersion("streamgraph")

# -------------------------------------------------------------------------------------
ggplot2::movies %>%
    select(year, Action, Animation, Comedy, Drama, Documentary, Romance, Short) %>%
    tidyr::gather(genre, value, -year) %>%
    group_by(year, genre) %>%
    tally(wt=value) -> dat


streamgraph(dat, "genre", "n", "year", interactive=TRUE) %>%
    sg_axis_x(20, "year", "%Y") %>%
    sg_fill_brewer("PuOr")

# -------------------------------------------------------------------------------------
data <- read.csv("http://bl.ocks.org/WillTurman/raw/4631136/data.csv", stringsAsFactors=FALSE)
data$date <- as.Date(data$date, format="%m/%d/%y")

streamgraph(data, interactive=TRUE) %>% sg_colors("Reds")

# -------------------------------------------------------------------------------------

dat <- read.csv("http://asbcllc.com/blog/2015/february/cre_stream_graph_test/data/cre_transaction-data.csv")

dat %>%
    streamgraph("asset_class", "volume_billions", "year", interpolate="cardinal") %>%
    sg_axis_x(1, "year", "%Y") %>%
    sg_fill_brewer("PuOr")

# -------------------------------------------------------------------------------------


dat %>%
    streamgraph("asset_class", "volume_billions", "year", offset="silhouette", interpolate="step") %>%
    sg_axis_x(1, "year", "%Y") %>%
    sg_fill_brewer("PuOr")


# -------------------------------------------------------------------------------------

dat %>%
    streamgraph("asset_class", "volume_billions", "year", offset="zero", interpolate="cardinal") %>%
    sg_axis_x(1, "year", "%Y") %>%
    sg_fill_brewer("PuOr") %>%
    sg_legend(TRUE, "Asset class: ")

# -------------------------------------------------------------------------------------

dat %>%
    streamgraph("asset_class", "volume_billions", "year", offset="zero", interpolate="step") %>%
    sg_axis_x(1, "year", "%Y") %>%
    sg_fill_brewer("PuOr")

# -------------------------------------------------------------------------------------

# get top 10 names for each year by sex
babynames %>%
    group_by(year, sex) %>%
    top_n(10, n) -> dat1

# just look at female names and get the data for
# the top n by all years to see how they "flow"
babynames %>%
    filter(sex=="F", 
           name %in% dat1$name) -> dat

streamgraph(dat, "name", "n", "year") %>%
    sg_fill_tableau() %>%
    sg_axis_x(tick_units = "year", tick_interval = 10, tick_format = "%Y") %>%
    sg_legend(TRUE, "Name: ")




