library(shiny)
library(tidyverse)
library(leaflet)
library(bslib)
library(janitor)

# url for data
# "https://www.seanoe.org/data/00501/61229/data/64809.csv"
path <- "C:/Users/chaza/Documents/developing-data-products-course/week4-final-project/jellyfish.csv"

df <- read_csv2(path, locale = locale(decimal_mark = ',')) %>%
  janitor::clean_names() %>% 
  mutate_all(~replace(., . == -9999, NA)) %>% 
  mutate(year = as.Date(as.character(year), format = "%Y"),
         year = format(year, "%Y")) %>% 
  select_if(function(x) !(all(is.na(x)) | all(x == "") | all(x == 0)))

JellyfishIcon <- makeIcon(
  iconUrl = "jellyfish.png",
  iconWidth = 30, iconHeight = 30
)

function(input, output, session) {

  my_reactive_df <- reactive(df %>%
                               select(latitude, longitude, input$species) %>%
                               rename('selected_species' = input$species) %>% 
                               filter(selected_species > 0))
  
  output$plot <- renderLeaflet({
    
    my_reactive_df() %>% 
      leaflet() %>%
      addTiles() %>%
      addMarkers(lng = ~longitude, lat = ~latitude, icon = JellyfishIcon)
    
  })
  
  output$summary <- renderTable({
    my_reactive_df() %>% 
      summarise(N = length(selected_species),
                mean = mean(selected_species, na.rm = TRUE),
                median = median(selected_species, na.rm = TRUE),
                sd = sd(selected_species, na.rm = TRUE),
                se = sd / sqrt(N))
  })
  
  output$plot_histogram <- renderPlot({
    my_reactive_df() %>% 
      ggplot(aes(x = selected_species)) +
      geom_histogram(fill = "#2FA4E7", alpha = .7) +
      labs(x = 'individuals \nper cubic meters') +
      theme_minimal() +
      theme(plot.background = element_rect(color = "transparent", fill = "transparent"),
            panel.background = element_rect(color = "transparent", fill = "transparent"))
  })
}
