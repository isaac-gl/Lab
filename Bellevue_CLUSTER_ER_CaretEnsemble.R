.libPaths(c("/usr/lib64/R/library", "/usr/share/R/library", "/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"))


setwd("/ifs/home/schulk02/Amsterdam/Bellevue_new")


# set path to locally installed r packages
pkgs <- c("haven", "caret", "MLmetrics", "car", "tibble", "RANN", "ada",
          "ggplot2", "lattice", "monomvn",  "e1071", "gbm", "dplyr",
          "glmnet", "pROC", "sjlabelled", "foreign", "bindrcpp", "adabag", 
          "randomForest", "mlbench", "kernlab", "LiblineaR", "xgboost",
          "caretEnsemble", "Boruta", "nnet")

# Load packages into session 
lapply(pkgs, require,
       lib.loc = c("/ifs/home/schulk02/Amsterdam/TraumaTips/rlib"),
       character.only=TRUE)

# clear variable namespace
rm(pkgs)


set.seed(13)
load("/ifs/home/schulk02/Amsterdam/Bellevue_new/Bellevue.featureSelection.ER_MINIMAL.RData")



# Stacking Algorithms - Run multiple algos in one call.
trainControl.multi_y.train <- trainControl(method="repeatedcv", 
                                         number=10, 
                                         repeats=5,
                                         sampling = "up",
                                         savePredictions= "all",
                                         selectionFunction = "best",
                                         summaryFunction = multiClassSummary,
                                         classProbs = TRUE,
                                         index = createFolds(multi_y.train, 10))

# basic without much model tuning
# algorithmList <- c('rf', 'gbm', 'AdaBoost.M1', 'xgbTree', 'svmPoly', 'svmLinear', 'glmnet', 'nnet')

# advanced with custom tune grid
TuneList <- list(rf1=caretModelSpec(method="rf", tuneGrid=data.frame(.mtry=seq(4,48,2))),
                 gbm=caretModelSpec(method="gbm", tuneGrid=data.frame(interaction.depth = c(3, 5, 7, 9),# Max Tree Depth
                                                                      n.trees = seq(500, 10000, 500),     # Boosting Iterations
                                                                      shrinkage = c(.001),              # Shrinkage
                                                                      n.minobsinnode = c(5, 10,  20,  35))),
                 nn=caretModelSpec(method="nnet", tuneLength=25, trace=FALSE),
                 ada=caretModelSpec(method="AdaBoost.M1", tuneGrid=data.frame(mfinal = 100,
                                                                              maxdepth = 20,
                                                                              coeflearn = "Breiman")),
                 xgb=caretModelSpec(method="xgbTree", tuneGrid=data.frame(nrounds = 5000,        
                                                                          max_depth = 50,           # Max Tree Depth
                                                                          eta = .001,               # Shrinkage
                                                                          gamma = .5,               # Minimum Loss Reduction
                                                                          colsample_bytree = 1,     # Subsample Ratio of Columns
                                                                          min_child_weight = 1,
                                                                          subsample = c(.3, .6, .8, 1))),
                 glmnet=caretModelSpec(method="glmnet", tuneGrid=data.frame(alpha=seq(.01, 1, length = 10),
                                                                            lambda=c(.1, .2, .3, .4, .5, .6, .7, .8, .9, 1))),
                 svmRadial=caretModelSpec(method="svmRadial", tuneGrid=data.frame(sigma=2^c(-25, -20, -15,-10, -5, 0), 
                                                                                  C= 2^c(0:5))),
                 svmPoly=caretModelSpec(method="svmPoly", tuneGrid=data.frame(degree=c(2:8), 
                                                                              scale=c(.1, .05, .03, .01, .005, .003, .001), 
                                                                              C=c(0.01,0.1,1,3,5,10,20))))

set.seed(13)
models.ER <- caretList(x = x.Boruta.train.ER,            
                       y = multi_y.train,            
                       trControl = trainControl.multi_y.train,         
                       preProc=c("zv", "range", "bagImpute"),      
                       metric = "Mean_Balanced_Accuracy",
                       tuneList = TuneList,
                       #methodList=algorithmList,   
                       continue_on_fail = TRUE)  

results.ER <- resamples(models.ER)
summary(results.ER)

saveRDS(results.ER, file = "results.ER.rds", compress = TRUE)
save.image(file = "Bellevue.results.ER.RData",
           ascii = FALSE,
           compress = TRUE,
           safe = TRUE)


models.ER.rm <- caretList(x = x.Boruta.train.ER.rm,            
                          y = multi_y.train,            
                          trControl = trainControl.multi_y.train,         
                          preProc=c("zv", "range", "bagImpute"),      
                          metric = "Mean_Balanced_Accuracy",
                          tuneList = TuneList,
                          #methodList=algorithmList,   
                          continue_on_fail = TRUE) 

results.ER.rm <- resamples(models.ER.rm)
summary(results.ER.rm)

saveRDS(results.ER.rm, file = "results.ER.rm.rds", compress = TRUE)
save.image(file = "Bellevue.results.ER.rm.RData",            
           ascii = FALSE,
           compress = TRUE,
           safe = TRUE)



models.ER.rm.noCombo <- caretList(x = x.Boruta.train.ER.rm.noCombo,           
                                  y = multi_y.train,            
                                  trControl = trainControl.multi_y.train,         
                                  preProc=c("zv", "range", "bagImpute"),      
                                  metric = "Mean_Balanced_Accuracy",
                                  tuneList = TuneList,
                                  #methodList=algorithmList,   
                                  continue_on_fail = TRUE) 

results.ER.rm.noCombo <- resamples(models.ER.rm.noCombo)
summary(results.ER.rm.noCombo)

saveRDS(results.ER.rm.noCombo, file = "results.ER.rm.noCombo.rds", compress = TRUE)
save.image(file = "Bellevue.results.ER.rm.noCombo.RData",          
           ascii = FALSE,
           compress = TRUE,
           safe = TRUE)


sessionInfo()