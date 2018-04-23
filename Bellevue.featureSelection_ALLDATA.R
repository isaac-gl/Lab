# feature selection
set.seed(13)


# Botuta does not like NA, so let's preprocess the data first
p1.ER <- preProcess(x.onlyER.train,
                    method=c("range", "nzv", "bagImpute"))


p1.ER.phonescreen <- preProcess(x.onlyER.train.phonescreen,
                                method=c("range", "nzv", "bagImpute"))


p1.ER.rm <- preProcess(x.onlyER.rm.train,
                       method=c("range", "nzv", "bagImpute"))


p1.ER.phonescreen.rm <- preProcess(x.onlyER.rm.train.phonescreen,
                                   method=c("range", "nzv", "bagImpute"))


p1.ER.rm.noCombo <- preProcess(x.onlyER.rm.noCombo.train,
                               method=c("range", "nzv", "bagImpute"))


p1.ER.phonescreen.rm.noCombo <- preProcess(x.onlyER.rm.noCombo.train.phonescreen,
                                           method=c("range", "nzv", "bagImpute"))



p1.phonescreen <- preProcess(x.train.phonescreen,
                             method=c("range", "nzv", "bagImpute"))


p1.rm.phonescreen <- preProcess(x.rm.train.phonescreen,
                                method=c("range", "nzv", "bagImpute"))


p1.rm.noCombo.phonescreen <- preProcess(x.rm.noCombo.train.phonescreen,
                                        method=c("range", "nzv", "bagImpute"))





p1.6m.ER <- preProcess(x.train.6m.ER,
                       method=c("range", "nzv", "bagImpute"))



p1.6m.ER.rm <- preProcess(x.rm.train.6m.ER,
                          method=c("range", "nzv", "bagImpute"))


p1.6m.ER.rm.noCombo <- preProcess(x.rm.noCombo.train.6m.ER,
                                  method=c("range", "nzv", "bagImpute"))





p1.6m.ER.ps <- preProcess(x.train.6m.ER.ps,
                          method=c("range", "nzv", "bagImpute"))



p1.6m.ER.rm.ps <- preProcess(x.rm.train.6m.ER.ps,
                             method=c("range", "nzv", "bagImpute"))


p1.6m.ER.rm.ps.noCombo <- preProcess(x.rm.noCombo.train.6m.ER.ps,
                                     method=c("range", "nzv", "bagImpute"))







p1.6m.ps <- preProcess(x.train.6m.ps,
                       method=c("range", "nzv", "bagImpute"))



p1.6m.ps.rm <- preProcess(x.rm.train.6m.ps,
                          method=c("range", "nzv", "bagImpute"))


p1.6m.ps.rm.noCombo <- preProcess(x.rm.noCombo.train.6m.ps,
                                  method=c("range", "nzv", "bagImpute"))






p1.12m.ER <- preProcess(x.train.12m.ER,
                        method=c("range", "nzv", "bagImpute"))




p1.12m.ER.rm <- preProcess(x.rm.train.12m.ER,
                           method=c("range", "nzv", "bagImpute"))

p1.12m.ER.rm.noCombo <- preProcess(x.rm.noCombo.train.12m.ER,
                                   method=c("range", "nzv", "bagImpute"))




p1.12m.ER.ps <- preProcess(x.train.12m.ER.ps,
                           method=c("range", "nzv", "bagImpute"))


p1.12m.ER.ps.rm <- preProcess(x.rm.train.12m.ER.ps,
                              method=c("range", "nzv", "bagImpute"))


p1.12m.ER.ps.rm.noCombo <- preProcess(x.rm.noCombo.train.12m.ER.ps,
                                      method=c("range", "nzv", "bagImpute"))



p1.12m.ps <- preProcess(x.train.12m.ps,
                        method=c("range", "nzv", "bagImpute"))


p1.12m.ps.rm <- preProcess(x.rm.train.12m.ps,
                           method=c("range", "nzv", "bagImpute"))


p1.12m.ps.rm.noCombo <- preProcess(x.rm.noCombo.train.12m.ps,
                                   method=c("range", "nzv", "bagImpute"))



# trnasform the preprocessed data into data.frame
set.seed(13)
x1.ER <- predict(p1.ER, 
                 x.onlyER.train)


x1.ER.phonescreen <- predict(p1.ER.phonescreen, 
                             x.onlyER.train.phonescreen)


x1.ER.rm <- predict(p1.ER.rm, 
                    x.onlyER.rm.train)


x1.ER.phonescreen.rm <- predict(p1.ER.phonescreen.rm, 
                                x.onlyER.rm.train.phonescreen)



x1.ER.rm.noCombo <- predict(p1.ER.rm.noCombo, 
                            x.onlyER.rm.noCombo.train)



x1.ER.phonescreen.rm.noCombo <- predict(p1.ER.phonescreen.rm.noCombo, 
                                        x.onlyER.rm.noCombo.train.phonescreen)


x1.phonescreen <- predict(p1.phonescreen, 
                          x.train.phonescreen)

x1.rm.phonescreen <- predict(p1.rm.phonescreen, 
                             x.rm.train.phonescreen)


x1.rm.noCombo.phonescreen <- predict(p1.rm.noCombo.phonescreen, 
                                     x.rm.noCombo.train.phonescreen)



x1.6m.ER <- predict(p1.6m.ER, 
                    x.train.6m.ER)

x1.6m.ER.rm <- predict(p1.6m.ER.rm, 
                       x.rm.train.6m.ER)


x1.6m.ER.rm.noCombo <- predict(p1.6m.ER.rm.noCombo, 
                               x.rm.noCombo.train.6m.ER)




x1.6m.ER.ps <- predict(p1.6m.ER.ps, 
                       x.train.6m.ER.ps)

x1.6m.ER.ps.rm <- predict(p1.6m.ER.rm.ps, 
                          x.rm.train.6m.ER.ps)

x1.6m.ER.ps.rm.noCombo <- predict(p1.6m.ER.rm.ps.noCombo, 
                                  x.rm.noCombo.train.6m.ER.ps)




x1.6m.ps <- predict(p1.6m.ps, 
                    x.train.6m.ps)

x1.6m.ps.rm <- predict(p1.6m.ps.rm, 
                       x.rm.train.6m.ps)

x1.6m.ps.rm.noCombo <- predict(p1.6m.ps.rm.noCombo, 
                               x.rm.noCombo.train.6m.ps)



x1.12m.ER <- predict(p1.12m.ER, 
                     x.train.12m.ER)


x1.12m.ER.rm <- predict(p1.12m.ER.rm, 
                        x.rm.train.12m.ER)


x1.12m.ER.rm.noCombo <- predict(p1.12m.ER.rm.noCombo, 
                                x.rm.noCombo.train.12m.ER)


x1.12m.ER.ps <- predict(p1.12m.ER.ps, 
                        x.train.12m.ER.ps)


x1.12m.ER.ps.rm <- predict(p1.12m.ER.ps.rm, 
                           x.rm.train.12m.ER.ps)


x1.12m.ER.ps.rm.noCombo <- predict(p1.12m.ER.ps.rm.noCombo, 
                                   x.rm.noCombo.train.12m.ER.ps)



x1.12m.ps <- predict(p1.12m.ps, 
                     x.train.12m.ps)

x1.12m.ps.rm <- predict(p1.12m.ps.rm, 
                        x.rm.train.12m.ps)


x1.12m.ps.rm.noCombo <- predict(p1.12m.ps.rm.noCombo, 
                                x.rm.noCombo.train.12m.ps)



# Apply the Borute algorithm which is random forest based
b1.ER <- Boruta(x = x1.ER,
                y = multi_y.train,  
                doTrace = 0)      # verbosity = 2, mute = 0

b1.ER.phonescreen <- Boruta(x = x1.ER.phonescreen,
                            y = multi_y.train,  
                            doTrace = 0)      # verbosity = 2, mute = 0

b1.ER.rm <- Boruta(x = x1.ER.rm,
                   y = multi_y.train,  
                   doTrace = 0)      # verbosity = 2, mute = 0


b1.ER.phonescreen.rm <- Boruta(x = x1.ER.phonescreen.rm ,
                               y = multi_y.train,  
                               doTrace = 0)      # verbosity = 2, mute = 0


b1.ER.rm.noCombo <- Boruta(x = x1.ER.rm.noCombo ,
                           y = multi_y.train,  
                           doTrace = 0)      # verbosity = 2, mute = 0



b1.ER.phonescreen.rm.noCombo <- Boruta(x = x1.ER.phonescreen.rm.noCombo ,
                                       y = multi_y.train,  
                                       doTrace = 0)      # verbosity = 2, mute = 0



b1.phonescreen <- Boruta(x = x1.phonescreen ,
                         y = multi_y.train,  
                         doTrace = 0)      # verbosity = 2, mute = 0


b1.rm.phonescreen <- Boruta(x = x1.rm.phonescreen ,
                            y = multi_y.train,  
                            doTrace = 0)      # verbosity = 2, mute = 0

b1.rm.noCombo.phonescreen <- Boruta(x = x1.rm.noCombo.phonescreen ,
                                    y = multi_y.train,  
                                    doTrace = 0)      # verbosity = 2, mute = 0




b1.rm.noCombo.phonescreen <- Boruta(x = x1.rm.noCombo.phonescreen ,
                                    y = multi_y.train,  
                                    doTrace = 0)      # verbosity = 2, mute = 0


b1.6m.ER  <- Boruta(x = x1.6m.ER ,
                    y = resp6m_y.train,  
                    doTrace = 0)      # verbosity = 2, mute = 0

b1.6m.ER.rm   <- Boruta(x = x1.6m.ER.rm ,
                        y = resp6m_y.train,  
                        doTrace = 0)      # verbosity = 2, mute = 0


b1.6m.ER.rm.noCombo  <- Boruta(x = x1.6m.ER.rm.noCombo ,
                               y = resp6m_y.train,  
                               doTrace = 0)      # verbosity = 2, mute = 0



b1.6m.ER.ps  <- Boruta(x = x1.6m.ER.ps ,
                       y = resp6m_y.train,  
                       doTrace = 0)      # verbosity = 2, mute = 0



b1.6m.ER.ps.rm  <- Boruta(x = x1.6m.ER.ps.rm  ,
                          y = resp6m_y.train,  
                          doTrace = 0)      # verbosity = 2, mute = 0


b1.6m.ER.ps.rm.noCombo <- Boruta(x = x1.6m.ER.ps.rm.noCombo  ,
                                 y = resp6m_y.train,  
                                 doTrace = 0)      # verbosity = 2, mute = 0


b1.6m.ps <- Boruta(x = x1.6m.ps  ,
                   y = resp6m_y.train,  
                   doTrace = 0)      # verbosity = 2, mute = 0


b1.6m.ps.rm <- Boruta(x = x1.6m.ps.rm  ,
                      y = resp6m_y.train,  
                      doTrace = 0)      # verbosity = 2, mute = 0


b1.6m.ps.rm.noCombo <- Boruta(x = x1.6m.ps.rm.noCombo  ,
                              y = resp6m_y.train,  
                              doTrace = 0)      # verbosity = 2, mute = 0




b1.12m.ER <- Boruta(x = x1.12m.ER ,
                    y = resp12m_y.train,  
                    doTrace = 0)      # verbosity = 2, mute = 0



b1.12m.ER.rm  <- Boruta(x = x1.12m.ER.rm ,
                        y = resp12m_y.train,  
                        doTrace = 0)      # verbosity = 2, mute = 0


b1.12m.ER.rm.noCombo  <- Boruta(x = x1.12m.ER.rm.noCombo ,
                                y = resp12m_y.train,  
                                doTrace = 0)      # verbosity = 2, mute = 0




b1.12m.ER.ps  <- Boruta(x = x1.12m.ER.ps,
                        y = resp12m_y.train,  
                        doTrace = 0)      # verbosity = 2, mute = 0




b1.12m.ER.ps.rm   <- Boruta(x = x1.12m.ER.ps.rm ,
                            y = resp12m_y.train,  
                            doTrace = 0)      # verbosity = 2, mute = 0



b1.12m.ER.ps.rm.noCombo  <- Boruta(x = x1.12m.ER.ps.rm.noCombo ,
                                   y = resp12m_y.train,  
                                   doTrace = 0)      # verbosity = 2, mute = 0


b1.12m.ps  <- Boruta(x = x1.12m.ps  ,
                     y = resp12m_y.train,  
                     doTrace = 0)      # verbosity = 2, mute = 0


b1.12m.ps.rm  <- Boruta(x = x1.12m.ps.rm  ,
                        y = resp12m_y.train,  
                        doTrace = 0)      # verbosity = 2, mute = 0



b1.12m.ps.rm.noCombo  <- Boruta(x = x1.12m.ps.rm.noCombo ,
                                y = resp12m_y.train,  
                                doTrace = 0)      # verbosity = 2, mute = 0





# Plot the results

plot.b1.ER  <-plot(b1.ER)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.ER.phonescreen  <-plot(b1.ER.phonescreen)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.ER.rm  <-plot(b1.ER.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.ER.phonescreen.rm  <-plot(b1.ER.phonescreen.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.ER.rm.noCombo  <-plot(b1.ER.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.ER.phonescreen.rm.noCombo  <-plot(b1.ER.phonescreen.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )



plot.b1.phonescreen  <-plot(b1.phonescreen)
#ggsave("plot.b1.class ", plot = plot.b1.class )



plot.b1.rm.phonescreen  <-plot(b1.rm.phonescreen)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.rm.noCombo.phonescreen  <-plot(b1.rm.noCombo.phonescreen)
#ggsave("plot.b1.class ", plot = plot.b1.class )




plot.b1.rm.noCombo.phonescreen  <-plot(b1.rm.noCombo.phonescreen)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.6m.ER  <-plot(b1.6m.ER)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.6m.ER.rm  <-plot(b1.6m.ER.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.6m.ER.rm.noCombo  <-plot(b1.6m.ER.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )



plot.b1.6m.ER.ps  <-plot(b1.6m.ER.ps)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.6m.ER.ps.rm  <-plot(b1.6m.ER.ps.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.6m.ER.ps.rm.noCombo  <-plot(b1.6m.ER.ps.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.6m.ps  <-plot(b1.6m.ps)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.6m.ps.rm  <-plot(b1.6m.ps.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.6m.ps.rm.noCombo  <-plot(b1.6m.ps.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.12m.ER  <-plot(b1.12m.ER)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.12m.ER.rm <-plot(b1.12m.ER.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )



plot.b1.12m.ER.rm.noCombo <-plot(b1.12m.ER.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.12m.ER.ps <-plot(b1.12m.ER.ps)
#ggsave("plot.b1.class ", plot = plot.b1.class )

plot.b1.12m.ER.ps.rm <-plot(b1.12m.ER.ps.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )



plot.b1.12m.ER.ps.rm.noCombo <-plot(b1.12m.ER.ps.rm.noCombo)
#ggsave("plot.b1.class ", plot = plot.b1.class )



plot.b1.12m.ps <-plot(b1.12m.ps)
#ggsave("plot.b1.class ", plot = plot.b1.class )



plot.b1.12m.ps.rm <-plot(b1.12m.ps.rm)
#ggsave("plot.b1.class ", plot = plot.b1.class )


plot.b1.12m.ps.rm.noCombo  <-plot(b1.12m.ps.rm.noCombo )
#ggsave("plot.b1.class ", plot = plot.b1.class )





# make a subset of the dataset with only the confirmed or tentative predictors
selected1.ER <- getSelectedAttributes(b1.ER, withTentative = TRUE)
selected1.ER.phonescreen <- getSelectedAttributes(b1.ER.phonescreen, withTentative = TRUE)
selected1.ER.rm <- getSelectedAttributes(b1.ER.rm, withTentative = TRUE)
selected1.ER.phonescreen.rm <- getSelectedAttributes(b1.ER.phonescreen.rm, withTentative = TRUE)
selected1.ER.rm.noCombo <- getSelectedAttributes(b1.ER.rm.noCombo, withTentative = TRUE)
selected1.ER.phonescreen.rm.noCombo <- getSelectedAttributes(b1.ER.phonescreen.rm.noCombo, withTentative = TRUE)
selected1.phonescreen <- getSelectedAttributes(b1.phonescreen, withTentative = TRUE)
selected1.rm.phonescreen <- getSelectedAttributes(b1.rm.phonescreen, withTentative = TRUE)
selected1.rm.noCombo.phonescreen <- getSelectedAttributes(b1.rm.noCombo.phonescreen, withTentative = TRUE)


selected1.6m.ER <- getSelectedAttributes(b1.6m.ER, withTentative = TRUE)
selected1.6m.ER.rm <- getSelectedAttributes(b1.6m.ER.rm, withTentative = TRUE)
selected1.6m.ER.rm.noCombo <- getSelectedAttributes(b1.6m.ER.rm.noCombo, withTentative = TRUE)
selected1.6m.ER.ps <- getSelectedAttributes(b1.6m.ER.ps, withTentative = TRUE)
selected1.6m.ER.ps.rm <- getSelectedAttributes(b1.6m.ER.ps.rm, withTentative = TRUE)
selected1.6m.ER.ps.rm.noCombo <- getSelectedAttributes(b1.6m.ER.ps.rm.noCombo, withTentative = TRUE)
selected1.6m.ps <- getSelectedAttributes(b1.6m.ps, withTentative = TRUE)
selected1.6m.ps.rm <- getSelectedAttributes(b1.6m.ps.rm, withTentative = TRUE)
selected1.6m.ps.rm.noCombo <- getSelectedAttributes(b1.6m.ps.rm.noCombo, withTentative = TRUE)

selected1.12m.ER <- getSelectedAttributes(b1.12m.ER, withTentative = TRUE)
selected1.12m.ER.rm <- getSelectedAttributes(b1.12m.ER.rm, withTentative = TRUE)
selected1.12m.ER.rm.noCombo <- getSelectedAttributes(b1.12m.ER.rm.noCombo, withTentative = TRUE)
selected1.12m.ER.ps <- getSelectedAttributes(b1.12m.ER.ps, withTentative = TRUE)
selected1.12m.ER.ps.rm <- getSelectedAttributes(b1.12m.ER.ps.rm, withTentative = TRUE)
selected1.12m.ER.ps.rm.noCombo <- getSelectedAttributes(b1.12m.ER.ps.rm.noCombo, withTentative = TRUE)
selected1.12m.ps <- getSelectedAttributes(b1.12m.ps, withTentative = TRUE)
selected1.12m.ps.rm <- getSelectedAttributes(b1.12m.ps.rm, withTentative = TRUE)
selected1.12m.ps.rm.noCombo <- getSelectedAttributes(b1.12m.ps.rm.noCombo, withTentative = TRUE)






x.Boruta.train.ER <- subset(x.onlyER.train,
                            select = selected1.ER)

x.Boruta.train.ER.ps <- subset(x.onlyER.train.phonescreen,
                               select = selected1.ER.phonescreen)

x.Boruta.train.ER.rm <- subset(x.onlyER.rm.train,
                               select = selected1.ER.rm)


x.Boruta.train.ER.ps.rm <- subset(x.onlyER.rm.train.phonescreen,
                                  select = selected1.ER.phonescreen.rm)


x.Boruta.train.ER.rm.noCombo <- subset(x.onlyER.rm.noCombo.train,
                                       select = selected1.ER.rm.noCombo)


x.Boruta.train.ER.ps.rm.noCombo <- subset(x.onlyER.rm.noCombo.train.phonescreen,
                                          select = selected1.ER.phonescreen.rm.noCombo)


x.Boruta.train.phonescreen <- subset(x.train.phonescreen,
                                     select = selected1.phonescreen)


x.Boruta.train.phonescreen.rm <- subset(x.rm.train.phonescreen,
                                        select = selected1.rm.phonescreen)



x.Boruta.train.phonescreen.rm.noCombo <- subset(x.rm.noCombo.train.phonescreen,
                                                select = selected1.rm.noCombo.phonescreen)



x.Boruta.train.6m.ER <- subset(x.train.6m.ER,
                               select = selected1.6m.ER)



x.Boruta.train.6m.ER.rm <- subset(x.rm.train.6m.ER,
                                  select = selected1.6m.ER.rm)


x.Boruta.train.6m.ER.rm.noCombo <- subset(x.rm.noCombo.train.6m.ER,
                                          select = selected1.6m.ER.rm.noCombo)



x.Boruta.train.6m.ER.ps <- subset(x.train.6m.ER.ps,
                                  select = selected1.6m.ER.ps)



x.Boruta.train.6m.ER.ps.rm <- subset(x.rm.train.6m.ER.ps,
                                     select = selected1.6m.ER.ps.rm)

x.Boruta.train.6m.ER.ps.rm.noCombo <- subset(x.rm.noCombo.train.6m.ER.ps,
                                             select = selected1.6m.ER.ps.rm.noCombo)



x.Boruta.train.6m.ps <- subset(x.train.6m.ps,
                               select = selected1.6m.ps)


x.Boruta.train.6m.ps.rm <- subset(x.rm.train.6m.ps,
                                  select = selected1.6m.ps.rm)


x.Boruta.train.6m.ps.rm.noCombo <- subset(x.rm.noCombo.train.6m.ps,
                                          select = selected1.6m.ps.rm.noCombo)



x.Boruta.train.12m.ER <- subset(x.train.12m.ER,
                                select = selected1.12m.ER)

x.Boruta.train.12m.ER.rm <- subset(x.rm.train.12m.ER,
                                   select = selected1.12m.ER.rm)


x.Boruta.train.12m.ER.rm.noCombo <- subset(x.rm.noCombo.train.12m.ER,
                                           select = selected1.12m.ER.rm.noCombo)



x.Boruta.train.12m.ER.ps <- subset(x.train.12m.ER.ps,
                                   select = selected1.12m.ER.ps)


x.Boruta.train.12m.ER.ps.rm <- subset(x.rm.train.12m.ER.ps,
                                      select = selected1.12m.ER.ps.rm)


x.Boruta.train.12m.ER.ps.rm.noCombo <- subset(x.rm.noCombo.train.12m.ER.ps,
                                              select = selected1.12m.ER.ps.rm.noCombo)


x.Boruta.train.12m.ps <- subset(x.train.12m.ps,
                                select = selected1.12m.ps)


x.Boruta.train.12m.ps.rm <- subset(x.rm.train.12m.ps,
                                   select = selected1.12m.ps.rm)


x.Boruta.train.12m.ps.rm.noCombo <- subset(x.rm.noCombo.train.12m.ps,
                                           select = selected1.12m.ps.rm.noCombo)




x.Boruta.test.ER <- subset(x.onlyER.test,
                           select = selected1.ER)

x.Boruta.test.ER.ps <- subset(x.onlyER.test.phonescreen,
                              select = selected1.ER.phonescreen)

x.Boruta.test.ER.rm <- subset(x.onlyER.rm.test,
                              select = selected1.ER.rm)


x.Boruta.test.ER.ps.rm <- subset(x.onlyER.rm.test.phonescreen,
                                 select = selected1.ER.phonescreen.rm)


x.Boruta.test.ER.rm.noCombo <- subset(x.onlyER.rm.noCombo.test,
                                      select = selected1.ER.rm.noCombo)


x.Boruta.test.ER.ps.rm.noCombo <- subset(x.onlyER.rm.noCombo.test.phonescreen,
                                         select = selected1.ER.phonescreen.rm.noCombo)


x.Boruta.test.phonescreen <- subset(x.test.phonescreen,
                                    select = selected1.phonescreen)


x.Boruta.test.phonescreen.rm <- subset(x.rm.test.phonescreen,
                                       select = selected1.rm.phonescreen)



x.Boruta.test.phonescreen.rm.noCombo <- subset(x.rm.noCombo.test.phonescreen,
                                               select = selected1.rm.noCombo.phonescreen)



x.Boruta.test.6m.ER <- subset(x.test.6m.ER,
                              select = selected1.6m.ER)



x.Boruta.test.6m.ER.rm <- subset(x.rm.test.6m.ER,
                                 select = selected1.6m.ER.rm)


x.Boruta.test.6m.ER.rm.noCombo <- subset(x.rm.noCombo.test.6m.ER,
                                         select = selected1.6m.ER.rm.noCombo)



x.Boruta.test.6m.ER.ps <- subset(x.test.6m.ER.ps,
                                 select = selected1.6m.ER.ps)



x.Boruta.test.6m.ER.ps.rm <- subset(x.rm.test.6m.ER.ps,
                                    select = selected1.6m.ER.ps.rm)

x.Boruta.test.6m.ER.ps.rm.noCombo <- subset(x.rm.noCombo.test.6m.ER.ps,
                                            select = selected1.6m.ER.ps.rm.noCombo)



x.Boruta.test.6m.ps <- subset(x.test.6m.ps,
                              select = selected1.6m.ps)


x.Boruta.test.6m.ps.rm <- subset(x.rm.test.6m.ps,
                                 select = selected1.6m.ps.rm)


x.Boruta.test.6m.ps.rm.noCombo <- subset(x.rm.noCombo.test.6m.ps,
                                         select = selected1.6m.ps.rm.noCombo)



x.Boruta.test.12m.ER <- subset(x.test.12m.ER,
                               select = selected1.12m.ER)

x.Boruta.test.12m.ER.rm <- subset(x.rm.test.12m.ER,
                                  select = selected1.12m.ER.rm)


x.Boruta.test.12m.ER.rm.noCombo <- subset(x.rm.noCombo.test.12m.ER,
                                          select = selected1.12m.ER.rm.noCombo)



x.Boruta.test.12m.ER.ps <- subset(x.test.12m.ER.ps,
                                  select = selected1.12m.ER.ps)


x.Boruta.test.12m.ER.ps.rm <- subset(x.rm.test.12m.ER.ps,
                                     select = selected1.12m.ER.ps.rm)


x.Boruta.test.12m.ER.ps.rm.noCombo <- subset(x.rm.noCombo.test.12m.ER.ps,
                                             select = selected1.12m.ER.ps.rm.noCombo)


x.Boruta.test.12m.ps <- subset(x.test.12m.ps,
                               select = selected1.12m.ps)


x.Boruta.test.12m.ps.rm <- subset(x.rm.test.12m.ps,
                                  select = selected1.12m.ps.rm)


x.Boruta.test.12m.ps.rm.noCombo <- subset(x.rm.noCombo.test.12m.ps,
                                          select = selected1.12m.ps.rm.noCombo)




save.image(file = "Bellevue.featureselection.RData", version = NULL, safe = TRUE)
sessionInfo()
