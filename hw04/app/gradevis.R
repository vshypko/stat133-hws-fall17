# ===================================================================
# Title: HW 04: Grades Visualizer
# Description: Preparing data for use in Shiny App
# Input(s): cleanscores.csv
# Output(s): none
# Author: Vitali Shypko
# Date: 11-22-2017
# ===================================================================

cleanscores <- read_csv("../data/cleandata/cleanscores.csv")

grades_vector <- cleanscores[["Grade"]]
grade <- c("A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D", "F")
freq <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
for (i in 1:length(grades_vector)) {
  if (grades_vector[i] == "A+") {
    freq[1] = freq[1] + 1
  } else if (grades_vector[i] == "A") {
    freq[2] = freq[2] + 1
  } else if (grades_vector[i] == "A-") {
    freq[3] = freq[3] + 1
  } else if (grades_vector[i] == "B+") {
    freq[4] = freq[4] + 1
  } else if (grades_vector[i] == "B") {
    freq[5] = freq[5] + 1
  } else if (grades_vector[i] == "B-") {
    freq[6] = freq[6] + 1
  } else if (grades_vector[i] == "C+") {
    freq[7] = freq[7] + 1
  } else if (grades_vector[i] == "C") {
    freq[8] = freq[8] + 1
  } else if (grades_vector[i] == "C-") {
    freq[9] = freq[9] + 1
  } else if (grades_vector[i] == "D") {
    freq[10] = freq[10] + 1
  } else if (grades_vector[i] == "F") {
    freq[11] = freq[11] + 1
  }
}
freq <- as.integer(freq)
prop <- round(freq / length(grades_vector), 2)
grades_distribution <- data.frame(grade, freq, prop)
names(grades_distribution) <- c("Grade", "Freq", "Prop")
x_variables <- colnames(cleanscores)
