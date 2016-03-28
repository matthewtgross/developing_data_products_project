library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Devoloping Data Products Project by Matt Gross"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    
    sidebarPanel(

      # Copy the line below to make a text input box
      textInput("text", label = h3("Favorite Number:"), value = "7"),
      
#      dateRangeInput('dateRange2',
#                     label = 'Date Range of Winning Lottery Numbers:',
#                     start = as.Date('1997-11-01'), end = Sys.Date() - 1,
#                     min = as.Date('1997-11-01'), max = Sys.Date() - 1,
#                     separator = " - ", format = "yyyy-mm-dd",
#                     startview = 'year', language = 'en', weekstart = 1
#      ),
#      
#      hr()
#      fluidRow(verbatimTextOutput("value")
#      ),
      
      sliderInput("bins",
                  "Min Number Occurance:",
                  min = 1,
                  max = 200,
                  value = 125)
    ),

    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
)