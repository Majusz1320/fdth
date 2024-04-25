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
                 selectInput("select", label = h3("Or choose from database"), 
                             choices = c("HupAedgeR", "HupAmacs")),
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
plotInput <- reactive({
  if (input$select == "HupAedgeR")
  {
    plot_data <- read.csv("datasets/data_hupA_chipseq_edgeR.txt", sep=" ") }
    else{
    plot_data <- read.csv("datasets/data_hupAS_chipseq_macs.txt", sep=" ")}
  return(plot_data)
    })

output$geneplot <- renderPlot({
  ggplot(plot_data, aes(xmin = start, xmax = end, y = rodzaj, fill = )) +
    geom_gene_arrow()
})
}

 

shinyApp(ui = ui, server = server)


