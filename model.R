

logistic_fit<- function(merging_inner_join_with_demo,age, bmi, type, antigen, race, glea, if_GI, if_GU, if_Neuro, if_Cardio, if_Resp, if_Hemato, if_Endo, if_mental)
{
  
  newdata2 <- data.frame(AgeAtProstatectomy=age,
                         BMI= bmi,
                         Approach= type,
                         logPSA=log(antigen),
                         RACE_new= as.numeric(race) ,
                         Gleason=as.numeric(glea),
                         DIAGc_GI=as.numeric(if_GI),
                         DIAGc_GU=as.numeric(if_GU),
                         DIAGc_Neuro=as.numeric(if_Neuro),
                         DIAGc_Cardio=as.numeric(if_Cardio),
                         
                         DIAGc_Resp=as.numeric(if_Resp),
                         DIAGc_Hemato=as.numeric(if_Hemato),
                         DIAGc_Endo=as.numeric(if_Endo),
                         
                         DIAGc_Metal=as.numeric(if_mental)
                         
                         )

  
  fit_logistic3=glm(HospitalStay_binary ~ AgeAtProstatectomy+ BMI+logPSA+Gleason+as.factor(Approach)
                    #+metN
                    +DIAGc_Cardio + DIAGc_Endo +  DIAGc_GI+ DIAGc_GU+ DIAGc_Hemato +  DIAGc_Metal +DIAGc_Neuro+ DIAGc_Resp+RACE_new
                    ,family=binomial(link=logit),data=merging_inner_join_with_demo) # intercept model without predictors
  #summary(fit_logistic3)
  
  newdata3 <- cbind(newdata2, predict(fit_logistic3, newdata = newdata2, type = "response", 
                                      se = TRUE))
  
  #newdata3 <- within(newdata3, { LL <- (fit - se.fit) 
  #UL <- (fit + se.fit) })
  
  
  
  return(newdata3)
    #c(age, bmi, type, antigen, race, glea, if_GI, if_GU, if_Neuro, if_Cardio, if_Resp, if_Hemato, if_Endo, if_mental))
  
}

data<-read_excel("/Users/pujasaha/Desktop/Urology/Data/finaldataset_for_model.xlsx")


logistic_fit(data, 20,20, 3, 1, 1, 0, 0, 0, 0, 0,
             0, 0, 0, 0)

my_function<- function(merging_inner_join_with_demo,age, bmi, type, antigen, race, glea, if_GI, if_GU, if_Neuro, if_Cardio, if_Resp, if_Hemato, if_Endo, if_mental){
  
  return(type)
  
  
}
