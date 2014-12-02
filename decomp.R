decomp <- function(series,frequency, col = "green"){
	x <- na.stinterp(series)   #this is for interpolation
	x1 <- ts(x,start=01,freq=frequency) #converting into a ts object
	x2 <- stl(x1,s.window="periodic") #performing stl on the ts object
	x3<- data.frame(x,x2$time.series) #creating a data.frame
	x3$index <- index(x3)  #create an id
	colnames(x3)[1] <- "time-series" 
	x4 <- melt(x3,id.vars="index")   #melt the dataframe into long format 
	ggplot(x4,aes(index,value,group=variable)) + geom_line(alpha=0.7, colour = col, size = 1) + 
		facet_grid(variable ~., scales="free")  + xlab("Timesteps") + ylab("values") +
		theme(plot.background=element_blank(), panel.background = element_blank(),
					axis.line = element_line(colour = "white"), panel.grid.minor = element_blank()) +
		theme(axis.title.x = element_text(colour = "white"),
					axis.title.y = element_text(colour = "white"), plot.title = element_text(colour = "white"))
	}
	