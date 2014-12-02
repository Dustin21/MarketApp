CointegrationTest <- function(stockPairs){
	#Pass in a pair of stocks and do the necessary checks to see if it is cointegrated
	source("acfPlot.R")
	time <- time(stockPairs$a)
	
	dev.new()

	
	#Step 1: Calculate the daily returns
	dailyRet.a <- na.omit((Delt(stockPairs$a,type="arithmetic")))
	dailyRet.b <- na.omit((Delt(stockPairs$b,type="arithmetic")))
	dailyRet.a <- dailyRet.a[is.finite(dailyRet.a)]
	dailyRet.b <- dailyRet.b[is.finite(dailyRet.b)]
	
	
	#Step 2: Regress the daily returns onto each other
	regression <- lm(dailyRet.a ~ dailyRet.b + 0)
	beta <- coef(regression)[1]
	print(paste("The beta or Hedge Ratio is: ",format(beta, digits = 4)),sep="",)
	
	#Step 3: Use the regression co-efficients to generate the spread
	spread <- stockPairs$a - beta*stockPairs$b
	spreadRet <- Delt(spread,type="arithmetic")
	spreadRet <- na.omit(spreadRet)
	
	
	#Step 4: Use the ADF to test if the spread is stationary
	adfResults <- adf.test((spread),k=0,alternative="stationary")
	
	print(adfResults)
	if(adfResults$p.value <= 0.05){
		print(paste("The spread is likely Cointegrated with a pvalue of ",format(adfResults$p.value),sep=""))
	} else {
		print(paste("The spread is likely NOT Cointegrated with a pvalue of ",format(adfResults$p.value, digits = 4),sep=""))
	}
	
	
	dFrame1 <- data.frame(dailyRet.b, dailyRet.a)
	colnames(dFrame1) <- c("b", "a")
	p1 <- ggplot(dFrame1, aes(b,a)) + geom_point(colour = "skyblue", alpha = 0.3) + geom_smooth(method='lm', colour = "green") +
		theme(plot.background=element_blank(), panel.background = element_blank(),
					axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
		theme(axis.title.x = element_text(colour = "white"),
					axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white")) +
		ggtitle("Reg of Returns for Stock A & B")
	
	dFrame2 <- data.frame(time(spreadRet), spreadRet)
	colnames(dFrame2) <- c("time", "spread")
	p2 <- ggplot(dFrame2, aes(time, spread)) + geom_line(colour = "green") +
		theme(plot.background=element_blank(), panel.background = element_blank(),
					axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
		theme(axis.title.x = element_text(colour = "white"),
					axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white")) +
		ggtitle("Spread Returns")
	
	dFrame3 <- data.frame(time(spread), spread)
	colnames(dFrame3) <- c("time", "spreadR")
	p3 <- ggplot(dFrame3, aes(time, spreadR)) + geom_line(colour = "green") + 
		theme(plot.background=element_blank(), panel.background = element_blank(),
					axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
		theme(axis.title.x = element_text(colour = "white"),
					axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white")) +
		ggtitle("Spread Actual")
	
	p4 <- acfPlot(dFrame2[,2], ggplot2 = TRUE)
	
	grid.arrange(arrangeGrob(p1, p2, ncol=2), arrangeGrob(p3, p4, ncol=2),
							nrow = 2, ncol=1) 
	
	#pushViewport(viewport(layout = grid.layout(2, 2)))
	#print(p1, vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
	#print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
	#print(p3, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
	#print(p4, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))

	
}









