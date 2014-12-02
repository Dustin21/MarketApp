Market App
===========

Building this App was exciting - the sheer ability to create something of your own to interact with was quite amazing for me. It is for this reason that time just flew by, with Jenny likely wondering if I was ever going to get my homework up in time (I did by an hour).

The purpose of this app was that I wanted to create something that intertwined my two areas of interest, namely Statistics and Finance. The Market App enables you to pull all sorts of market data from various sources, including:

* [Yahoo Finance](https://ca.finance.yahoo.com/) - a plethora of financial data.
* The [Federal Reserve Bank of St. Louis (FED)](http://research.stlouisfed.org/fred2/) - for all your economic data.
* [Oanda](http://www.oanda.com/) - to get your FOREX data.
* Much more, including your own data!

This means you can compare economic indicators with financial data, or analyse the FOREX markets with ease. Types of analyses provided in the app are general trends, seasonalities, cointegration of two stocks, and a hedging ratio to mitigate porfolio risk. Some features of the app are not yet added, such as tables summarising the data in question (historical volatility, GARCH fits, projections, and trends), although all figures are nearly fully functional. Some parts may be slow and some code are likely less efficient than some other methods, but hopefully you will find some use in the app!

Check out the [Market App](https://dustin21.shinyapps.io/MarketApp/) for further instructions and details.

### Reflections
This homework was tedious, but rewarding. I had many issues as I moved along into more complicated areas. First, you may notice that I have some help functions that are nearly the same, with minor differences, or some attributes commented out. The reason for this was that I attempted to create a function that accomplished everything, such as plotting and print output in one go, but Shiny did not like this. I had to adjust my functions to suit the specific need of `renderPlot` or `renderPrint`, for instance, and resave them to get everything running as I wanted. The same issue occured with `quickTSPlots.R` and setting a seperate variable in the function to select plot colour. To get this working, I had to resave the same function twice, with the only difference being the plot colour. I am sure there are much more efficient ways of solving this problem, but I was happy to get this working in the end nonetheless. If anyone has insight into this, please enlighten me.

Another issue I ran into was resizing the `tabPanel`. Initially, my outputted figures were far too small. I was finally able to resolve this by adding `,width = 11` after the `tabsetPanel` code and before closing the `mainPanel`. Most of the issues I ran into pertained to the HTML layout I wanted to achieve, some of which were a little finicky.

Thirdly, I wanted a button that initiated the inputs when clicked, so that things weren't changing as you were typing (this can make the experience rather laggy or choppy). I was able to figure out a quick fix using an `actionButton` and typing `if(input$get == 0) return(NULL)` before each output that depended on the input. This worked for the initial startup, but works intermittantly after the first click. I would like to find a better way to resolve this issue.

Finally, I had a difficult time pulling in data from different sources with different dimensions, while automating the whole process. So far, things seem to run okay, but there is some trouble when data simply doesn't match from different sources, leading to an error. So far, general symbols are working just fine.

I have many more questions, but too many to cram into my reflections. Overall this was a great experience, and I will enjoy making Shiny Apps in the future!

My references are as follows:

* [Bootswatch](http://bootswatch.com/) provides some nice bootstrap themes.
* [Application layout guide](http://shiny.rstudio.com/articles/layout-guide.html) helped assist me with the layout and construction of my app.
* [Shiny Tutorial](http://shiny.rstudio.com/tutorial/lesson1/) provides a great walkthrough of simple and complex areas of Shiny.
* [HTML tag glossary](http://shiny.rstudio.com/articles/tag-glossary.html)
* [Quick-R](http://www.statmethods.net/advstats/timeseries.html) for methods of decomposing time series and creating ACF/PACF figures in `ggplot2`.

Hope you enjoy the Market App!