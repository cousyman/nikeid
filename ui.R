shinyUI(fluidPage(
  titlePanel("Create a Dog Tag!"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Personalize your dog tag!"),
      
      selectInput("var", 
                  label = "Choose a type of tag!",
                  choices = c("Bone", "Heart",
                              "Circle", "Fire Hydrant"),
                  selected = "Bone"),
      
      textInput("name", 
                  label = "Pet Name",
                  value='')
      ,
    textInput("number", 
              label = "Phone Number",
              value=''),
    submitButton('Submit')
  ),
    
    mainPanel(imageOutput("map"))
  )
))