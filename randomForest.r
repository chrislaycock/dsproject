library(randomForest)

# Data was loaded in as x_train, y_train, x_test, and submission (the given .csv)

# Define neccessary factors for model
wantedFeatures = c("ID", "INDUSTRY", "RET_1", "RET_2", "RET_3", "RET_4", "RET_5", "RET_6", "RET_7" , "RET_8", "RET_9", "RET_10", "RET_11", "RET_12", "RET_13", "RET_14", "RET_15", "RET_16", "RET_17", "RET_18", "RET_19", "RET_20" , "VOLUME_1", "VOLUME_2", "VOLUME_3", "VOLUME_4", "VOLUME_5", "VOLUME_6", "VOLUME_7", "VOLUME_8", "VOLUME_9", "VOLUME_10", "VOLUME_11", "VOLUME_12", "VOLUME_13", "VOLUME_14", "VOLUME_15", "VOLUME_16", "VOLUME_17", "VOLUME_18", "VOLUME_19", "VOLUME_20", "RET")
# Attach Y as end column
x_train$RET = y_train$RET
# Grab neccesary factors for model
features = x_train[wantedFeatures]
# Ensure correct
head(features)

#Set NA to 0
features[is.na(features)] = 0
#Limit to first 50,000 rows to reduce crashing/out of memory errors
features = features[1:50000,]

#Create the model
model = randomForest(RET ~ ., data = features, importance = TRUE)


# Define neccessary factors for prediction
testFeatures = c("ID", "INDUSTRY", "RET_1", "RET_2", "RET_3", "RET_4", "RET_5", "RET_6", "RET_7" , "RET_8", "RET_9", "RET_10", "RET_11", "RET_12", "RET_13", "RET_14", "RET_15", "RET_16", "RET_17", "RET_18", "RET_19", "RET_20" , "VOLUME_1", "VOLUME_2", "VOLUME_3", "VOLUME_4", "VOLUME_5", "VOLUME_6", "VOLUME_7", "VOLUME_8", "VOLUME_9", "VOLUME_10", "VOLUME_11", "VOLUME_12", "VOLUME_13", "VOLUME_14", "VOLUME_15", "VOLUME_16", "VOLUME_17", "VOLUME_18", "VOLUME_19", "VOLUME_20")
test = x_test[testFeatures]

# Set NA's to 0
test[is.na(test)] = 0
# Ensure correct
head(test)

# Run model, save as pred
pred = predict(model, test, type = "class")

# Change to True/False
pred[pred < 0.5] = FALSE
pred[pred > 0.5] = TRUE

# Attach IDs to results
predSub = data.frame("ID" = test$ID, "RET" = c(pred))


# Change from 0,1 to True,False
submission$RET = as.integer(as.logical(submission$RET))

# Compare our results to submission example.
mean(predSub$RET == submission$RET)