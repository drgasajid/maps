#data import
library(readxl)
df <- read_excel("vetmeta_country.xlsx") #our data for country map
View(df)

#call libraries
library("ggplot2")
theme_set(theme_bw())
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world) # calling world map data in sf

#mixing two data
wdf <- left_join(world, df, by="name") #mixing own data with world data
View(wdf)
str(wdf)

#plotmap
map1 <- ggplot(data = wdf) +
  geom_sf(color = "grey50", fill = "lightgreen") + # base plain map
  theme(panel.grid.major = element_line(color = gray(0.5),
                                        linetype = "dashed", size = 0.5),
        panel.background = element_rect(fill = "aliceblue")) +
  geom_sf_label(aes(label = numbers), label.padding = unit(1, "mm"),
                label.size  = 0.2, alpha = 0.5) +  # adding own numbers on countries
  xlab("Longitude") + ylab("Latitude") + ggtitle("Meta-Analysis studies published across the world (2002-2022")
                      
map1
ggsave("vetmapmeta2.png", units="in", width=14, height =10, dpi = 300) # saving file

#bargraph
vet_meta1 <- read_excel("vet_meta1.xlsx")
View(vet_meta1)

#draw bargraph
plot1 <- ggplot(data=vet_meta1, aes(x=year, y=no)) +
  geom_bar(stat="identity", fill="lightgreen") +
  geom_text(aes(label=no), vjust=1.6, color="black", size=5.0) +
  theme(axis.text.x = element_text(angle=45, color="black", 
                                   size=12),
        axis.text.y = element_text(color="black", 
                                   size=12)) +
  scale_x_continuous(name="Year", breaks = c(2002, 2004, 2006,
                                             2008, 2010, 2012,
                                             2014, 2016, 2018,
                                             2020, 2022)) +
  scale_y_continuous(name="Number of Meta-Analysis published in the Vet. field")

plot2 <- plot1 + theme(panel.background=element_blank(),
                       panel.border=element_blank(),
                       panel.grid.major=element_blank(),
                       panel.grid.minor=element_blank(),
                       plot.background= element_blank())

plot2

My_Theme = theme(
  axis.title.x = element_text(size = 16),
  axis.text.x = element_text(size = 12),
  axis.title.y = element_text(size = 16))

plot2 + My_Theme
ggsave("vetmetayear2.png", units="in", width=14, height =10, dpi = 300)
