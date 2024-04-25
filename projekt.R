library(shiny)
library(ggplot2)
source("functions.R") 
library(gggenes)

##########################UI

ui <- fluidPage(
  titlePanel("NGS of Streptomyces"),
  sidebarLayout( 
    sidebarPanel(tabsetPanel(type="pills",
        
                             
    #pierwsza strona dla ładowanych własnych danych              
        tabPanel("firstpage",
                 fileInput("uploadedgeneset", label = h3("Upload gene set file"), multiple = FALSE, accept = '.txt'),
                 selectInput("select", label = h3("Or choose from database"), 
                             choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                             selected = 1),
        tabsetPanel(type="tabs",
                  tabPanel("firstsubpage",
                           
                           
                           ),
                  
                  tabPanel("Plot$GraphDownload",
                           downloadButton('download_plot', 'Download png plot'),
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

#####################################SERWER


server <- function(input, output) {
  uploaded_file <- reactive({
    inFile <- input$uploadedgeneset
    if (is.null(inFile))
      return(NULL)
    d <- read.csv(inFile, sep=" ")
    return(d)
  })
  
  plotInput <- reactive({
    wgrany_plik <- uploaded_file()
    p <- ggplot(wgrany_plik, aes(xmin = start, xmax = end, y = molecule, fill = gene)) +
      geom_gene_arrow()
    print(p)
  })
  
  
  output$geneplot <- renderPlot({
    if (is.null(input$uploadedgeneset))
      return(NULL)
    print(plotInput())
  })
}
 

shinyApp(ui = ui, server = server)


