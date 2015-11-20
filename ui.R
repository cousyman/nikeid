shinyUI(fluidPage(
  titlePanel("Create a Dog Tag!"),
  
  sidebarLayout(
    sidebarPanel(
      p('Personalize your dog tag!'),
      helpText("This app runs similar to Nike ID.
               You will see a preview of your ordered tag."),
      helpText('Note: Text will scale better on actual tag.'),
      
      
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