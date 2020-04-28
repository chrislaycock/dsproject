Xtrain = x_train_Lafd4AH

Xtrain$TRUE1 = RET_1

value = ifelse(Xtrain$TRUE1 >= 0, "TRUE","FALSE")

Xtrain$TRUE1 = value

na.omit(Xtrain)

n.points = 418595

sampling.rate = 0.70

num.test.set.labels = n.points * (1 -sampling.rate)

training = sample(1:n.points, sampling.rate * n.points, replace = FALSE)

train = subset(Xtrain, select = c(Xtrain$STOCK, Xtrain$RET_1)) #this returns an error, but we decided at this point 
                                                                  #that it was not particularly worth it to pursue KNN
testing = setdiff(1:n.points, training)

test = subset(Xtrain, select = c(Xtrain$STOCK, Xtrain$RET_1))

cl = Xtrain$TRUE1

true.labels = Xtrain$TRUE[testing]




#ANOTHER APPROACH THAT WAS ATTEMPTED by https://towardsdatascience.com/k-nearest-neighbors-algorithm-with-examples-in-r-simply-explained-knn-1f2c88da405c
#I AM NOT SURE WHAT THIS DOES HOWEVER

ran = sample(1:nrow(Xtrain2), 0.9*nrow(Xtrain2))

nor = function(x) {(x -min(x))/(max(x)-min(x))}

Xtrain2_norm = as.data.frame(lapply(Xtrain2[,c(3,8)],nor))

summary(Xtrain2_norm)

Xtrain2_train = Xtrain2_norm[ran,]

Xtrain2_test = Xtrain2_norm[-ran,]

Xtrain2_target_category = Xtrain2[ran,51]

Xtrain2_test_category = Xtrain2[-ran,51]

library(class)

pr = knn(Xtrain2_train, Xtrain2_test,cl=Xtrain2_target_category,k=2)

tab = table(pr,Xtrain2_test_category)

accuracy = function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}

accuracy(tab)

accuracy(tab)
[1] 98.83182
