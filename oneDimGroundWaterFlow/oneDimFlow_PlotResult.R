setwd("F:/Users/kongdd/Documents/MATLAB/计算机大作业")
library(ggplot2)
library(R.matlab)
library(plyr)
library(reshape)

data <- readMat("oneDimFlowPlotData.mat")
x1 <- seq(0, 1, 0.2)
x2 <- seq(0, 1, 0.01)
# release data in mat File
Names <- names(data)

for (i in 1:length(data)) {
    # release data from list
    eval(parse(text = sprintf("%s=data[[%d]]", Names[i], i)))
    # add x value
    if (i == 1) {
        eval(parse(text = sprintf("%s <- cbind(x1,%s)", Names[i], Names[i])))
    } else {
        eval(parse(text = sprintf("%s <- cbind(x2,%s)", Names[i], Names[i])))
    }
    # add rownames
    
}
# eval(parse(text=sprintf('colnames(%s)=Row_Names',Names[i])))
data <- rbind(Het.situ1, Het.situ2, Hom, Hom.forward, Hom.backward)
Name <- c(rep("Het.situ1", 101), rep("Het.situ2", 101), rep("Hom", 101), rep("Hom.forward", 
    6), rep("Hom.backward", 101))

Row_Names <- c("x", "0", "1", "5", "10", "20", "40", "100", "Tag")
data <- data.frame(data, Tag = Name)
colnames(data) <- Row_Names

plot.data <- melt(data, c("x", "Tag"))
colnames(plot.data) <- c("X", "Tag", "Time", "Head")

# last_plot()+labs(y=expression(paste('T' [1],'=0.01')))
# last_plot() + labs(y = expression(paste("T"[1], "=0.01,", " T"[2], "=0.002")))
# strip.situ1 <- expression(paste("T"[1], "=0.01,", " T"[2], "=0.002")) 
# strip.situ2 <- expression(paste("T"[1], "=0.002,", " T"[2], "=0.01")) 
# 
# strip.hom <- expression(paste("T", "=0.01")) 
# strip.fore <- expression(paste("Forward Approximation T", "=0.01")) 
# strip.hom <- expression(paste("Backward Approximation T", "=0.01")) 

# ggplot2 theme initial ---------------------------------------------------
windowsFonts(consolas = windowsFont("consolas"))

theme_kongdd <- theme_bw()+
  theme(text = element_text(family="consolas",size=14),
        axis.text.x=element_text(size=14),
        axis.text.y=element_text(size=16),
        axis.title=element_text(size=18),
        legend.title=element_text(size=16),
        legend.text=element_text(size=16),
        strip.text = element_text(size=18))
# question 1.1 figure -----------------------------------------------------
qust1 <- c("Hom","Hom.backward","Hom.forward")
sub_Data1<-subset(plot.data, Tag %in% qust1)

levels(sub_Data1$Tag)[levels(sub_Data1$Tag)=="Hom"] <- expression(paste("T", "=0.01"))
levels(sub_Data1$Tag)[levels(sub_Data1$Tag)=="Hom.forward"] <- expression(paste("Forward T", "=0.01")) 
levels(sub_Data1$Tag)[levels(sub_Data1$Tag)=="Hom.backward"] <- expression(paste("Backward T", "=0.01")) 

ggplot(sub_Data1, aes(x = X, y = Head, colour = Time)) + geom_line(size = 1.2) + 
  facet_grid(~Tag,labeller = label_parsed)+
  theme_kongdd +
  scale_x_continuous(limits = c(-0.05, 1.05))+
  labs(colour = "Time(s)")+
  ylab("Hydraulic Head")+
  xlab("Distance")
  


# question 1.2 figure -----------------------------------------------------
qust2 <- c("Het.situ1","Het.situ2")
sub_Data2<-subset(plot.data, Tag %in% qust2)

levels(sub_Data2$Tag)[levels(sub_Data2$Tag)=="Het.situ1"] <- expression(paste("T"[1], "=0.01,", " T"[2], "=0.002")) 
levels(sub_Data2$Tag)[levels(sub_Data2$Tag)=="Het.situ2"] <- expression(paste("T"[1], "=0.002,", " T"[2], "=0.01"))

ggplot(sub_Data2, aes(x = X, y = Head, colour = Time)) + geom_line(size = 1.2) + 
  facet_grid(~Tag,labeller = label_parsed)+
  theme_kongdd +
  scale_x_continuous(limits = c(-0.01, 1.03))+
  labs(colour = "Time(s)")+
  ylab("Hydraulic Head")+
  xlab("Distance")
