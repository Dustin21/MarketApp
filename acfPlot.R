acfPlot<-function(TS, ylab = '', ylim=c(-1,1),ggplot2=FALSE, ...)
{
	if (ggplot2) {
		TS.df <- data.frame(time=c(1:length(TS)),value=TS)
		timeSeriesPlot <- ggplot(TS.df,aes(x=time,y=value)) + geom_line(colour = "green") +
			theme(plot.background=element_blank(), panel.background = element_blank(),
						axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
			theme(axis.title.x = element_text(colour = "white"),
						axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white"))
		TS.acf<-acf(TS, plot=FALSE)
		TS.pacf<-pacf(TS, plot=FALSE)
		ci <- 0.95 # 95% confidence level
		clim0 <- qnorm((1 + ci)/2)/sqrt(TS.acf$n.used)
		clim <- c(-clim0,clim0)
		
		hline.data <- data.frame(z=c(0,clim),
														 type=c("base","ci","ci"))
		
		acfPlot <- ggplot(data.frame(lag=TS.acf$lag,acf=TS.acf$acf)) +
			geom_hline(aes(yintercept=z,colour="green",linetype=type),hline.data) +
			geom_linerange(aes(x=lag,ymin=0,ymax=acf), colour = "green") +
			scale_colour_manual(values = c("green","green")) +
			scale_linetype_manual(values =c("solid","dashed")) +
			theme(plot.background=element_blank(), panel.background = element_blank(),
						axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
			theme(axis.title.x = element_text(colour = "white"),
						axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white")) +
			ggtitle("ACF of Spread Ret.")
		
		pacfPlot <- ggplot(data.frame(lag=TS.pacf$lag,pacf=TS.pacf$acf)) +
			geom_hline(aes(yintercept=z,colour=type,linetype=type, colour = "green"),hline.data) +
			geom_linerange(aes(x=lag,ymin=0,ymax=pacf)) +
			scale_colour_manual(values = c("green","green")) +
			scale_linetype_manual(values =c("solid","dashed")) +
			theme(plot.background=element_blank(), panel.background = element_blank(),
						axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
			theme(axis.title.x = element_text(colour = "white"),
						axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white"))
		
		
		acfPlot
		#grid.arrange(timeSeriesPlot, arrangeGrob(acfPlot, pacfPlot, ncol=2),
								 #ncol=1) 
		
		
		
		
	} else {
		op <- par(no.readonly=TRUE) # remember the original
		
		layout(matrix(c(1,1,2,3), 2, 2, byrow=TRUE)) 
		
		plot(TS,ylab=ylab, ...)
		acf(TS, main='Autocorrelations', ylab=ylab,
				ylim=ylim, ci.col = "black")
		pacf(TS, main='Partial Autocorrelations', ylab=ylab,
				 ylim=ylim, ci.col = "black")
		
		par(op) 
	}
	
}

