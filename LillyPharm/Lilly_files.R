# install.packages("plotly")
# install.packages("dplyr")
# install.packages("readxl")
# install.packages("tidyr")
# install.packages("gt")
# install.packages("tidyverse")
# install.packages("stringr")
# install.packages("stringi")
#install.packages("htmlTable")
rm(list=ls())
library(dplyr)
library(plotly)
library(readxl)
library(tidyr)
library(tidyverse)
library(gt)
library(stringr)
library(stringi)

my_data<-as.data.frame(read.csv2(file("C:\\Users\\Owner\\Downloads\\mock_data_4table.csv",  encoding="UTF-8"),sep =","), stringsAsFactors=TRUE)
test<-my_data %>% spread(trt, result)
test2<-transform(test, TRT1 = round(as.numeric(TRT1),2), TRT2 = round(as.numeric(TRT2),2), 
                 PBO =round( as.numeric(PBO),2), timepoint=as.factor(timepoint))

test_group<-test2 %>% select(analysistype,timepoint,resulttype,  PBO, TRT1, TRT2 )%>%
  group_by(analysistype,timepoint, resulttype )%>%
  filter( resulttype %in% c("p-value","LS Mean", "Difference", "N"))%>% 
    summarise( PBO=sum(PBO, na.rm = TRUE),TRT1=sum(TRT1, na.rm = TRUE),TRT2= sum(TRT2, na.rm = TRUE) )

test3<-test_group%>% mutate(across(where(is.numeric), as.character))%>%
  mutate(PBO=case_when(resulttype=="p-value"&PBO<.001 ~  paste(PBO, "***"), 
                       resulttype=="p-value"&PBO<.01 ~  paste(PBO, "**"), 
resulttype=="p-value"&PBO<.05 ~  paste(PBO, "*"), 
  TRUE ~ PBO))%>% 
  mutate(TRT1=case_when(resulttype=="p-value"&TRT1<.001 ~  paste(TRT1, "***"), 
                                       resulttype=="p-value"&TRT1<.01 ~  paste(TRT1, "**"), 
                                       resulttype=="p-value"&TRT1<.05 ~  paste(TRT1, "*"), 
                                       TRUE ~ TRT1)) %>%
  mutate(TRT2=case_when(resulttype=="p-value"&TRT2<.001 ~  paste(TRT2, "***"), 
                                       resulttype=="p-value"&TRT2<.01 ~  paste(TRT2, "**"), 
                                       resulttype=="p-value"&TRT2<.05 ~  paste(TRT2, "*"), 
                                                                    TRUE ~ TRT2))

test5<-test2%>%filter(resulttype %in%c("LS Mean","Std Err") )%>%select(timepoint,resulttype,  PBO) %>% 
  group_by(timepoint, resulttype)%>% summarise(PBO = sum(PBO, na.rm = TRUE))

test5<-test5[order(test5$timepoint,test5$resulttype,decreasing=FALSE,na.last=FALSE),]
test5<-test5%>%summarise(PBO= paste(PBO, collapse = "("))

test5$PBO<- str_replace(test5$PBO, ",", "(")
test5$PBO<-paste0(test5$PBO, ")") 

for (i in 1:length(test3$resulttype)) {
  
  for (j in 1:length(test5$PBO)) {
    
    if(test3[i,"timepoint"]==test5[j,"timepoint"]& test3[i,"resulttype"]=="LS Mean"){
      
      test3[i,"PBO"]=test5[j,"PBO"]
      
    }
  }
}

test6<-test2%>%filter(resulttype %in%c("LS Mean","Std Err")&!reftrt=="PBO" )%>%select(timepoint,resulttype,  TRT2) %>% 
  group_by(timepoint, resulttype)%>% summarise(TRT2 = sum(TRT2, na.rm = TRUE))

test6<-test6[order(test6$timepoint,test6$resulttype,decreasing=FALSE,na.last=FALSE),]
test6<-test6%>%summarise(TRT2= paste(TRT2, collapse = "("))

test6$TRT2<- str_replace(test6$TRT2, ",", "(")
test6$TRT2<-paste0(test6$TRT2, ")") 

for (i in 1:length(test3$resulttype)) {
  
  for (j in 1:length(test6$TRT2)) {
    
    if(test3[i,"timepoint"]==test6[j,"timepoint"]& test3[i,"resulttype"]=="LS Mean"){
      
      test3[i,"TRT2"]=test6[j,"TRT2"]
      
    }
  }
}

test8<-test2%>%filter(resulttype %in%c("LS Mean","Std Err")&!reftrt=="PBO" )%>%select(timepoint,resulttype,  TRT1) %>% 
  group_by(timepoint, resulttype)%>% summarise(TRT1 = sum(TRT1, na.rm = TRUE))

test8<-test8[order(test8$timepoint,test8$resulttype,decreasing=FALSE,na.last=FALSE),]
test8<-test8%>%summarise(TRT1= paste(TRT1, collapse = "("))

test8$TRT1<- str_replace(test8$TRT1, ",", "(")
test8$TRT1<-paste0(test8$TRT1, ")") 


for (i in 1:length(test3$resulttype)) {
  
  for (j in 1:length(test8$TRT1)) {
    
    if(test3[i,"timepoint"]==test8[j,"timepoint"]& test3[i,"resulttype"]=="LS Mean"){
      
      test3[i,"TRT1"]=test8[j,"TRT1"]
      
    }
  }
}

test4<-test2%>%filter(resulttype %in%c("Difference","95% CI Low","95% CI High") )%>%select(timepoint,resulttype,  TRT1 ) %>% 
     group_by(timepoint, resulttype)%>% summarise(TRT1 = sum(TRT1, na.rm = TRUE))

test4<-test4[order(test4$timepoint,test4$resulttype,decreasing=TRUE,na.last=FALSE),]
test4<-test4%>%summarise(TRT1= paste(TRT1, collapse = ","))
 
test4$TRT1<- str_replace(test4$TRT1, ",", "(")
test4$TRT1<-paste0(test4$TRT1, ")") 

for (i in 1:length(test3$resulttype)) {
  
  
  for (j in 1:length(test4$TRT1)) {
    
    if(test3[i,"timepoint"]==test4[j,"timepoint"]& test3[i,"resulttype"]=="Difference"){
      
      test3[i,"TRT1"]=test4[j,"TRT1"]
      
    }
  }
}

test7<-test2%>%filter(resulttype %in%c("Difference","95% CI Low","95% CI High") )%>%select(timepoint,resulttype,  TRT2 ) %>% 
  group_by(timepoint, resulttype)%>% summarise(TRT2 = sum(TRT2, na.rm = TRUE))

test7<-test7[order(test7$timepoint,test7$resulttype,decreasing=TRUE,na.last=FALSE),]
test7<-test7%>%summarise(TRT2= paste(TRT2, collapse = ","))

test7$TRT2<- str_replace(test7$TRT2, ",", "(")
test7$TRT2<-paste0(test7$TRT2, ")") 

for (i in 1:length(test3$resulttype)) {
  
  for (j in 1:length(test7$TRT2)) {
    
    if(test3[i,"timepoint"]==test7[j,"timepoint"]& test3[i,"resulttype"]=="Difference"){
      
      test3[i,"TRT2"]=test7[j,"TRT2"]
      
    }
  }
}

test_group<-test3%>%gt(rowname_col = "analysttype", groupname_col = "timepoint")%>% 
   row_group_order(groups=c("Baseline","Week 4", "Week 8", "Week 12", "Week 16", "Week 24", "Week 36"))
test_group
