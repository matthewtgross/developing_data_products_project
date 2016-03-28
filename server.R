library(shiny)
library(lubridate)
library(ggplot2)
library(dplyr)
library(plyr)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  # You can access the value of the widget with input$text, e.g.
  output$value <- renderPrint({ input$text })
    
  output$distPlot <- renderPlot({
    #x    <- faithful[, 2]  # Old Faithful Geyser data
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')

    
    file <- "http://www.powerball.com/powerball/winnums-text.txt"
    fileURL <- url(file)
    data <- read.fwf(file = file, skip = 1, widths = c(10,-2,2,-2,2,-2,2,-2,2,-2,2,-2,2,-2,2))
    unlink(file)
    names(data) <- c("date","WN1","WN2","WN3","WN4","WN5","PB","Multiplier")
    data$date <- mdy(data$date)
    
    data <- mutate(data, winning_number = paste(WN1,WN2,WN3,WN4,WN5,PB,sep="-"))
    
    
    
    numbers <- as.data.frame(seq(1,69,1))
    names(numbers) <- "numbers"
    
    wn1 <- count(data,"WN1")
    names(wn1) <- c("numbers","wn1")
    wn2 <- count(data,"WN2")
    names(wn2) <- c("numbers","wn2")
    wn3 <- count(data,"WN3")
    names(wn3) <- c("numbers","wn3")
    wn4 <- count(data,"WN4")
    names(wn4) <- c("numbers","wn4")
    wn5 <- count(data,"WN5")
    names(wn5) <- c("numbers","wn5")
    pb <- count(data,"PB")
    names(pb) <- c("numbers","pb")
    m <- count(data,"Multiplier")
    names(m) <- c("numbers","Multiplier")
    
    numbers <- join(numbers,wn1,by = "numbers")
    numbers <- join(numbers,wn2,by = "numbers")
    numbers <- join(numbers,wn3,by = "numbers")
    numbers <- join(numbers,wn4,by = "numbers")
    numbers <- join(numbers,wn5,by = "numbers")
    numbers <- join(numbers,pb,by = "numbers")
    numbers <- join(numbers,m,by = "numbers")
    
    n <- as.data.frame(numbers)
    
    n <- n[is.na(n)] <- 0
    
    fn <- mutate(numbers, ttl = ifelse(is.na(wn1),0,wn1)
                 + ifelse(is.na(wn2),0,wn2)
                 + ifelse(is.na(wn3),0,wn3)
                 + ifelse(is.na(wn4),0,wn4)
                 + ifelse(is.na(wn5),0,wn5))
    
    fn <- mutate(fn, top_n = ifelse(ttl >= 193,1,0))
    
    fn <- filter(fn,ttl > input$bins)
    
    ggplot(fn, aes(x=factor(numbers), y=ttl,fill=factor(top_n))) + geom_bar(stat="identity")
    
    
    
    
  })
})
