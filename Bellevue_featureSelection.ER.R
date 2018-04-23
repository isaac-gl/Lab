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

#.libPaths(c("/usr/lib64/R/library", "/usr/share/R/library", "/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"))

# setwd("/ifs/home/schulk02/Amsterdam/TraumaTips")


# set path to locally installed r packages
pkgs <- c("haven", "caret", "MLmetrics", "car", "tibble", "RANN", "ada",
          "ggplot2", "lattice", "monomvn",  "e1071", "gbm", "dplyr",
          "glmnet", "pROC", "sjlabelled", "foreign", "bindrcpp", "adabag", 
          "randomForest", "mlbench", "kernlab", "LiblineaR", "xgboost",
          "caretEnsemble", "Boruta", "nnet")

# Load packages into session 
lapply(pkgs, require,
       # lib.loc = c("/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"),
       character.only=TRUE)

# clear variable namespace
rm(pkgs)


set.seed(13)

# load("/ifs/home/schulk02/Amsterdam/TraumaTips/Bellevue.preprocess.RData")
load("Bellevue.preprocess_ALLDATA.RData")

# feature selection
set.seed(13)

# Botuta does not like NA, so let's preprocess the data first
p1.ER <- preProcess(x.onlyER.train,
                    method=c("range", "nzv", "bagImpute"))

p1.ER.rm <- preProcess(x.onlyER.rm.train,
                       method=c("range", "nzv", "bagImpute"))

p1.ER.rm.noCombo <- preProcess(x.onlyER.rm.noCombo.train,
                               method=c("range", "nzv", "bagImpute"))


# trnasform the preprocessed data into data.frame
set.seed(13)
x1.ER <- predict(p1.ER, 
                 x.onlyER.train)

x1.ER.rm <- predict(p1.ER.rm, 
                    x.onlyER.rm.train)

x1.ER.rm.noCombo <- predict(p1.ER.rm.noCombo, 
                            x.onlyER.rm.noCombo.train)


# Apply the Borute algorithm which is random forest based
b1.ER <- Boruta(x = x1.ER,
                y = multi_y.train,  
                doTrace = 0)      # verbosity = 2, mute = 0


b1.ER.rm <- Boruta(x = x1.ER.rm,
                   y = multi_y.train,  
                   doTrace = 0)      # verbosity = 2, mute = 0



b1.ER.rm.noCombo <- Boruta(x = x1.ER.rm.noCombo ,
                           y = multi_y.train,  
                           doTrace = 0)      # verbosity = 2, mute = 0

# Plot the results
plot.b1.ER  <-plot(b1.ER)
#ggsave("plot.b1.class ", plot = plot.b1.class )
plot.b1.ER.rm  <-plot(b1.ER.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )
plot.b1.ER.rm.noCombo  <-plot(b1.ER.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )


# make a subset of the dataset with only the confirmed or tentative predictors
selected1.ER <- getSelectedAttributes(b1.ER, withTentative = TRUE)
selected1.ER.rm <- getSelectedAttributes(b1.ER.rm, withTentative = TRUE)
selected1.ER.rm.noCombo <- getSelectedAttributes(b1.ER.rm.noCombo, withTentative = TRUE)


x.Boruta.train.ER <- subset(x.onlyER.train,
                            select = selected1.ER)

x.Boruta.train.ER.rm <- subset(x.onlyER.rm.train,
                               select = selected1.ER.rm)

x.Boruta.train.ER.rm.noCombo <- subset(x.onlyER.rm.noCombo.train,
                                       select = selected1.ER.rm.noCombo)


x.Boruta.test.ER <- subset(x.onlyER.test,
                           select = selected1.ER)

x.Boruta.test.ER.rm <- subset(x.onlyER.rm.test,
                              select = selected1.ER.rm)

x.Boruta.test.ER.rm.noCombo <- subset(x.onlyER.rm.noCombo.test,
                                      select = selected1.ER.rm.noCombo)


# remove everything but the feature selected data + the reponse vars
rm(list=setdiff(ls(), list("x.Boruta.train.ER",
                           "x.Boruta.test.ER",
                           "x.Boruta.train.ER.rm",
                           "x.Boruta.test.ER.rm",
                           "x.Boruta.train.ER.rm.noCombo",
                           "x.Boruta.test.ER.rm.noCombo",
                           "multi_y.train")))

save.image(file = "Bellevue.featureSelection.ER_MINIMAL.RData", 
           ascii = FALSE,
           compress = TRUE,
           safe = TRUE)
