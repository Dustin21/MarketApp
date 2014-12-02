library("quantmod")
library("PerformanceAnalytics")
library("fUnitRoots")
library("tseries")
library("ggplot2")
library("grid")
library("gridExtra")
library("reshape2")
source("helpers.R")
source("na.stinterp.R")
source("quickTSPlots.R")
source("decomp.R")
source("acfPlot.R")
source("TSplot.R")

shinyServer(function(input, output) {
	
	dat1 <- reactive({
		if(input$get == 0) return(NULL)
		
		getSymbols(input$symbol1, src = input$source1, 
							 from = input$dates[1], to = input$dates[2],
							 auto.assign = FALSE)[,if(input$source1 == "yahoo") 6 else 1]
	})
	
	dat2 <- reactive({
		if(input$get == 0) return(NULL)

		getSymbols(input$symbol2, src = input$source2, 
							 from = input$dates[1], to = input$dates[2],
							 auto.assign = FALSE)[,if(input$source2 == "yahoo") 6 else 1]
	})
	

	dataInput <- reactive({ 
		
		list(a = as.numeric(dat1())
			,b = as.numeric(dat2()[1:length(dat1()),])
			)
	})
	
	
	output$plot <- renderPlot({
		
		if(input$get == 0) return(NULL)
		
		df <- data.frame(dataInput()$a, dataInput()$b)
		colnames(df) <- c("a", "b")
		ggplot(df, aes(time(a),a)) + geom_line(colour = "green") + 
			geom_line(aes(time(b), b), colour = "darkorange") + 
			ylab("Stock #1 and Stock #2") +
			xlab("Time") +
			ggtitle("Adj. Closing Prices of Stock A and B") +
			theme(plot.background=element_blank(), panel.background = element_blank(),
						axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
			theme(axis.title.x = element_text(colour = "white"),
						axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white")) +
			scale_colour_discrete(name  ="Stocks",
														breaks=c("a", "b"),
														labels=c("Stock A", "Stock B"))
		}, bg="transparent")
	
	
	

	output$plotA <- renderPlot({
		if(input$get == 0) return(NULL)
		quickTSPlots(diff(dataInput()$a), ggplot2 = TRUE)
	}, bg="transparent")
	
	output$plotADecomp <- renderPlot({
		if(input$get == 0) return(NULL)
		decomp(dataInput()$a, frequency = input$freq)
	}, bg="transparent")
	
	output$plotB <- renderPlot({
		if(input$get == 0) return(NULL)
		TSPlot(diff(dataInput()$b), ggplot2 = TRUE)
	}, bg="transparent")
	
	output$plotBDecomp <- renderPlot({
		if(input$get == 0) return(NULL)
		decomp(dataInput()$b, frequency = input$freq, col = "darkorange")
	}, bg="transparent")
	
	output$plotD <- renderPlot({
		if(input$get == 0) return(NULL)
		CointegrationTest(dataInput())
	}, bg="transparent")
	
	output$Hedging <- renderPrint({
		if(input$get == 0) return(NULL)
		CointegrationTest(dataInput())
	})
	
	
})