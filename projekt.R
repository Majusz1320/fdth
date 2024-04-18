library(shiny)
library(ggplot2)
source("functions.R") 

ui <- fluidPage(
  titlePanel("NGS of Streptomyces"),
  sidebarLayout( 
    sidebarPanel(tabsetPanel(type="pills",
        
                             
    #pierwsza strona dla ładowanych własnych danych              
        tabPanel("firstpage",
        fileInput("sekwencja", "Choose fasta file.", multiple = FALSE, accept = '.fasta'),
        numericInput('window_size', 'Width of the read window.', 1000, min = 10, max = 1000000000),
        numericInput('window_by', 'Width of the window slide.', 10, min = 1, max = 10000),
        tabsetPanel(type="tabs",
                  tabPanel("firstsubpage"),
                  tabPanel("secondsubPanel")),
        
        downloadButton('download_histogram', 'Download png plot'),
        numericInput('width_hist', 'Plot width [cm]', 20, min = 5, max = 25),
        numericInput('height_hist', 'Plot height [cm]', 14, min = 5, max = 25),
        numericInput('res_hist', 'Resolution', 200, min = 100, max = 500)),
        
    #druga strona ustawień, może miejsce do wyboru danych zaimplementwanych
        tabPanel("secondpage",
        
                 ))),
    
    #głowny panel
        mainPanel(tabsetPanel(type="pills", 
                          tabPanel("Genes&stuff", ),
                          tabPanel("Results summary"),
                          tabPanel("Help&Info")
                                   )
                          )
    )
)




server <- function(input, output) {}
 

shinyApp(ui = ui, server = server)


