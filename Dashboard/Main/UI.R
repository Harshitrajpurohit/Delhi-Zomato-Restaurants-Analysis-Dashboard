library(shiny)
library(DT)
library(shinydashboard)
Data_file <- read.csv("D:/Projects/R/1/zomato.csv", header = TRUE)

Rating_4 <- sum(Data_file$Rating>=4)

total_Votes <- sum(Data_file$Votes)

shinyUI(
  
  dashboardPage(
    
    dashboardHeader(
      title = "ZOMATO",
      dropdownMenu(type = "message",
                   messageItem(from="Customer",message = "hey"),
                   messageItem(from="Finance Department",message = "We lost our Data"))
      ),
    
    dashboardSidebar(
      sidebarMenu( # to go back
        menuItem("DashBoard",tabName = "dashborad"),
          menuSubItem("Rating Analysis",tabName = "Rating"),
          menuSubItem("Food Analysis",tabName = "cuisines"),
        menuItem("Table",tabName = "Table")
      )
    ),
    
    dashboardBody(
      tabItems(
        tabItem(
          
          ###### Dashboard page
          tabName = "dashborad",
          fluidRow(
            valueBox(nrow(Data_file),"Total Restaurants in Delhi",icon = icon("utensils"),color = "maroon"),
            valueBox(Rating_4,"Rating more than 4",icon = icon("star"),color = "purple"),
            valueBox(total_Votes,"Total No of Votes in Delhi",icon = icon("handshake"),color = "purple")
          ),
          fluidRow(
            box(title = "Top Area in Delhi",plotOutput("barchart1",height = "490px"),width = 9,status = "primary"),
            box(sliderInput("num", "Number of Top Localities:",
                            min = 1, max = 50, value = 20),
                h3("About The Restautant"),
                selectInput("locality", "Choose a Locality:", choices = unique(Data_file$Locality)),
                # Dropdown for selecting Restaurant, updated based on selected Locality
                
                uiOutput("restaurantUI"),
                br(),
                # Value box for displaying Average Cost for two
                uiOutput("avgCostUI"),
                uiOutput("bestfoodUI"),
                uiOutput("ratingUI"),
                width = 3)
            ),
        ),
        
        
        ###### Rating Page
        tabItem(
          tabName = "Rating",
          box(h1("Rating Analysis"),width = 12),
          box(title = "Number of Restaurants with Different Ratings",
            plotOutput("ratingBarChart"),
            status = "primary"
          ),
          box(title = "Reviews",status = "primary",
              plotOutput("ratingPiechart")
            )
        ),
        
        ###### Food page
        tabItem(
          tabName = "cuisines",
          fluidPage(
          box(title = "Cuisines Across Localities",plotOutput("cuisinesBarchart",height = "600px"),width = 9,status = "primary"),
          box(sliderInput("cuisinesnum", "Number of Top Localities:",
                          min = 1, max = 50, value = 20),width = 3)
          )
        ),
        
        ###### Table page
        tabItem(
          tabName = "Table",
          h1("Data Table"),
          fluidRow(
            DTOutput("data_table",width = "1200")
            )
        )
      )
    )
  )
)

