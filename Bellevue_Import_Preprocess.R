
#.........................................................................#
#............ Bellevue: Machine Learning Data Analysis ..............#
#.........................................................................#

#setwd("/Users/katharinaschultebraucks/Documents/work/New York University/Projects/Bellevue Study/ML approaches")


###########################################################################
# R Master source code file used to execute all R particular source codes
#
# Created by Dr. Katharina Schultebraucks
#            
# Updated 2018 April 17 
#
# NYU School of Medicine, Department of Psychiatry 
# Contact: katharina.schultebraucks@nyumc.org
###########################################################################

# set path to locally installed r packages
# .libPaths(c("/usr/lib64/R/library", "/usr/share/R/library", "/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"))
# setwd("/ifs/home/schulk02/Amsterdam/TraumaTips")


pkgs <- c("haven", "caret", "MLmetrics", "car", "tibble", "RANN", "fastAdaboost", 
          "ggplot2", "lattice", "monomvn", "missForest", "e1071", "bindrcpp", "adabag",
          "gbm", "dplyr", "glmnet", "pROC", "haven", "foreign",  "randomForest",
          "mlbench", "kernlab", "LiblineaR", "DMwR", "ROSE", "survival", "xgboost", 
          "foreach", "caretEnsemble", "Boruta", "nnet")


# Load packages into session 
lapply(pkgs, require,
       #lib.loc = c("/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"),
       character.only=TRUE)

# clear variable namespace
rm(pkgs)


set.seed(13) 
# load spss data set



#-------------------------------------------------------------------------------
# Import data from SPSS
#-------------------------------------------------------------------------------
# ER_data_total_foreign <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/ER_onlyER_quar.sav"))
ER_onlyER_quar <- read_sav("SPSS_data_files_Bellevue/ER_onlyER_quar.sav")
ER_onlyER_quar <- as_factor(ER_onlyER_quar, only_labelled = TRUE)

# ER_data_total_foreign_ps <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/ER_phonescreen_quar.sav"))
ER_phonescreen_quar <- read_sav("SPSS_data_files_Bellevue/ER_phonescreen_quar.sav")
ER_phonescreen_quar  <- as_factor(ER_phonescreen_quar, only_labelled = TRUE)

# PS_data_total_foreign <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/phonescreen_quar.sav"))
phonescreen_quar <- read_sav("SPSS_data_files_Bellevue/phonescreen_quar-1.sav")
phonescreen_quar <- as_factor(phonescreen_quar, only_labelled = TRUE)

# ER_data_total_foreign_6m_cases <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/PCL5_cases_6m_ER.sav"))
PCL5_cases_6m_ER <- read_sav("SPSS_data_files_Bellevue/PCL5_cases_6m_ER.sav")
PCL5_cases_6m_ER <- as_factor(PCL5_cases_6m_ER, only_labelled = TRUE)

# ER_data_total_foreign_12m_cases <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/PCL5_cases_12m_ER.sav"))
PCL5_cases_12m_ER <- read_sav("SPSS_data_files_Bellevue/PCL5_cases_12m_ER.sav")
PCL5_cases_12m_ER <- as_factor(PCL5_cases_12m_ER, only_labelled = TRUE)

# ER_data_total_foreign_ps_6m_cases <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/PCL5_cases_6m_ER_phonescreen.sav"))
PCL5_cases_6m_ER_phonescreen <- read_sav("SPSS_data_files_Bellevue/PCL5_cases_6m_ER_phonescreen.sav")
PCL5_cases_6m_ER_phonescreen <- as_factor(PCL5_cases_6m_ER_phonescreen, only_labelled = TRUE)

# ER_data_total_foreign_ps_12m_cases <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/PCL5_cases_12m_ER_phonescreen.sav"))
PCL5_cases_12m_ER_phonescreen <- read_sav("SPSS_data_files_Bellevue/PCL5_cases_12m_ER_phonescreen.sav")
PCL5_cases_12m_ER_phonescreen  <- as_factor(PCL5_cases_12m_ER_phonescreen, only_labelled = TRUE)

# data_total_foreign_ps_6m_cases <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/PCL5_cases_6m_phonescreen.sav"))
PCL5_cases_6m_phonescreen <- read_sav("SPSS_data_files_Bellevue/PCL5_cases_6m_phonescreen.sav")
PCL5_cases_6m_phonescreen<- as_factor(PCL5_cases_6m_phonescreen, only_labelled = TRUE)

# data_total_foreign_ps_12m_cases <- as.data.frame(foreign::read.spss("SPSS_data_files_Bellevue/PCL5_cases_12m_phonescreen.sav"))
PCL5_cases_12m_phonescreen <- read_sav("SPSS_data_files_Bellevue/PCL5_cases_12m_phonescreen.sav")
PCL5_cases_12m_phonescreen. <- as_factor(PCL5_cases_12m_phonescreen, only_labelled = TRUE)


# ER_data_total_foreign_6m_cases$pcl5_6m_cases <- as.factor(ER_data_total_foreign_6m_cases$pcl5_6m_cases)
# ER_data_total_foreign_12m_cases$pcl5_12m_cases <- as.factor(ER_data_total_foreign_12m_cases$pcl5_12m_cases)
# ER_data_total_foreign_ps_6m_cases$pcl5_6m_cases <- as.factor(ER_data_total_foreign_ps_6m_cases$pcl5_6m_cases)
# ER_data_total_foreign_ps_12m_cases$pcl5_12m_cases <- as.factor(ER_data_total_foreign_ps_12m_cases$pcl5_12m_cases)
# data_total_foreign_ps_6m_cases$pcl5_6m_cases <- as.factor(data_total_foreign_ps_6m_cases$pcl5_6m_cases)
# data_total_foreign_ps_12m_cases$pcl5_12m_cases <- as.factor(data_total_foreign_ps_12m_cases$pcl5_12m_cases)


ER_data_total <- within(ER_onlyER_quar, 
                        rm("Cprob4", "prob1", "prob2", "prob3", "class", 
                           "PCA.PC5", "PCA.PC6", "PCA.PC7", "PCA.PC8",
                           "PCA.PC9", "PCA.PC10", "PCA.PC11", "PCA.PC12", 
                           "PCA.PC13", "PCA.PC14"))

ER_data_total.phonescreen$PCA.PC1
ER_data_total.phonescreen <- within(ER_phonescreen_quar, 
                                    rm("Cprob4", "prob1", "prob2", "prob3", "class", 
                                       "PCA.PC5", "PCA.PC6", "PCA.PC7", "PCA.PC8",
                                       "PCA.PC9", "PCA.PC10", "PCA.PC11", "PCA.PC12", 
                                       "PCA.PC13", "PCA.PC14"))

data_total.phonescreen <- within(phonescreen_quar, 
                                 rm("Cprob4", "prob1", "prob2", "prob3", "class"))

ER_data_total.6m_cases <- within(PCL5_cases_6m_ER, 
                                 rm("Cprob4", "prob1", "prob2", "prob3", "class", 
                                    "PCA.PC5", "PCA.PC6", "PCA.PC7", "PCA.PC8",
                                    "PCA.PC9", "PCA.PC10", "PCA.PC11", "PCA.PC12", 
                                    "PCA.PC13", "PCA.PC14"))

ER_data_total.12m_cases <- within(PCL5_cases_12m_ER, 
                                  rm("Cprob4", "prob1", "prob2", "prob3", "class", 
                                     "PCA.PC5", "PCA.PC6", "PCA.PC7", "PCA.PC8",
                                     "PCA.PC9", "PCA.PC10", "PCA.PC11", "PCA.PC12", 
                                     "PCA.PC13", "PCA.PC14"))

ER_data_total.ps.6m_cases <- within(PCL5_cases_6m_ER_phonescreen, 
                                    rm("Cprob4", "prob1", "prob2", "prob3", "class", 
                                       "PCA.PC5", "PCA.PC6", "PCA.PC7", "PCA.PC8",
                                       "PCA.PC9", "PCA.PC10", "PCA.PC11", "PCA.PC12", 
                                       "PCA.PC13", "PCA.PC14"))

ER_data_total.ps.12m_cases <- within(PCL5_cases_12m_ER_phonescreen, 
                                     rm("Cprob4", "prob1", "prob2", "prob3", "class", 
                                        "PCA.PC5", "PCA.PC6", "PCA.PC7", "PCA.PC8",
                                        "PCA.PC9", "PCA.PC10", "PCA.PC11", "PCA.PC12", 
                                        "PCA.PC13", "PCA.PC14"))

data_total.ps.6m_cases <- within(PCL5_cases_6m_phonescreen, 
                                 rm("Cprob4", "prob1", "prob2", "prob3", "class"))

data_total.ps.12m_cases <- within(PCL5_cases_12m_phonescreen, 
                                  rm("Cprob4", "prob1", "prob2", "prob3", "class"))



ER_data_total <- within(ER_data_total, rm(eGFR_AfAmer_Metabolic3))
ER_data_total <- within(ER_data_total, rm(eGFR_Other_Metabolic3))
ER_data_total <- within(ER_data_total, rm(Hemolysis_Metabolic3))
ER_data_total <- within(ER_data_total, rm(eGFR_Other_Metabolic4))

ER_data_total.phonescreen <- within(ER_data_total.phonescreen, rm(eGFR_AfAmer_Metabolic3))
ER_data_total.phonescreen <- within(ER_data_total.phonescreen, rm(eGFR_Other_Metabolic3))
ER_data_total.phonescreen <- within(ER_data_total.phonescreen, rm(Hemolysis_Metabolic3))
ER_data_total.phonescreen <- within(ER_data_total.phonescreen, rm(eGFR_Other_Metabolic4))

ER_data_total.6m_cases <- within(ER_data_total.6m_cases, rm(eGFR_AfAmer_Metabolic3))
ER_data_total.6m_cases  <- within(ER_data_total.6m_cases, rm(eGFR_Other_Metabolic3))
ER_data_total.6m_cases  <- within(ER_data_total.6m_cases, rm(Hemolysis_Metabolic3))
ER_data_total.6m_cases <- within(ER_data_total.6m_cases, rm(eGFR_Other_Metabolic4))

ER_data_total.12m_cases <- within(ER_data_total.12m_cases, rm(eGFR_AfAmer_Metabolic3))
ER_data_total.12m_cases  <- within(ER_data_total.12m_cases, rm(eGFR_Other_Metabolic3))
ER_data_total.12m_cases  <- within(ER_data_total.12m_cases, rm(Hemolysis_Metabolic3))
ER_data_total.12m_cases <- within(ER_data_total.12m_cases, rm(eGFR_Other_Metabolic4))

ER_data_total.ps.6m_cases <- within(ER_data_total.ps.6m_cases, rm(eGFR_AfAmer_Metabolic3))
ER_data_total.ps.6m_cases  <- within(ER_data_total.ps.6m_cases, rm(eGFR_Other_Metabolic3))
ER_data_total.ps.6m_cases  <- within(ER_data_total.ps.6m_cases, rm(Hemolysis_Metabolic3))
ER_data_total.ps.6m_cases <- within(ER_data_total.ps.6m_cases, rm(eGFR_Other_Metabolic4))

ER_data_total.ps.12m_cases <- within(ER_data_total.ps.12m_cases, rm(eGFR_AfAmer_Metabolic3))
ER_data_total.ps.12m_cases  <- within(ER_data_total.ps.12m_cases, rm(eGFR_Other_Metabolic3))
ER_data_total.ps.12m_cases  <- within(ER_data_total.ps.12m_cases, rm(Hemolysis_Metabolic3))
ER_data_total.ps.12m_cases <- within(ER_data_total.ps.12m_cases, rm(eGFR_Other_Metabolic4))


#-- examine data type: return name of columns per data type 
split(names(data_total.ps.12m_cases),                            
      sapply(data_total.ps.12m_cases,                             
             function(x) paste(class(x),                      
                               collapse=" ")))  

split(names(ER_data_total),                            
      sapply(ER_data_total,                             
             function(x) paste(class(x),                      
                               collapse=" ")))  

sapply(ER_data_total, summary)

save.image(file = "Bellevue.dataframe.RData", 
           ascii = FALSE,
           compress = TRUE,
           safe = TRUE)


# -- make data frame with only categorical vars
ER_data_onlyfactor <- ER_data_total[,sapply(ER_data_total, is.factor)]
sapply(ER_data_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors

# -- make data frame with only metric vars
ER_data_onlynumeric <- ER_data_total[,sapply(ER_data_total, is.numeric)]
sapply(ER_data_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric

str(ER_data_onlyfactor)

ER_data_onlyfactor.phonescreen <- ER_data_total.phonescreen[,sapply(ER_data_total.phonescreen, is.factor)]
sapply(ER_data_onlyfactor.phonescreen, function(x) paste(class(x))) # print to make sure all are factors

# -- make data frame with only metric vars
ER_data_onlynumeric.phonescreen <- ER_data_total.phonescreen[,sapply(ER_data_total.phonescreen, is.numeric)]
sapply(ER_data_onlynumeric.phonescreen, function(x) paste(class(x))) # print to make sure all are numeric

str(ER_data_onlyfactor.phonescreen)


# -- make data frame with only categorical vars
data_total.phonescreen_onlyfactor <- data_total.phonescreen[,sapply(data_total.phonescreen, is.factor)]
sapply(data_total.phonescreen_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors


# -- make data frame with only metric vars
data_total.phonescreen_onlynumeric <- data_total.phonescreen[,sapply(data_total.phonescreen, is.numeric)]
sapply(data_total.phonescreen_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric

# -- make data frame with only categorical vars
ER_data_total.6m_cases_onlyfactor <- ER_data_total.6m_cases[,sapply(ER_data_total.6m_cases, is.factor)]
sapply(ER_data_total.6m_cases_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors


# -- make data frame with only metric vars
ER_data_total.6m_cases_onlynumeric <- ER_data_total.6m_cases[,sapply(ER_data_total.6m_cases, is.numeric)]
sapply(ER_data_total.6m_cases_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric


# -- make data frame with only categorical vars
ER_data_total.12m_cases_onlyfactor <- ER_data_total.12m_cases[,sapply(ER_data_total.12m_cases, is.factor)]
sapply(ER_data_total.12m_cases_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors


# -- make data frame with only metric vars
ER_data_total.12m_cases_onlynumeric <- ER_data_total.12m_cases[,sapply(ER_data_total.12m_cases, is.numeric)]
sapply(ER_data_total.12m_cases_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric


# -- make data frame with only categorical vars
ER_data_total.ps.6m_cases_onlyfactor <- ER_data_total.ps.6m_cases[,sapply(ER_data_total.ps.6m_cases, is.factor)]
sapply(ER_data_total.ps.6m_cases_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors


# -- make data frame with only metric vars
ER_data_total.ps.6m_cases_onlynumeric <- ER_data_total.ps.6m_cases[,sapply(ER_data_total.ps.6m_cases, is.numeric)]
sapply(ER_data_total.ps.6m_cases_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric


# -- make data frame with only categorical vars
ER_data_total.ps.12m_cases_onlyfactor <- ER_data_total.ps.12m_cases[,sapply(ER_data_total.ps.12m_cases, is.factor)]
sapply(ER_data_total.ps.12m_cases_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors


# -- make data frame with only metric vars
ER_data_total.ps.12m_cases_onlynumeric <- ER_data_total.ps.12m_cases[,sapply(ER_data_total.ps.12m_cases, is.numeric)]
sapply(ER_data_total.ps.12m_cases_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric

# -- make data frame with only categorical vars
data_total.ps.6m_cases_onlyfactor <- data_total.ps.6m_cases[,sapply(data_total.ps.6m_cases, is.factor)]
sapply(data_total.ps.6m_cases_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors


# -- make data frame with only metric vars
data_total.ps.6m_cases_onlynumeric <- data_total.ps.6m_cases[,sapply(data_total.ps.6m_cases, is.numeric)]
sapply(data_total.ps.6m_cases_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric


# -- make data frame with only categorical vars
data_total.ps.12m_cases_onlyfactor <- data_total.ps.12m_cases[,sapply(data_total.ps.12m_cases, is.factor)]
sapply(data_total.ps.12m_cases_onlyfactor, function(x) paste(class(x))) # print to make sure all are factors


# -- make data frame with only metric vars
data_total.ps.12m_cases_onlynumeric <- data_total.ps.12m_cases[,sapply(data_total.ps.12m_cases, is.numeric)]
sapply(data_total.ps.12m_cases_onlynumeric, function(x) paste(class(x))) # print to make sure all are numeric


#-------------------------------------------------------------------------------
# Dummy coding
#-------------------------------------------------------------------------------
#-- data pre-processing: dummy code every factor as numeric binary variable
dummy.vars <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                        data=ER_data_total[,-1],  # omit first variable ("Stud ID")
                        fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                        drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame <- data.frame(predict(dummy.vars, newdata=ER_data_total[,-1]))  
# str(dummy.frame)

dummy.vars.phonescreen <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                    data=ER_data_total.phonescreen[,-1],  # omit first variable ("Stud ID")
                                    fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                    drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.phonescreen <- data.frame(predict(dummy.vars.phonescreen, newdata=ER_data_total.phonescreen[,-1]))  
# str(dummy.frame)



dummy.vars.data_total.phonescreen <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                               data=data_total.phonescreen[,-1],  # omit first variable ("Stud ID")
                                               fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                               drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.data_total.phonescreen  <- data.frame(predict(dummy.vars.data_total.phonescreen, newdata=data_total.phonescreen[,-1]))  
# str(dummy.frame)


dummy.vars.ER_data_total.6m_cases <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                               data=ER_data_total.6m_cases[,-1],  # omit first variable ("Stud ID")
                                               fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                               drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.ER_data_total.6m_cases  <- data.frame(predict(dummy.vars.ER_data_total.6m_cases, newdata=ER_data_total.6m_cases[,-1]))  
# str(dummy.frame)


dummy.vars.ER_data_total.12m_cases <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                                data=ER_data_total.12m_cases[,-1],  # omit first variable ("Stud ID")
                                                fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                                drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.ER_data_total.12m_cases  <- data.frame(predict(dummy.vars.ER_data_total.12m_cases, newdata=ER_data_total.12m_cases[,-1]))  
# str(dummy.frame)


dummy.vars.ER_data_total.ps.6m_cases  <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                                   data=ER_data_total.ps.6m_cases[,-1],  # omit first variable ("Stud ID")
                                                   fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                                   drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.ER_data_total.ps.6m_cases   <- data.frame(predict(dummy.vars.ER_data_total.ps.6m_cases, newdata=ER_data_total.ps.6m_cases[,-1]))  
# str(dummy.frame)

str(ER_data_total.ps.6m_cases)


dummy.vars.ER_data_total.ps.12m_cases  <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                                    data=ER_data_total.ps.12m_cases[,-1],  # omit first variable ("Stud ID")
                                                    fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                                    drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.ER_data_total.ps.12m_cases   <- data.frame(predict(dummy.vars.ER_data_total.ps.12m_cases, newdata=ER_data_total.ps.12m_cases[,-1]))  
# str(dummy.frame)


dummy.vars.data_total.ps.6m_cases  <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                                data=data_total.ps.6m_cases[,-1],  # omit first variable ("Stud ID")
                                                fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                                drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.data_total.ps.6m_cases  <- data.frame(predict(dummy.vars.data_total.ps.6m_cases, newdata=data_total.ps.6m_cases[,-1]))  
# str(dummy.frame)



dummy.vars.data_total.ps.12m_cases  <- dummyVars(~.,                     # use all varibales of the dataset in the forumla ~.
                                                 data=data_total.ps.12m_cases[,-1],  # omit first variable ("Stud ID")
                                                 fullRank = FALSE,       # A logical; should a full rank or less than full rank parameterization be used? If TRUE, factors are encoded to be consistent with model.matrix and the resulting there are no linear dependencies induced between the columns.
                                                 drop2nd = FALSE)        # A logical: if the factor has two levels, should a single binary vector be returned?



# The output of dummyVars is a list of class 'dummyVars' with elements
# The predict function produces a data frame by taking the required columns for the dataframe from newdata
dummy.frame.data_total.ps.12m_cases <- data.frame(predict(dummy.vars.data_total.ps.12m_cases, newdata=data_total.ps.12m_cases[,-1]))  
# str(dummy.frame)


#-- All data with categorical variables dummy coded with linear combinations removed
dummy.vars.fullRank <- dummyVars(~., data=ER_data_total[,-1], fullRank = TRUE)  
dummy.frame.fullRank <- data.frame(predict(dummy.vars.fullRank, newdata=ER_data_total[,-1]))  


#-- All data with categorical variables dummy coded with linear combinations removed
dummy.vars.fullRank.phonescreen <- dummyVars(~., data=ER_data_total.phonescreen[,-1], fullRank = TRUE)  
dummy.frame.fullRank.phonescreen <- data.frame(predict(dummy.vars.fullRank.phonescreen, newdata=ER_data_total.phonescreen[,-1]))  



#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo <- dummyVars(~.,  data=ER_data_total[,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo <- data.frame(predict(dummy.vars.ER.noCombo, newdata=ER_data_total[,-1]))  
# str(dummy.frame)



#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.phonescreen <- dummyVars(~.,  data=ER_data_total.phonescreen[,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.phonescreen <- data.frame(predict(dummy.vars.ER.noCombo.phonescreen, newdata=ER_data_total.phonescreen[,-1]))  
# str(dummy.frame)




#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.data_total.phonescreen  <- dummyVars(~.,  data=data_total.phonescreen [,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.data_total.phonescreen  <- data.frame(predict(dummy.vars.ER.noCombo.data_total.phonescreen , newdata=data_total.phonescreen[,-1]))  
# str(dummy.frame)



#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.ER_data_total.6m_cases  <- dummyVars(~.,  data=ER_data_total.6m_cases[,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.ER_data_total.6m_cases  <- data.frame(predict(dummy.vars.ER.noCombo.ER_data_total.6m_cases, newdata=ER_data_total.6m_cases[,-1]))  
# str(dummy.frame)



#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.ER_data_total.12m_cases  <- dummyVars(~.,  data=ER_data_total.12m_cases[,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.ER_data_total.12m_cases  <- data.frame(predict(dummy.vars.ER.noCombo.ER_data_total.12m_cases, newdata=ER_data_total.12m_cases[,-1]))  
# str(dummy.frame)


#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.ER_data_total.ps.6m_cases   <- dummyVars(~.,  data=ER_data_total.ps.6m_cases [,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.ER_data_total.ps.6m_cases  <- data.frame(predict(dummy.vars.ER.noCombo.ER_data_total.ps.6m_cases, newdata=ER_data_total.ps.6m_cases [,-1]))  
# str(dummy.frame)



#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.ER_data_total.ps.12m_cases    <- dummyVars(~.,  data=ER_data_total.ps.12m_cases[,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.ER_data_total.ps.12m_cases  <- data.frame(predict(dummy.vars.ER.noCombo.ER_data_total.ps.12m_cases, newdata=ER_data_total.ps.12m_cases[,-1]))  
# str(dummy.frame)



#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.data_total.ps.6m_cases  <- dummyVars(~.,  data=data_total.ps.6m_cases[,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.data_total.ps.6m_cases <- data.frame(predict(dummy.vars.ER.noCombo.data_total.ps.6m_cases, newdata=data_total.ps.6m_cases[,-1]))  
# str(dummy.frame)


#-- ER admission, no linear combinations: 
dummy.vars.ER.noCombo.data_total.ps.12m_cases  <- dummyVars(~.,  data=data_total.ps.12m_cases[,-1],  fullRank = TRUE)        
dummy.frame.ER.noCombo.data_total.ps.12m_cases  <- data.frame(predict(dummy.vars.ER.noCombo.data_total.ps.12m_cases, newdata=data_total.ps.12m_cases[,-1]))  
# str(dummy.frame)




#-- ER admission:
dummy.vars.ER <- dummyVars(~.,  data=ER_data_total[,-1],  fullRank = FALSE)        
dummy.frame.ER <- data.frame(predict(dummy.vars.ER, newdata=ER_data_total[,-1]))  
# str(dummy.frame)



#-- ER admission:
dummy.vars.ER.phonescreen <- dummyVars(~.,  data=ER_data_total.phonescreen[,-1],  fullRank = FALSE)        
dummy.frame.ER.phonescreen <- data.frame(predict(dummy.vars.ER.phonescreen, newdata=ER_data_total.phonescreen[,-1]))  
# str(dummy.frame)



#-- Dummy coded data frame with only numerical predictors
dummy.num <- dummyVars(~., data=ER_data_onlynumeric[,-1],fullRank = FALSE, drop2nd = FALSE)
dummy.frame.numeric <- data.frame(predict(dummy.num, newdata=ER_data_onlynumeric[,-1]))




#-- Dummy coded data frame with only numerical predictors
dummy.num.phonescreen <- dummyVars(~., data=ER_data_onlynumeric.phonescreen[,-1],fullRank = FALSE, drop2nd = FALSE)
dummy.frame.numeric.phonescreen <- data.frame(predict(dummy.num.phonescreen, newdata=ER_data_onlynumeric.phonescreen[,-1]))



#-- Dummy coded data frame with only categorical predictors
dummy.factor <- dummyVars(~., data=ER_data_onlyfactor[,-1],fullRank = FALSE, drop2nd = FALSE)
dummy.frame.factor <- data.frame(predict(dummy.factor, newdata=ER_data_onlyfactor[,-1])) 



#-- Dummy coded data frame with only categorical predictors
dummy.factor.phonescreen <- dummyVars(~., data=ER_data_onlyfactor.phonescreen[,-1],fullRank = FALSE, drop2nd = FALSE)
dummy.frame.factor.phonescreen <- data.frame(predict(dummy.factor.phonescreen, newdata=ER_data_onlyfactor.phonescreen[,-1])) 


miss.ratio.noise <- which(colMeans(is.na(dummy.frame)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise <- subset(dummy.frame, select=-miss.ratio.noise)  # remove them from data, i.e. build subset without them. 



miss.ratio.noise.phonescreen <- which(colMeans(is.na(dummy.frame.phonescreen)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.phonescreen <- subset(dummy.frame.phonescreen, select=-miss.ratio.noise.phonescreen)  # remove them from data, i.e. build subset without them. 




miss.ratio.noise.data_total.phonescreen <- which(colMeans(is.na(dummy.frame.data_total.phonescreen)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.data_total.phonescreen <- subset(dummy.frame.data_total.phonescreen, select=-miss.ratio.noise.data_total.phonescreen)  # remove them from data, i.e. build subset without them. 




miss.ratio.noise.ER_data_total.6m_cases <- which(colMeans(is.na(dummy.frame.ER_data_total.6m_cases)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.ER_data_total.6m_cases <- subset(dummy.frame.ER_data_total.6m_cases, select=-miss.ratio.noise.ER_data_total.6m_cases)  # remove them from data, i.e. build subset without them. 





miss.ratio.noise.ER_data_total.12m_cases <- which(colMeans(is.na(dummy.frame.ER_data_total.12m_cases)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.ER_data_total.12m_cases <- subset(dummy.frame.ER_data_total.12m_cases, select=-miss.ratio.noise.ER_data_total.12m_cases)  # remove them from data, i.e. build subset without them. 






miss.ratio.noise.ER_data_total.ps.6m_cases <- which(colMeans(is.na(dummy.frame.ER_data_total.ps.6m_cases)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.ER_data_total.ps.6m_cases <- subset(dummy.frame.ER_data_total.ps.6m_cases, select=-miss.ratio.noise.ER_data_total.ps.6m_cases)  # remove them from data, i.e. build subset without them. 



miss.ratio.noise.ER_data_total.ps.12m_cases  <- which(colMeans(is.na(dummy.frame.ER_data_total.ps.12m_cases)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.ER_data_total.ps.12m_cases <- subset(dummy.frame.ER_data_total.ps.12m_cases, select=-miss.ratio.noise.ER_data_total.ps.12m_cases)  # remove them from data, i.e. build subset without them. 


miss.ratio.noise.data_total.ps.6m_cases  <- which(colMeans(is.na(dummy.frame.data_total.ps.6m_cases)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.data_total.ps.6m_cases <- subset(dummy.frame.data_total.ps.6m_cases, select=-miss.ratio.noise.data_total.ps.6m_cases)  # remove them from data, i.e. build subset without them. 


miss.ratio.noise.data_total.ps.12m_cases  <- which(colMeans(is.na(dummy.frame.data_total.ps.12m_cases)) > 0.45)   # identify variables with mor the 30% of missing data
dummy.frame.rm.noise.data_total.ps.12m_cases <- subset(dummy.frame.data_total.ps.12m_cases, select=-miss.ratio.noise.data_total.ps.12m_cases)  # remove them from data, i.e. build subset without them. 




miss.ratio <- which(colMeans(is.na(dummy.frame)) > 0.35)   # identify variables with mor the 30% of missing data
dummy.frame.rm <- subset(dummy.frame, select=-miss.ratio)  # remove them from data, i.e. build subset without them. 



miss.ratio.phonescreen <- which(colMeans(is.na(dummy.frame.phonescreen)) > 0.35)   # identify variables with mor the 30% of missing data
dummy.frame.rm.phonescreen <- subset(dummy.frame.phonescreen, select=-miss.ratio.phonescreen)  # remove them from data, i.e. build subset without them. 



miss.ratio.ER <- which(colMeans(is.na(dummy.frame.ER)) > 0.35)  
dummy.frame.ER.rm <- subset(dummy.frame.ER, select=-miss.ratio.ER)  


miss.ratio.ER.phonescreen <- which(colMeans(is.na(dummy.frame.ER.phonescreen)) > 0.35)  
dummy.frame.ER.rm.phonescreen <- subset(dummy.frame.ER.phonescreen, select=-miss.ratio.ER.phonescreen)  



miss.ratio.data_total.phonescreen  <- which(colMeans(is.na(dummy.frame.data_total.phonescreen)) > 0.35)  
dummy.frame.ER.rm.data_total.phonescreen  <- subset(dummy.frame.data_total.phonescreen, select=-miss.ratio.data_total.phonescreen )  




miss.ratio.ER_data_total.6m_cases   <- which(colMeans(is.na(dummy.frame.ER_data_total.6m_cases )) > 0.35)  
dummy.frame.ER.rm.ER_data_total.6m_cases   <- subset(dummy.frame.ER_data_total.6m_cases, select=-miss.ratio.ER_data_total.6m_cases)  




miss.ratio.ER_data_total.12m_cases   <- which(colMeans(is.na(dummy.frame.ER_data_total.12m_cases)) > 0.35)  
dummy.frame.ER.rm.ER_data_total.12m_cases   <- subset(dummy.frame.ER_data_total.12m_cases, select=-miss.ratio.ER_data_total.12m_cases)  


miss.ratio.ER_data_total.ps.6m_cases    <- which(colMeans(is.na(dummy.frame.ER_data_total.ps.6m_cases)) > 0.35)  
dummy.frame.ER.rm.ER_data_total.ps.6m_cases   <- subset(dummy.frame.ER_data_total.ps.6m_cases, select=-miss.ratio.ER_data_total.ps.6m_cases)  



miss.ratio.ER_data_total.ps.12m_cases    <- which(colMeans(is.na(dummy.frame.ER_data_total.ps.12m_cases)) > 0.35)  
dummy.frame.ER.rm.ER_data_total.ps.12m_cases  <- subset(dummy.frame.ER_data_total.ps.12m_cases, select=-miss.ratio.ER_data_total.ps.12m_cases)  



miss.ratio.data_total.ps.6m_cases    <- which(colMeans(is.na(dummy.frame.data_total.ps.6m_cases)) > 0.35)  
dummy.frame.ER.rm.data_total.ps.6m_cases  <- subset(dummy.frame.data_total.ps.6m_cases, select=-miss.ratio.data_total.ps.6m_cases)  




miss.ratio.data_total.ps.12m_cases   <- which(colMeans(is.na(dummy.frame.data_total.ps.12m_cases)) > 0.35)  
dummy.frame.ER.rm.data_total.ps.12m_cases <- subset(dummy.frame.data_total.ps.12m_cases, select=-miss.ratio.data_total.ps.12m_cases)  



miss.ratio.ER <- which(colMeans(is.na(dummy.frame.ER.noCombo)) > 0.35)  
dummy.frame.ER.noCombo.rm <- subset(dummy.frame.ER.noCombo, select=-miss.ratio.ER)  


miss.ratio.ER.phonescreen <- which(colMeans(is.na(dummy.frame.ER.noCombo.phonescreen)) > 0.35)  
dummy.frame.ER.noCombo.rm.phonescreen <- subset(dummy.frame.ER.noCombo.phonescreen, select=-miss.ratio.ER.phonescreen)  


miss.ratio.data_total.phonescreen <- which(colMeans(is.na(dummy.frame.ER.noCombo.data_total.phonescreen)) > 0.35)  
dummy.frame.ER.noCombo.rm.data_total.phonescreen <- subset(dummy.frame.ER.noCombo.data_total.phonescreen, select=-miss.ratio.data_total.phonescreen)  


miss.ratio.ER_data_total.6m_cases <- which(colMeans(is.na(dummy.frame.ER.noCombo.ER_data_total.6m_cases)) > 0.35)  
dummy.frame.ER.noCombo.rm.ER_data_total.6m_cases <- subset(dummy.frame.ER.noCombo.ER_data_total.6m_cases, select=-miss.ratio.ER_data_total.6m_cases)  

miss.ratio.ER_data_total.12m_cases <- which(colMeans(is.na(dummy.frame.ER.noCombo.ER_data_total.12m_cases)) > 0.35)  
dummy.frame.ER.noCombo.rm.ER_data_total.12m_cases <- subset(dummy.frame.ER.noCombo.ER_data_total.12m_cases, select=-miss.ratio.ER_data_total.12m_cases)  

miss.ratio.ER_data_total.ps.6m_cases  <- which(colMeans(is.na(dummy.frame.ER.noCombo.ER_data_total.ps.6m_cases)) > 0.35)  
dummy.frame.ER.noCombo.rm.ER_data_total.ps.6m_cases <- subset(dummy.frame.ER.noCombo.ER_data_total.ps.6m_cases, select=-miss.ratio.ER_data_total.ps.6m_cases)  



miss.ratio.ER_data_total.ps.12m_cases   <- which(colMeans(is.na(dummy.frame.ER.noCombo.ER_data_total.ps.12m_cases)) > 0.35)  
dummy.frame.ER.noCombo.rm.ER_data_total.ps.12m_cases  <- subset(dummy.frame.ER.noCombo.ER_data_total.ps.12m_cases, select=-miss.ratio.ER_data_total.ps.12m_cases)  


miss.ratio.data_total.ps.6m_cases   <- which(colMeans(is.na(dummy.frame.ER.noCombo.data_total.ps.6m_cases)) > 0.35)  
dummy.frame.ER.noCombo.rm.data_total.ps.6m_cases <- subset(dummy.frame.ER.noCombo.data_total.ps.6m_cases, select=-miss.ratio.data_total.ps.6m_cases)  



miss.ratio.data_total.ps.12m_cases  <- which(colMeans(is.na(dummy.frame.ER.noCombo.data_total.ps.12m_cases)) > 0.35)  
dummy.frame.ER.noCombo.rm.data_total.ps.12m_cases  <- subset(dummy.frame.ER.noCombo.data_total.ps.12m_cases, select=-miss.ratio.data_total.ps.12m_cases)  




#-- save reponse variable for multinomial classification
multiclass_resp <- as.factor(ER_onlyER_quar$class)

resp_6m_cases <- as.factor(PCL5_cases_6m_ER$pcl5_6m_cases)

resp_12m_cases <- as.factor(PCL5_cases_12m_ER$pcl5_12m_cases)



#-- make sure the names of the level for the multiclass response is in correct format for R
levels(multiclass_resp) <- make.names(levels(factor(multiclass_resp)))


levels(resp_6m_cases) <- make.names(levels(factor(resp_6m_cases)))
levels(resp_12m_cases) <- make.names(levels(factor(resp_12m_cases)))

##...........................................................
##
#-- Create a stratified random split of data so that the response is proptionally distribute in test and training set
split <- createDataPartition(multiclass_resp, # split random selection of row numbers but stratified to the response 
                             p=.8,            # train models with 80% of data and test predictive power on the rest
                             list=FALSE)      # do not return as list 


str(multiclass_resp)


split.6m <- createDataPartition(resp_6m_cases, # split random selection of row numbers but stratified to the response 
                                p=.8,            # train models with 80% of data and test predictive power on the rest
                                list=FALSE)      # do not return as list 



split.12m <- createDataPartition(resp_12m_cases, # split random selection of row numbers but stratified to the response 
                                 p=.8,            # train models with 80% of data and test predictive power on the rest
                                 list=FALSE)      # do not return as list 


#-- Define multinomial outcome to train the model and to predict the test set:
multi_y.train <- multiclass_resp[split]     # select 80% of the response as y of training set 
multi_y.test  <- multiclass_resp[-split]    # y of test set 


resp6m_y.train <- resp_6m_cases[split.6m]     # select 80% of the response as y of training set 
resp6m_y.test  <- resp_6m_cases[-split.6m]    # y of test set 

resp12m_y.train <- resp_12m_cases[split.12m]     # select 80% of the response as y of training set 
resp12m_y.test  <- resp_12m_cases[-split.12m]    # y of test set 



#-- Define Gaussian outcome to train the model and to predict the test set:
#y.train <- resp[split]     # select 80% of the response as y of training set 
#y.test  <- resp[-split]    # y of test set 



#-- Define predictors of training set:
x.onlyER.train <- dummy.frame.rm.noise[split, ]      # Select 80% of rows of predictor data as x of training set 
x.onlyER.test  <- dummy.frame.rm.noise[-split, ]     # the rest is the x of the test set 



#-- Define predictors of training set:
x.onlyER.train.phonescreen <- dummy.frame.rm.noise.phonescreen[split, ]      # Select 80% of rows of predictor data as x of training set 
x.onlyER.test.phonescreen  <- dummy.frame.rm.noise.phonescreen[-split, ]     # the rest is the x of the test set 


#-- Define predictors of training set:
x.train.phonescreen <- dummy.frame.rm.noise.data_total.phonescreen[split, ]      # Select 80% of rows of predictor data as x of training set 
x.test.phonescreen  <- dummy.frame.rm.noise.data_total.phonescreen[-split, ]     # the rest is the x of the test set 




## cases 6 months

#-- Define predictors of training set:
x.train.6m.ER <- dummy.frame.rm.noise.ER_data_total.6m_cases[split.6m, ]      # Select 80% of rows of predictor data as x of training set 
x.test.6m.ER  <- dummy.frame.rm.noise.ER_data_total.6m_cases[-split.6m, ]     # the rest is the x of the test set 



x.train.6m.ER.ps <- dummy.frame.rm.noise.ER_data_total.ps.6m_cases[split.6m, ]      # Select 80% of rows of predictor data as x of training set 
x.test.6m.ER.ps  <- dummy.frame.rm.noise.ER_data_total.ps.6m_cases[-split.6m, ]     # the rest is the x of the test set 


x.train.6m.ps <- dummy.frame.rm.noise.data_total.ps.6m_cases[split.6m, ]      # Select 80% of rows of predictor data as x of training set 
x.test.6m.ps  <- dummy.frame.rm.noise.data_total.ps.6m_cases[-split.6m, ]     # the rest is the x of the test set 



## cases 12 months

#-- Define predictors of training set:
x.train.12m.ER <- dummy.frame.rm.noise.ER_data_total.12m_cases[split.12m, ]      # Select 80% of rows of predictor data as x of training set 
x.test.12m.ER  <- dummy.frame.rm.noise.ER_data_total.12m_cases[-split.12m, ]     # the rest is the x of the test set 


x.train.12m.ER.ps <- dummy.frame.rm.noise.ER_data_total.ps.12m_cases[split.12m, ]      # Select 80% of rows of predictor data as x of training set 
x.test.12m.ER.ps  <- dummy.frame.rm.noise.ER_data_total.ps.12m_cases[-split.12m, ]     # the rest is the x of the test set 



x.train.12m.ps <- dummy.frame.rm.noise.data_total.ps.12m_cases[split.12m, ]      # Select 80% of rows of predictor data as x of training set 
x.test.12m.ps  <- dummy.frame.rm.noise.data_total.ps.12m_cases[-split.12m, ]     # the rest is the x of the test set 




#-- Define predictors of training set:
x.onlyER.rm.train <- dummy.frame.ER.rm[split, ]    # Select 80% of rows of predictor data as x of training set 
x.onlyER.rm.test  <- dummy.frame.ER.rm[-split, ]  # the rest is the x of the test set 


#-- Define predictors of training set:
x.onlyER.rm.train.phonescreen <- dummy.frame.ER.rm.phonescreen[split, ]    # Select 80% of rows of predictor data as x of training set 
x.onlyER.rm.test.phonescreen <- dummy.frame.ER.rm.phonescreen[-split, ]  # the rest is the x of the test set 


#-- Define predictors of training set:
x.rm.train.phonescreen <- dummy.frame.ER.rm.data_total.phonescreen[split, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.phonescreen <- dummy.frame.ER.rm.data_total.phonescreen[-split, ]  # the rest is the x of the test set 


#-- Define predictors of training set:
x.rm.train.ER <- dummy.frame.ER.rm.ER_data_total.6m_cases[split.6m, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.ER <- dummy.frame.ER.rm.ER_data_total.6m_cases[-split.6m, ]  # the rest is the x of the test set 


#-- Define predictors of training set:
x.rm.train.6m.ER <- dummy.frame.ER.rm.ER_data_total.6m_cases[split.6m, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.6m.ER <- dummy.frame.ER.rm.ER_data_total.6m_cases[-split.6m, ]  # the rest is the x of the test set 


x.rm.train.6m.ER.ps <- dummy.frame.ER.rm.ER_data_total.ps.6m_cases[split.6m, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.6m.ER.ps <- dummy.frame.ER.rm.ER_data_total.ps.6m_cases[-split.6m, ]  # the rest is the x of the test set 


x.rm.train.6m.ps <- dummy.frame.ER.rm.data_total.ps.6m_cases[split.6m, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.6m.ps <- dummy.frame.ER.rm.data_total.ps.6m_cases[-split.6m, ]  # the rest is the x of the test set 



x.rm.train.12m.ER <- dummy.frame.ER.rm.ER_data_total.12m_cases[split.12m, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.12m.ER <- dummy.frame.ER.rm.ER_data_total.12m_cases[-split.12m, ]  # the rest is the x of the test set 


x.rm.train.12m.ER.ps <- dummy.frame.ER.rm.ER_data_total.ps.12m_cases[split.12m, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.12m.ER.ps  <- dummy.frame.ER.rm.ER_data_total.ps.12m_cases[-split.12m, ]  # the rest is the x of the test set 


x.rm.train.12m.ps <- dummy.frame.ER.rm.data_total.ps.12m_cases[split.12m, ]    # Select 80% of rows of predictor data as x of training set 
x.rm.test.12m.ps <- dummy.frame.ER.rm.data_total.ps.12m_cases[-split.12m, ]  # the rest is the x of the test set 


#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.onlyER.rm.noCombo.train <- dummy.frame.ER.noCombo.rm[split, ]   
x.onlyER.rm.noCombo.test  <- dummy.frame.ER.noCombo.rm[-split, ]   

#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.onlyER.rm.noCombo.train.phonescreen <- dummy.frame.ER.noCombo.rm.phonescreen[split, ]   
x.onlyER.rm.noCombo.test.phonescreen  <- dummy.frame.ER.noCombo.rm.phonescreen[-split, ]   

#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.rm.noCombo.train.phonescreen <- dummy.frame.ER.noCombo.rm.data_total.phonescreen[split, ]   
x.rm.noCombo.test.phonescreen  <- dummy.frame.ER.noCombo.rm.data_total.phonescreen[-split, ]   

#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.rm.noCombo.train.6m.ER <- dummy.frame.ER.noCombo.rm.ER_data_total.6m_cases[split.6m, ]   
x.rm.noCombo.test.6m.ER  <- dummy.frame.ER.noCombo.rm.ER_data_total.6m_cases[-split.6m, ]   

#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.rm.noCombo.train.6m.ER.ps <- dummy.frame.ER.noCombo.rm.ER_data_total.ps.6m_cases[split.6m, ]   
x.rm.noCombo.test.6m.ER.ps  <- dummy.frame.ER.noCombo.rm.ER_data_total.ps.6m_cases[-split.6m, ]   

#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.rm.noCombo.train.6m.ps <- dummy.frame.ER.noCombo.rm.data_total.ps.6m_cases[split.6m, ]   
x.rm.noCombo.test.6m.ps  <- dummy.frame.ER.noCombo.rm.data_total.ps.6m_cases[-split.6m, ]   


#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.rm.noCombo.train.12m.ER <- dummy.frame.ER.noCombo.rm.ER_data_total.12m_cases[split.12m, ]   
x.rm.noCombo.test.12m.ER  <- dummy.frame.ER.noCombo.rm.ER_data_total.12m_cases[-split.12m, ]   

#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.rm.noCombo.train.12m.ER.ps <- dummy.frame.ER.noCombo.rm.ER_data_total.ps.12m_cases[split.12m, ]   
x.rm.noCombo.test.12m.ER.ps  <- dummy.frame.ER.noCombo.rm.ER_data_total.ps.12m_cases[-split.12m, ]   

#-- Define predictors of training set for R.data.onlyT3_T4_t5.noCombo:
x.rm.noCombo.train.12m.ps <- dummy.frame.ER.noCombo.rm.data_total.ps.12m_cases[split.12m, ]   
x.rm.noCombo.test.12m.ps  <- dummy.frame.ER.noCombo.rm.data_total.ps.12m_cases[-split.12m, ]   



save.image(file = "Bellevue.preprocess_ALLDATA.RData",            
           ascii = FALSE,
           compress = TRUE,
           safe = TRUE)


