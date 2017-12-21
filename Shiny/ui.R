library(shinydashboard)
library(leaflet)

source("Untitled.R")

header <- dashboardHeader(
  title = "AirBnB Analysis"
)


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Maps", tabName = "map", icon = icon("map")),
    menuItem("Graphs", icon = icon("bar-chart"), tabName = "Graphs",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("About Us", icon = icon("address-book"), tabName = "About",
             badgeColor = "green")
  )
)
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "map",
            fluidRow(
              tabsetPanel(
                     tabPanel("Map1",
                              column(width = 9,
                                     box(width = NULL, solidHeader = TRUE,
                                         leafletOutput("roomtype", height = 500)
                                     ),
                                     box(width = NULL,
                                         dataTableOutput("numVehiclesTable")
                                     )
                              ),
                              column(width = 3,
                                     box(width = NULL, status = "warning",
                                           selectInput("neighbour", "Neighbourhood", choices = unique(Chicago$neighbourhood_cleansed)),
                                         sliderInput("range", "Price Range:",
                                                     min = 1, max = 1000,
                                                     value = c(10,50)),
                                         p(
                                           class = "text-muted",
                                           paste("Note: Select the neighbourhood and price range to see the apartments"
                                           )
                                         )
                                     ))),
                     tabPanel("Map2",
                                       column(width = 9,
                                              box(width = NULL, solidHeader = TRUE,
                                                  leafletOutput("price_dist", height = 500)
                                              ),
                                              box(width = NULL,
                                                  dataTableOutput("chk")
                                              )
                                       ),
                              column(width = 3,
                                     box(width = NULL, status = "warning",
                                         selectInput("room_type", "Room Type", choices = unique(Chicago$room_type))                                     ))
                              )
              )
            )
    ),
    
    #####part2 in menuprop bed room hostsince cancepo
    tabItem(
      tabName = "Graphs", 
        tabPanel("Tab1", column(width = 2,
                                box(width = NULL,radioButtons("yaxis", "Choose y Axis:", choices = c("price","number_of_reviews"))),
                                box(width = NULL,radioButtons("xaxis", "Choose x Axis:",
                                                             choices = c("bed_type","room_type","cancellation_policy","property_type","host_since")),height = 200)
        ),
        column(width = 8,
               plotlyOutput("event",height = 650)
        ),
        column(width = 2,
               box(width = NULL,selectInput("bedrooms", "#Bedrooms", choices = unique(Chicago$bedrooms_bin)),height = 120),
               box(width = NULL,selectInput("bathrooms", "#Bathrooms", choices = unique(Chicago$bathrooms_bin)),height = 120),
               box(width = NULL,selectInput("accommodates", "#Guests", choices = unique(Chicago$accommodates_bin)),height = 120)
        ))
      
    ),
    tabItem(
      tabName = "About",    mainPanel(
        h2("Apurv Garg"),
        h2("Ankush Agrawal"),
        h2("Xiao Liu")
      )
    ))
)
dashboardPage(
  skin = "green",
  header,
  sidebar,
  body
)


