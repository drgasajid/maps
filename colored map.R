#data import
library(readxl)
df <- read_excel("vetmeta_country.xlsx")
View(df)

#call libraries
library(maps)
library(ggplot2)
library(tidyverse)
library(ggsci)
library(RColorBrewer)
library(viridis)
library(magick)
library(cowplot)
library(sf)

#call world map data 1
mapdf1 <- read_excel("vetmeta_country.xlsx", 
                              sheet = "Sheet1")
View(mapdf1)

mapdf3 <- left_join(mapdf1, df, by="region")
View(mapdata2)
View(mapdf3)


#call world map data 2
mapdf2 <- map_data("world") #ggplot2
View(mapdf2)

#join both data sets (base data and map data)
mapdata2 <- left_join(mapdf2, df, by="region")
View(mapdata2)

mapdata2$numbers <- as.factor(mapdata2$numbers)
#draw map
map1 <-ggplot(mapdata2, aes( x = long, y = lat, group= group)) +
  geom_polygon(fill = "grey50", color = "white") +
  theme(text=element_text(size=20)) +
  labs(title = "") +
  coord_equal() +
  theme(legend.key.size = unit(1, 'cm'))
map1

#refine map
map2 <- map1 + theme(axis.line=element_blank(),
                     axis.text.x=element_blank(),
                     axis.text.y=element_blank(),
                     axis.ticks=element_blank(),
                     axis.title.x=element_blank(),
                     axis.title.y=element_blank(),
                     panel.background=element_blank(),
                     panel.border=element_blank(),
                     panel.grid.major=element_blank(),
                     panel.grid.minor=element_blank(),
                     plot.background= element_blank())
map2

#draw numbers on map
map3 <- map2 + geom_text(data = mapdf3, aes(label = numbers, x = long, y = lat, group = NULL), 
            size = 3, color = 'black', fontface = 'bold')

map3
ggsave("vetmapmeta.png", units="in", width=14, height =10, dpi = 300)
#Draw bargraph 
vet_meta1 <- read_excel("vet_meta1.xlsx")
View(vet_meta1)

#draw bargraph
plot1 <- ggplot(data=vet_meta1, aes(x=year, y=no)) +
  geom_bar(stat="identity", fill="grey50") +
  geom_text(aes(label=no), vjust=1.6, color="black", size=3.5) +
  theme(axis.text.x = element_text(angle=45),
        axis.text.y = element_text()) +
  scale_x_continuous(name="Year", breaks = c(2002, 2004, 2006,
                                             2008, 2010, 2012,
                                             2014, 2016, 2018,
                                             2020, 2022)) +
  scale_y_continuous(name="Number of Meta-Analysis published")

plot2 <- plot1 + theme(panel.background=element_blank(),
           panel.border=element_blank(),
           panel.grid.major=element_blank(),
           panel.grid.minor=element_blank(),
           plot.background= element_blank())

plot2
ggsave("vetmetayear.png", units="in", width=14, height =10, dpi = 300)

