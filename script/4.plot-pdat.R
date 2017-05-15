library(tidyverse)
library(lubridate)
library(stringr)
library(scales)
library(plotly)

plotList = lapply(Sys.glob('medline/*.edat.txt'), function(file) {
    edat <- ymd(readLines(file))
    p <- data_frame(date = edat) %>%
        count(date) %>%
        mutate(wday = wday(date, label = TRUE, abb = FALSE)) %>%
        ggplot(aes(x = date, y = n, wday = wday)) +
        geom_bar(stat = 'identity') +
        scale_x_date(labels = date_format("%B")) +
        ylab("publications") +
        ggtitle(str_extract(file, '(?<=medline/)[^.]*'))
    ggplotly(p)
})
names(plotList) = str_extract(Sys.glob('medline/*.edat.txt'),
                              '(?<=medline/)[^.]*')
subplot(plotList, nrows = 3, shareX = TRUE) %>% layout(title = '')
