library(dplyr)
library(plotly)
library(readxl)
library(shiny)

# Instructions: 1) copy the directory that your "data.csv" file is saved in, append "data.csv" to the end of it and change ALL the "\" to "/"
# 
# 2) press ctrl+a
# 
# 3) press ctrl+enter


my_data<-as.data.frame(read.csv2("C:/Users/Owner/Documents/GitHub/Passed-Technical-Interviews/For_MetrumRG/data.csv", sep =","))
my_data<-transform(my_data, TAD = as.numeric(TAD), WT = as.numeric(WT), DV = as.numeric(DV), AGE = as.numeric(AGE))

demo_5<-my_data%>% filter(ACTARM == "DEMO 5 mg")
demo_10<-my_data%>% filter(ACTARM == "DEMO 10 mg")
demo_25<-my_data%>% filter(ACTARM == "DEMO 25 mg")
demo_100<-my_data%>% filter(ACTARM == "DEMO 100 mg")
demo_150<-my_data%>% filter(ACTARM == "DEMO 150 mg")
demo_200<-my_data%>% filter(ACTARM == "DEMO 200 mg")


ui <- fluidPage( div(plotlyOutput("chart", height = "100%"), align = "center"), selectInput(
  "weight", "Choose a weight", 
  choices = c('All',my_data$WT), multiple = T ,selected = "All"
),  selectInput(
  "age", "Choose an Age", 
  choices = c('All',my_data$AGE), multiple = T ,selected = "All"
))

server <- function(input, output, session){
 
  output$chart <- renderPlotly({
    if(input$weight!= 'All'){
      demo_5<- demo_5 %>%filter(WT==input$weight)
      demo_10<- demo_10 %>%filter(WT==input$weight)
      demo_25<- demo_25 %>%filter(WT==input$weight)
      demo_100<- demo_100 %>%filter(WT==input$weight)
      demo_150<- demo_150 %>%filter(WT==input$weight)
      demo_200<- demo_200 %>%filter(WT==input$weight)
      
    }
    
    if(input$age!= 'All'){
      demo_5<- demo_5 %>%filter(AGE==input$age)
      demo_10<- demo_10 %>%filter(AGE==input$age)
      demo_25<- demo_25 %>%filter(AGE==input$age)
      demo_100<- demo_100 %>%filter(AGE==input$age)
      demo_150<- demo_150 %>%filter(AGE==input$age)
      demo_200<- demo_200 %>%filter(AGE==input$age)
      
    }
    
fig1 <- plot_ly(
  demo_5, x = ~TAD, y = ~DV, type = 'scatter',   showscale= F,showlegend = F, mode = 'markers',
  marker = list(
    color=~WT,
    showscale = F,
    colorscale=list(c(0, "rgb(255, 234, 0)"),
                    list(0.5, "rgb(	255, 162, 0)"),
                    list(1, "rgb(255, 34, 0)"))),
  size = ~WT
)%>% layout(
  xaxis = list(
    range=c(0,125), dtick = 25
  ), yaxis = list(range=c(0,4000)), title = 'DEMO 5 mg')

fig2 <- plot_ly(
  demo_10, x = ~TAD, y = ~DV, type = 'scatter', coloraxis = 'coloraxis',  mode = 'markers',  showscale= F,showlegend = F, marker = list(
    color=~WT,
    showscale = F,
    colorscale=list(c(0, "rgb(255, 234, 0)"),
                    list(0.5, "rgb(	255, 162, 0)"),
                    list(1, "rgb(255, 34, 0)"))), 
  size = ~WT
)%>% layout(
  xaxis = list(
    range=c(0,125), dtick = 25, tickangle= 0
  ), yaxis = list(range=c(0,4000)), title = 'DEMO 10 mg') 

fig3 <- plot_ly(
  demo_25, x = ~TAD, y = ~DV, type = 'scatter', coloraxis = 'coloraxis', mode = 'markers',  showscale= F,showlegend = F, marker = list(
    color=~WT,
    showscale= F,
    colorscale=list(c(0, "rgb(255, 234, 0)"),
                    list(0.5, "rgb(	255, 162, 0)"),
                    list(1, "rgb(255, 34, 0)")))
)%>% layout(
  xaxis = list(
    range=c(0,125), dtick = 25
  ), yaxis = list(range=c(0,4000)), title = 'DEMO 25 mg') 

fig4 <- plot_ly(
  demo_100, x = ~TAD, y = ~DV, type = 'scatter', coloraxis = 'coloraxis',  mode = 'markers',  showscale= F,showlegend = F, marker = list(
    color=~WT,
    showscale = F,
    colorscale= list(c(0, "rgb(255, 234, 0)"),
                                list(0.5, "rgb(	255, 162, 0)"),
                                list(1, "rgb(255, 34, 0)"))),
   size = ~WT 
) %>% layout(
  xaxis = list(
    range=c(0,125), dtick = 25
  ), yaxis = list(range=c(0,4000)), title = 'DEMO 100 mg')

fig5 <- plot_ly(
  demo_150, x = ~TAD, y = ~DV, type = 'scatter', coloraxis = 'coloraxis',  mode = 'markers',  showscale= F,showlegend = F, marker = list(
    color=~WT,
    showscale = F,
    colorscale=list(c(0, "rgb(255, 234, 0)"),
                    list(0.5, "rgb(	255, 162, 0)"),
                    list(1, "rgb(255, 34, 0)"))),
  size = ~WT 
) %>% layout(
  xaxis = list(
    range=c(0,125), dtick = 25, tickangle=0 
  ), yaxis = list(range=c(0,4000)), title = 'DEMO 150 mg') 

fig6 <- plot_ly(
  demo_200, x = ~TAD, y = ~DV, type = 'scatter', coloraxis = 'coloraxis', mode = 'markers',  showscale= F,showlegend = F, marker = list(
    color=~WT,
    cmin= 0,
    reversescale = F,
    cmax= 90,
    colorscale= list(c(0, "rgb(255, 234, 0)"),
                     list(0.5, "rgb(	255, 162, 0)"),
                     list(1, "rgb(255, 34, 0)"))
    ,
    colorbar=list(
      title='Weight(kg)'
    )),
   size = ~WT,  range = c(0,125)
  ) %>% layout(
  xaxis = list(
    range=c(0,125), dtick = 25
  ), yaxis = list(range=c(0,4000))) 

annotations <- list( 
  list( 
    x = 0.13,  
    y = 1.0,  
    text = "DEMO 1 mg",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = .85,  
    y = 1,  
    text = "DEMO 3 mg",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),  
  list( 
    x = 0.13,  
    y = 0.45,  
    text = "DEMO 4 mg",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  list( 
    x = 0.85,  
    y = 0.45,  
    text = "DEMO 6 mg",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  
  list( 
    x = 0.5,  
    y = .97,  
    text = "DEMO 2 mg",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  
  list( 
    x = 0.5,  
    y = .45,  
    text = "DEMO 5 mg",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  ),
  
  
    list(x = -.08, 
         y = 0.5, 
         text = "concentration (mg/ml)",
         font = list(size = 16),
         textangle = 270,
         showarrow = F, xref='paper', yref='paper', size=48)
  
  ,
  
  list( 
    x = 0.5,  
    y = -.1,  
    text = "Time after dose(hours)",  
    xref = "paper",  
    yref = "paper",  
    xanchor = "center",  
    yanchor = "bottom",  
    showarrow = FALSE 
  )
    
  )

multiple_plots<- subplot(fig1, fig2, fig3, fig4, fig5, fig6,  nrows =2, margin =.04)%>%
  layout(title="Concentration over time, by dose",annotations = annotations, showscale = F)
  
  #layout(title="Concentration over time, by dose", yaxis = list(title = "concentration (mg/ml)                  "))
multiple_plots

  })
}

shinyApp(ui, server, options= list(port=443))
