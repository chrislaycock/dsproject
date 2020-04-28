library(ggplot2)

x_train <- read.csv("x_train_Lafd4AH.csv")
x_test <- read.csv("x_test_c7ETL4q.csv")

attach(x_train)

vols <- VOLUME_1 + VOLUME_2 + VOLUME_3 + VOLUME_4 + VOLUME_5 + VOLUME_6 + VOLUME_7 + VOLUME_8 + VOLUME_9 + VOLUME_10 + VOLUME_11 + VOLUME_12 + VOLUME_13 + VOLUME_14 + VOLUME_15 + VOLUME_16 + VOLUME_17 + VOLUME_18 + VOLUME_19 + VOLUME_20
difference <- RET_20 - RET_1
rets <- RET_1 + RET_2 + RET_3 + RET_4 + RET_5 + RET_6 + RET_7 + RET_8 + RET_9 + RET_10 + RET_11 + RET_12 + RET_13 + RET_14 + RET_15 + RET_16 + RET_17 + RET_18 + RET_19 + RET_20

## NOTE: For the code blocks below, it is advised to uncomment and run one plot code block at a time!!

# show the dates on which the stocks were sold (mostly randomized)
#plot(lm(STOCK ~ DATE))

# group stock volumes by industry
#linear <- lm(vols ~ INDUSTRY)
#prediction <- predict(linear, newdata = x_test)
#total <- cbind(x_train, prediction)
#ggplot(total, aes(INDUSTRY, vols)) + geom_point() + stat_smooth(method = lm)

# group stock returns by the volume sold
#linear <- lm(rets ~ vols)
#prediction <- predict(linear, newdata = x_test)
#total <- cbind(x_train, prediction)
#ggplot(total, aes(vols, rets)) + geom_point() + stat_smooth(method = lm)

# show which industries had the greatest change in stock volume sold
linear <- lm(difference ~ INDUSTRY)
prediction <- predict(linear, newdata = x_test)
total <- cbind(x_train, prediction)
ggplot(total, aes(INDUSTRY, difference)) + geom_point() + stat_smooth(method = lm)