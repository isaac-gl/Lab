






.libPaths(c("/usr/lib64/R/library", "/usr/share/R/library", "/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"))



# set path to locally installed r packages


pkgs <- c("haven", "caret", "MLmetrics", "car", "tibble", "RANN", "fastAdaboost", "xgboost",
          "ggplot2", "lattice", "monomvn", "missForest", "e1071",
          "gbm", "dplyr", "glmnet", "pROC", "sjlabelled", "foreign", "bindrcpp", "adabag", "randomForest",
          "mlbench", "kernlab", "LiblineaR", "DMwR", "ROSE", "survival", "foreach", "caretEnsemble", "Boruta", "nnet")




# Load packages into session 
lapply(pkgs, require, character.only=TRUE, lib.loc = c("/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"))

# clear variable namespace
rm(pkgs)

sessionInfo()



set.seed(13) 





setwd("/ifs/home/schulk02/Amsterdam/Amsterdam/")

load("/ifs/home/schulk02/Amsterdam/Amsterdam/TraumaTips_Datasets.RData")

# Stacking Algorithms - Run multiple algos in one call.
trainControl <- trainControl(method="repeatedcv", 
                             number=3, 
                             repeats=20,
                             sampling = "up",
                             savePredictions= "all",
                             selectionFunction = "best",
                             summaryFunction=multiClassSummary,
                             classProbs=TRUE)

algorithmList <- c('rf', 'AdaBoost.M1', 'gbm', 'xgbTree', 'nnet')

set.seed(13)
models <- caretList(y= multi_y.train, 
                    x = x.BorutaErBackPsych.4Class.train, 
                    trControl=trainControl, 
                    preProcess = c("range", 
                                   "nzv", 
                                   "bagImpute"),
                    tuneLength = 30,
                    metric = "Mean_Balanced_Accuracy",
                    methodList=algorithmList) 

results <- resamples(models)
summary(results)


save.image(file = "/ifs/home/schulk02/Amsterdam/Amsterdam/TraumaTips_RESULTS_CLUSTER.RData",
           version = NULL,
           ascii = FALSE,
           compress = TRUE,
           safe = TRUE)


