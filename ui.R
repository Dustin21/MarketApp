shinyUI(fluidPage(theme = "bootstrap.css",
											 
	titlePanel(h1("Market App")),
		
	sidebarLayout(
		
		sidebarPanel( 
			
			fluidRow(
			h4(div("Choose stock A", style = "color:lightgreen")),
			
			textInput("symbol1",
								label = "Input ticker symbol:", 
								value = "RDS-A"),
			
			selectInput("source1", "Select the data source:",
									choices = c("yahoo", "google", "FRED", "Oanda", "MySQL", "csv", "RData"),
									selected = "yahoo"),
						
			br(),
			
			h4(div("Choose stock B", style = "color:orange")),
			
			textInput("symbol2",
								label = "Input ticker symbol:", 
								value = "RDS-B"),
			
			selectInput("source2", "Select the data source:",
									choices = c("yahoo", "google", "FRED", "Oanda", "MySQL", "csv", "RData"),
									selected = "yahoo"),
			
			
			br(),
			
			h4("General Parameters"),
			
			dateRangeInput("dates", 
										 "Date range:",
										 start = "2006-01-01", 
										 end = as.character(Sys.Date()),
										 min = "1950-01-01",
										 max = as.character(Sys.Date())),
			
			br(),
			
			
			sliderInput("freq", "Choose Frequency for Decomposition:", min = 5, max = 365, value = 30, animate = TRUE),
			
			br(),
						
			img(src = "bigorb.png", height = 60, width = 60), actionButton("get", "Press to Begin") 
			
			
		
			)
									
									),
			
			
		mainPanel( 
			
			mainPanel(
				
				
				tabsetPanel(
					tabPanel("Intro", 
									 
									h4("Welcome to the Market App.", style = "color:lightblue"), 
									 
									 br(),
									p("This App is very versatile and enables
									 	you to compare and contrast two sources of time-series data by simply inputting their
									 	ticker symbols! The financial and/or economic data may be retrieved from a veriety of 
										sources, including Yahoo, FED, Oanda and more. You can even compare different types of 
										data from
										different sources (not just financial). If you are interested in two particular stocks, we have also provided
										you with a level of cointegration among the stock pair and a simple hedging ratio so you can
									 	be sure you're mitigating your risk."),
									 
									 p("To begin, please follow the simple steps:"),
									 
									 tags$ol(
									 	tags$li("Choose two ticker symbols corresponding to time-series data you wish to compare"), 
									 	tags$li("Select the date range of interest"), 
									 	tags$li("Adjust the frequency to analyse different periodicities while under a stock's
									 					decomposition tab"),
									 	tags$li("Simply click the", span("Press to Begin", style = "color:blue"), "button to analyse your data, and
									 					select a tab!") 
									 ),
									
									 strong("Precautions", style = "color:red"),
									 
									 tags$ul(
									 	tags$li("Some data will not have enough data for your date range, thereby outputting an error. Simply 
									 	adjust the date that corresponds with the amount of data available.", style = "color:red"), 
									 	tags$li("This App has yet to be fully tested, and may have issues with certain data types.", style = "color:red"), 
									 	tags$li("In some occations the App may take some time to load, so please be patient." , style = "color:red")
									 ),
									
									 br(),
									 div("Be aware that", span("Stock A", style = "color:lightgreen"), "will be denoted
									 		in", span("green", style = "color:lightgreen"), "while", span("Stock B", style = "color:orange"),
									 		"will be denoted in", span("orange.", style = "color:orange")),
									 br(),
									 p("Let's get started!"), img(src = "app_stock.png", height = 60, width = 60)
									 
									 ), 
					tabPanel("Cointegration", plotOutput("plot")), 
					tabPanel("Stock A", plotOutput("plotA")),
					tabPanel("A Decomposition", plotOutput("plotADecomp"), 
									 br(),
									 tags$ul(
									 	tags$li(helpText("Adjust the frequency to identify any noticable periodicity in real-time.",
									 				 style = "color:lightblue"))
									 )),
					
					tabPanel("Stock B", plotOutput("plotB")),
					tabPanel("B Decomposition", plotOutput("plotBDecomp"),
									 tags$li(helpText("Adjust the frequency to identify any noticable periodicity in real-time.",
									 								 style = "color:lightblue")
					)),
					tabPanel("Diagnostics", plotOutput("plotD")), 
					
					tabPanel("Hedging", verbatimTextOutput("Hedging"))
					
				),
				width = 11)
		)
	)
))
			
