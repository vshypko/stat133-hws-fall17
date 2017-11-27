# ===================================================================
# Title: HW 04: Grades Visualizer
# Description: Cleaning the raw data
# Input(s): rawscores.csv
# Output(s): cleanscores.csv
# Author: Vitali Shypko
# Date: 11-22-2017
# ===================================================================

# Packages
library(readr)

# Functions to clean data
source("functions.R")

# Export the data table
rawdata <- read_csv("../data/rawdata/rawscores.csv")

# Sink structure of the data file and summary of all columns
sink("../output/summary-rawscores.txt")
str(rawdata)
for (i in 1:length(rawdata)) {
  cat("\nSummary statistics for column", names(rawdata[i]) , "\n")
  print_stats(summary_stats(rawdata[[i]]))
}
sink()

# Replace all missing NA values with 0
for (i in 1:length(rawdata)) {
  rawdata[[i]][is.na(rawdata[[i]])] <- 0
}

# Rescale quiz scores
rawdata[["QZ1"]] <- rescale100(rawdata[["QZ1"]], 0, 12)
rawdata[["QZ2"]] <- rescale100(rawdata[["QZ2"]], 0, 18)
rawdata[["QZ3"]] <- rescale100(rawdata[["QZ3"]], 0, 20)
rawdata[["QZ4"]] <- rescale100(rawdata[["QZ4"]], 0, 20)

# Rescale exam scores
rawdata[["Test1"]] <- rescale100(rawdata[["EX1"]], 0, 80)
rawdata[["Test2"]] <- rescale100(rawdata[["EX2"]], 0, 90)

# Add Homework column
all_homeworks <- data.frame()
Homework <- c()
for (i in 1:nrow(rawdata)) {
  for (j in 1:9) {
    all_homeworks[i, j] <- rawdata[i, 1:9][[j]]
  }
  Homework[i] <- score_homework(as.numeric(all_homeworks[i, ]), drop = TRUE)
}
rawdata[["Homework"]] <- Homework

# Add Quiz column
all_quizes <- data.frame()
Quiz <- c()
for (i in 1:nrow(rawdata)) {
  for (j in 11:14) {
    all_quizes[i, j-10] <- rawdata[i, 11:14][[j-10]]
  }
  Quiz[i] <- score_quiz(as.numeric(all_quizes[i, ]), drop = TRUE)
}
rawdata[["Quiz"]] <- Quiz

# Add Overall column
attendance <- rawdata[["ATT"]]
lab_scores <- c()
for (i in 1:length(attendance)) {
  lab_scores[i] <- score_lab(attendance[i])
}
rawdata[["Lab"]] <- lab_scores

Overall <- c()
for (i in 1:nrow(rawdata)) {
  Overall[i] <- 0.1 * rawdata[["Lab"]][i] + 0.3 * rawdata[["Homework"]][i] + 
                0.15 * rawdata[["Quiz"]][i] + 0.2 * rawdata[["Test1"]][i] +
                0.25 * rawdata[["Test2"]][i]
}
rawdata[["Overall"]] <- Overall

# Add Grade column
Grade <- c()
for (i in 1:nrow(rawdata)) {
  overall = Overall[i]
  if (overall < 50) {
    Grade[i] = "F"
  } else if (overall >= 50 && overall < 60) {
    Grade[i] = "D"
  } else if (overall >= 60 && overall < 70) {
    Grade[i] = "C-"
  } else if (overall >= 70 && overall < 77.5) {
    Grade[i] = "C"
  } else if (overall >= 77.5 && overall < 79.5) {
    Grade[i] = "C+"
  } else if (overall >= 79.5 && overall < 82) {
    Grade[i] = "B-"
  } else if (overall >= 82 && overall < 86) {
    Grade[i] = "B"
  } else if (overall >= 86 && overall < 88) {
    Grade[i] = "B+"
  } else if (overall >= 88 && overall < 90) {
    Grade[i] = "A-"
  } else if (overall >= 90 && overall < 95) (
    Grade[i] = "A"
  ) else if (overall >= 95 && overall <= 100) {
    Grade[i] = "A+"
  }
}
rawdata[["Grade"]] <- Grade

# Summary for Lab, Homework, Quiz, Test1, Test2, and Overall
filenames <- c("Lab-stats", "Homework-stats", "Quiz-stats", "Test1-stats",
               "Test2-stats", "Overall-stats")

for (i in 1:length(filenames)) {
  sink(paste0("../output/", filenames[i], ".txt"))
  cat(paste0("Summary statistics for ", str_sub(filenames[i], 1, -7), "\n"))
  print_stats(summary_stats(rawdata[[str_sub(filenames[i], 1, -7)]]))
  sink()
}

# Structure of the data frame of clean scores
sink("../output/summary-cleanscores.txt")
str(rawdata)
sink()

# Export clean data to cleanscores.csv
write_csv(rawdata, "../data/cleandata/cleanscores.csv")
