library(shiny)
library(shinyWidgets)
source("/Users/pujasaha/Desktop/Urology/Web_ProstateCancer/model.R")
data<-read_excel("/Users/pujasaha/Desktop/Urology/Data/finaldataset_for_model.xlsx")


# Define UI ----


ui <- fluidPage(
  
  
  titlePanel("Probability of the hospital stay more than one day after Robotic Prostatectomy"),
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput(inputId = "age",
                  label = "Enter the age of the patient:",
                  min=10,
                  max=90,
                  value=20),
      sliderInput(inputId = "BMI",
                  label = "Enter the BMI of the patient:",
                  min=10,
                  max=50,
                  value=20),
      
      h3("Enter surgery type"),
      helpText("Note: Below you need to specify the surgery type", 
                               
                               "1=extraperitoneal, 3=transperitoneal "),
      
      
      selectInput('Approach',
                    label = "Enter the surgery type:",
                    choices = unique(prostateCancer_final$Approach)
                    ),
      
    
      numericInput("PSA", 
                   h6("Enter the Prostate Specific Antigen value of the patient:"), 
                   value = 1),
      
      selectInput( 'Race',
                  label = "Enter the race:",
                  choices = c(1,2,3,4,5),
                  ),
      
      h3("WARNING: read before your enter Gleason score"),
      helpText("Note:How to calculate the Gleason score? ", 
               
               "1 is good and 7 is the worst "),
      
      pickerInput(inputId = 'Gleason',
                  label = "Enter the Gleason score of the patient",
                  choices = c(0,1,2,3,4,5,6,7),
                  options = list(`style` = "btn-info"),),
                  
      
      
             h3("Enter comorbidity"),
             helpText("Note: Below you need to add comoborbidity", 
                      "asscociated with a perticular body system.",
                      "choose 1 when the patient has a comorbidity associated with correponding body system "),
      
      
      pickerInput(inputId = 'c_GI',
                  label = "Does the patient have any comorbidity associated with gastro-intestinal system? ",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      
      pickerInput(inputId = 'c_GU',
                  label = "Does the patient have any comorbidity associated with gentital urinary system?",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      
      pickerInput(inputId = 'c_Neuro',
                  label = "Does the patient have any comorbidity associated with neurological system?",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      
      pickerInput(inputId = 'c_Cardio',
                  label = "Does the patient have any comorbidity asscociated with cardiac system?",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      
      pickerInput(inputId = 'c_Resp',
                  label = "Does the patient have any comorbidity associated with respiratory system?",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      
      pickerInput(inputId = 'c_Hemato',
                  label = "Does the patient have any comorbidity associated with hematological system?",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      pickerInput(inputId = 'c_Endo',
                  label = "Does the patient have any comorbidity associated with endocrine system?",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      pickerInput(inputId = 'c_Mental',
                  label = "Does the patient have any  mental health issue?",
                  choices = c(0,1),
                  options = list(`style` = "btn-info"),),
      
       
      actionButton("Submit", "RunFunction"),
      #tableOutput("prob")
      
      
      
    ),
        
      mainPanel(h1("Probability of hospital stay more than one day"),
               tableOutput("prob"))


)

)



# Define server logic ----
server <- function(input, output) {
  
  
result <-eventReactive(input$Submit, {logistic_fit(data, input$age, input$BMI, input$Approach, input$PSA, input$Race, input$Gleason, input$c_GI, input$c_GU, input$c_Neuro, input$c_Cardio,
                                                   input$c_Resp, input$c_Hemato, input$c_Endo, input$c_Mental)
  
}) 
  

output$prob <- renderTable({
  result()
})  
  
    #renderPrint({logistic_fit(data, input$age, input$BMI, input$Approach, input$PSA, input$Race, input$Gleason, input$c_GI, input$c_GU, input$c_Neuro, input$c_Cardio,
    #             input$c_Resp, input$c_Hemato, input$c_Endo, input$c_mental)

    #})
  
  
  #renderText({input$age})
  
  
  
}

#fluidRow(

#column(10,
#       h6("Click submit to enter the parameters"),
#       #actionButton("action", "Action"),
#       br(),
#       br(), 
#       submitButton("Submit")))

#

# Run the app ----
shinyApp(ui = ui, server = server)