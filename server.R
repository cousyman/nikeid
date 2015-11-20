# server.R
library(ggplot2)
library(jpeg)
library(png)
library(grid)
library(dplyr)

bone <- readPNG('data/bone.png')
heart <- readPNG('data/heart.png')
circle <- readPNG('data/circle.png')
hydrant <- readPNG('data/hydrant.png')


shinyServer(
  function(input, output) {
    
    output$map <- renderImage({
 
      data <- data.frame(x1=0,x2=2,y1=0,y2=2,xmid=1,ymid=1)
      plot2 <- ggplot(data=data,aes(x=xmid,y=ymid,xmin=x1,xmax=x2,ymin=y1,ymax=y2))+
        geom_point(size=0)
      
      plot <- switch(input$var,
                     'Bone' = plot2 + annotation_raster(bone, xmin=.25, xmax=1.75, ymin=.375, ymax=1.625),
                     'Circle' = plot2 + annotation_raster(circle, xmin=.25, xmax=1.75, ymin=.25, ymax=1.75),
                     'Heart' = plot2 + annotation_raster(heart, xmin=.375, xmax=1.625, ymin=.375, ymax=1.625),
                     'Fire Hydrant' = plot2 + annotation_raster(hydrant, xmin=.375, xmax=1.625, ymin=.15, ymax=1.85)
      )
      
      plot.new()
      
      test <- switch(input$var,
                     'Bone' = data.frame(xmin1=.25, xmax1=1.75,ymin1=.75,ymax1=1.5),
                     'Circle' = data.frame(xmin1=.25, xmax1=1.75,ymin1=.5,ymax1=1.75),
                     'Heart' = data.frame(xmin1=.375, xmax1=1.625,ymin1=.75,ymax1=1.625),
                     'Fire Hydrant' = data.frame(xmin1=.375, xmax1=1.625,ymin1=1,ymax1=1.85)
                      )
      
        int <- switch(input$var,
                       'Bone' = data.frame(xmin1=.25, xmax1=1.75,ymin1=.75,ymax1=1.625),
                       'Circle' = data.frame(xmin1=.25, xmax1=1.75,ymin1=.5,ymax1=1.75),
                       'Heart' = data.frame(xmin1=.375, xmax1=1.625,ymin1=.75,ymax1=1.625),
                       'Fire Hydrant' = data.frame(xmin1=.375, xmax1=1.625,ymin1=1,ymax1=1.85)
        )
      test$petname <- input$name
      test$phonenumber <- input$number
      test$xavg <- (test$xmin1+test$xmax1)/2
      test$yavg <- (test$ymin1+test$ymax1)/2
      test$textsize <- 24/strwidth(as.character(test$petname))
      test$textsize2 <- 24/strwidth(as.character(test$phonenumber))
      
      plot2 <- switch(input$var,
                    'Bone' = plot + geom_rect(data=test,mapping=aes(xmin=xmin1,xmax=xmax1,ymin=ymin1,ymax=ymax1,alpha='0'),inherit.aes=F)+
                     geom_text(data=test,aes(x=xavg,y=yavg,label=petname,size=textsize),inherit.aes=F)+
                     geom_text(data=test,aes(x=xavg,y=yavg-.35,label=phonenumber,size=textsize/2),inherit.aes=F)+
                     scale_size_area(),
                   'Circle' = plot + geom_rect(data=test,mapping=aes(xmin=xmin1,xmax=xmax1,ymin=ymin1,ymax=ymax1,alpha='0'),inherit.aes=F)+                         
                     geom_text(data=test,aes(x=xavg,y=yavg,label=petname,size=textsize),inherit.aes=F)+
                     geom_text(data=test,aes(x=xavg,y=yavg-.35,label=phonenumber,size=textsize/2),inherit.aes=F)+
                     scale_size_area(),
                    'Heart' = plot + geom_rect(data=test,mapping=aes(xmin=xmin1,xmax=xmax1,ymin=ymin1,ymax=ymax1,alpha='0'),inherit.aes=F)+
                     geom_text(data=test,aes(x=xavg,y=yavg,label=petname,size=textsize),inherit.aes=F)+
                     geom_text(data=test,aes(x=xavg,y=yavg-.25,label=phonenumber,size=textsize/2),inherit.aes=F)+
                     scale_size_area(),
                    'Fire Hydrant' = plot + geom_rect(data=test,mapping=aes(xmin=xmin1,xmax=xmax1,ymin=ymin1,ymax=ymax1,alpha='0'),inherit.aes=F)+
                     geom_text(data=test,aes(x=xavg,y=yavg,label=petname,size=textsize),inherit.aes=F)+
                     geom_text(data=test,aes(x=xavg,y=yavg-1.15,label=phonenumber,size=textsize/2),inherit.aes=F)+
                     scale_size_area()
      )
      test2 <- plot2 + theme(legend.position="none")+theme(line = element_blank(),
                                                  text = element_blank(),
                                                  line = element_blank(),
                                                  title = element_blank())+
        theme(plot.margin=unit(c(0,0,unit(-0.5, "line"),unit(-0.5, "line")),"in"))+
        labs(x=NULL,y=NULL)+
        theme(panel.background = element_rect(fill='white',colour='white'))
      outfile <- tempfile(fileext='.png')
      
      ggsave(test2, file='test.png',width=4,height=4)
      
      list(src = 'test.png',
           contentType='image/png',
           width=400,
           height=400,
           alt='This is weird')
      
    })
      
  }
    )