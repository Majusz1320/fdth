library(shiny)
library(ggplot2)
source("functions.R") 
library(gggenes)

ui <- fluidPage(
  titlePanel("NGS of Streptomyces"),
  sidebarLayout( 
    sidebarPanel(tabsetPanel(type="pills",
        
                             
    #pierwsza strona dla ładowanych własnych danych              
        tabPanel("firstpage",
                 fileInput("file", label = h3("Upload gene set file")),
                 selectInput("select", label = h3("Or choose from database"), 
                             choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                             selected = 1),
        tabsetPanel(type="tabs",
                  tabPanel("firstsubpage",
                           
                           
                           ),
                  
                  tabPanel("Plot$GraphDownload",
                           downloadButton('download_histogram', 'Download png plot'),
                           numericInput('width_hist', 'Plot width [cm]', 20, min = 5, max = 25),
                           numericInput('height_hist', 'Plot height [cm]', 14, min = 5, max = 25),
                           numericInput('res_hist', 'Resolution', 200, min = 100, max = 500)))),
        
       
        
    #druga strona ustawień, może miejsce do wyboru danych zaimplementwanych
        tabPanel("secondpage",
        
                 ))),
    
    #głowny panel
        mainPanel(tabsetPanel(type="pills", 
                          tabPanel("Genes&stuff",
                                   plotOutput("geneplot")
                                   ),
                          tabPanel("Results summary"),
                          tabPanel("Help&Info")
                                   )
                          )
    )
)




server <- function(input, output) {
  wgranyplik <- reactive({
    inFile <- input$sekwencja
    if (is.null(inFile))
      return(NULL)
    d <- seqinr::read.fasta(inFile$datapath)
    return(d)
  })
  
  plotInput <- reactive({
    p <- geneplot_funtion
    print(p)
  })
}
 

shinyApp(ui = ui, server = server)


