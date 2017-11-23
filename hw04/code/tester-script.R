# ===================================================================
# Title: HW 04: Grades Visualizer
# Description: Cleaning the raw data
# Input(s): functions.R
# Output(s): test-reporter.txt
# Author: Vitali Shypko
# Date: 11-22-2017
# ===================================================================

# Packages
library(testthat)

# Source in functions to be tested
source("functions.R")

sink("../output/test-reporter.txt")
test_file("tests.R")
sink()
