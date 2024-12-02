#############################################################################################
##  
##  Автор: Алексей Салов 
##  
##  Цель:
##  A) Объединить обучающий и тестовый наборы для создания одного набора данных.
##  B) Извлечь только измерения среднего значения и стандартного отклонения для каждого измерения.
##  C) Использовать описательные названия активности для именования активностей в наборе данных.
##  D) Правильно подписать набор данных с использованием описательных имен переменных.
##  E) Из набора данных на шаге D создать второй независимый упорядоченный набор данных с
##    средним значением каждой переменной для каждой активности и каждого субъекта.
##  
#############################################################################################

# Подключение библиотеки dplyr
library(dplyr)

# (1) Чтение и объединение данных

# Чтение списка признаков
features <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", sep="", stringsAsFactors=FALSE, header=FALSE)[, 2]

# Чтение и объединение данных X_train и X_test
X_train <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
X_test <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
X_combined <- rbind(X_train, X_test)
names(X_combined) <- features

# Чтение и объединение данных для субъектов
subj_train <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
subj_test <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
subj_combined <- rbind(subj_train, subj_test)
names(subj_combined) <- "subject"

# Чтение и объединение данных для активности
y_train <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
y_test <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
y_combined <- rbind(y_train, y_test)
names(y_combined) <- "act_id"

# (2) Замена идентификаторов активности на текст
activity_labels <- read.csv("C:/Users/a0100/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep="", stringsAsFactors=FALSE, header=FALSE)
names(activity_labels) <- c("id", "activity")
y_combined$activity <- activity_labels$activity[match(y_combined$act_id, activity_labels$id)]

# (3) Объединение всех данных
complete_data <- cbind(X_combined, subj_combined, y_combined)

# (4) Очистка имен столбцов
colnames(complete_data) <- tolower(names(complete_data))
colnames(complete_data) <- gsub("[^[:alnum:]_]", "_", colnames(complete_data))

# (5) Выбор только переменных с mean и std
mean_columns <- grep("mean\\(\\)", colnames(complete_data), value=TRUE)
std_columns <- grep("std\\(\\)", colnames(complete_data), value=TRUE)

# (6) Подготовка итоговых данных
mean_data <- complete_data %>% select(subject, activity, all_of(mean_columns))
std_data <- complete_data %>% select(subject, activity, all_of(std_columns))

# (7) Упорядочивание данных и расчёт среднего для каждой активности и субъекта
final_mean <- mean_data %>% group_by(subject, activity) %>%
  summarise(across(starts_with("t"), \(x) mean(x, na.rm = TRUE), .groups = "drop"))

final_std <- std_data %>% group_by(subject, activity) %>%
  summarise(across(starts_with("t"), \(x) mean(x, na.rm = TRUE), .groups = "drop"))

# (8) Объединение итоговых данных
final_data <- full_join(final_mean, final_std, by=c("subject", "activity"))

# (9) Запись в файл
write.table(final_data, file="tidy_data.txt", row.names=FALSE)
