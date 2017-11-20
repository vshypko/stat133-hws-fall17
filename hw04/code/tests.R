source("functions.R")
library(testthat)

context("Test remove_missing()")
test_that("remove_missing works correctly", {
  a1 <- c(1, 4, 7, NA, 10)
  a2 <- c(1, NA, NA, NA, 3)
  a3 <- c(1, 2, 3)
  a4 <- c(NA, NA, NA)
  b1 <- c(1, 4, 7, 10)
  b2 <- c(1, 3)
  b3 <- c(1, 2, 3)
  
  expect_equal(remove_missing(a1), b1)
  expect_equal(remove_missing(a2), b2)
  expect_equal(remove_missing(a3), b3)
  expect_that(length(remove_missing(a4)), equals(0))
})

context("Test get_minimum()")
test_that("get_minimum works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(100, -100)
  a3 <- c(0, 1, 0, 1, 4)
  
  expect_that(get_minimum(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_minimum(a1), 1)
  expect_equal(get_minimum(a2), -100)
  expect_equal(get_minimum(a3), 0)
})

context("Test get_maximum()")
test_that("get_maximum works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(100, -100)
  a3 <- c(0, 4, 0, 4, 4)
  
  expect_that(get_maximum(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_maximum(a1), 100)
  expect_equal(get_maximum(a2), 100)
  expect_equal(get_maximum(a3), 4)
})

context("Test get_range()")
test_that("get_range works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(100, -100)
  a3 <- c(0, 4, 0, 4, 4)
  
  expect_that(get_range(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_range(a1), 99)
  expect_equal(get_range(a2), 200)
  expect_equal(get_range(a3), 4)
})

context("Test get_median()")
test_that("get_median works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(100, -100)
  a3 <- c(0, 4, 0, 4, 4)
  
  expect_that(get_median(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_median(a1), 4.5)
  expect_equal(get_median(a2), 0)
  expect_equal(get_median(a3), 4)
})

context("Test get_average()")
test_that("get_average works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(100, -100)
  a3 <- c(0, 4, 0, 4, 4)
  
  expect_that(get_average(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_average(a1), 27.5)
  expect_equal(get_average(a2), 0)
  expect_equal(get_average(a3), 2.4)
})

context("Test get_stdev()")
test_that("get_stdev works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(100, -100)
  a3 <- c(0, 4, 0, 4, 4)
  
  expect_that(get_stdev(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_stdev(a1), 48.4, tolerance = 0.1)
  expect_equal(get_stdev(a2), 141.4, tolerance = 0.1)
  expect_equal(get_stdev(a3), 2.1, tolerance = 0.1)
})

context("Test get_quartile1()")
test_that("get_quartile1 works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(-100, 100, 200, 300)
  a3 <- c(0, 4, 0, 4, 4)
  
  expect_that(get_quartile1(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_quartile1(a1), 1.75)
  expect_equal(get_quartile1(a2), 50)
  expect_equal(get_quartile1(a3), 0)
})

context("Test get_quartile3()")
test_that("get_quartile3 works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(-100, 100, 200, 300)
  a3 <- c(0, 4, 0, 4, 4)
  
  expect_that(get_quartile3(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_quartile3(a1), 30.25)
  expect_equal(get_quartile3(a2), 225)
  expect_equal(get_quartile3(a3), 4)
})

context("Test count_missing()")
test_that("count_missing works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 7, 100)
  a2 <- c(-100, NA, 200, NA)
  a3 <- c(NA, 1, NA, NA, NA)
  
  expect_that(count_missing(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(count_missing(a1), 0)
  expect_equal(count_missing(a2), 2)
  expect_equal(count_missing(a3), 4)
})

context("Test summary_stats()")
test_that("summary_stats works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 4, 7, NA, 10)
  
  expect_that(summary_stats(str),
              throws_error("Non-numeric argument provided"))
  expect_that(length(summary_stats(a1)), equals(11))
  expect_equal(summary_stats(a1)[[1]], 1)
  expect_equal(summary_stats(a1)[[2]], 1.9)
  expect_equal(summary_stats(a1)[[3]], 3.25)
  expect_equal(summary_stats(a1)[[4]], 5.5)
  expect_equal(summary_stats(a1)[[5]], 5.5)
  expect_equal(summary_stats(a1)[[6]], 7.75)
  expect_equal(summary_stats(a1)[[7]], 9.1)
  expect_equal(summary_stats(a1)[[8]], 10)
  expect_equal(summary_stats(a1)[[9]], 9)
  expect_equal(summary_stats(a1)[[10]], 3.87, tolerance = 0.1)
  expect_equal(summary_stats(a1)[[11]], 1)
})

context("Test rescale100()")
test_that("rescale100 works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(18, 15, 16, 4, 17, 9)
  a2 <- c(10, 40, 50, 75)
  a3 <- c(98, 23, 11, 5, 100)
  
  expect_that(rescale100(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(rescale100(a1, xmin = 0, xmax = 20), c(90, 75, 80, 20, 85, 45))
  expect_equal(rescale100(a2, xmin = 10, xmax = 50), c(0, 75, 100, 162.5))
  expect_equal(rescale100(a3, xmin = 0, xmax = 100), c(98, 23, 11, 5, 100))
})

context("Test drop_lowest()")
test_that("drop_lowest works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(18, 15, 16, 4, 17, 9)
  a2 <- c(10, 40, 50, 75)
  a3 <- c(98, 23, 11, 5, 100)
  
  expect_that(drop_lowest(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(drop_lowest(a1), c(18, 15, 16, 17, 9))
  expect_equal(drop_lowest(a2), c(40, 50, 75))
  expect_equal(drop_lowest(a3), c(98, 23, 11, 100))
})

context("Test score_homework()")
test_that("score_homework works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(100, 80, 30, 70, 75, 85)
  a2 <- c(10, 40, 50, 75)
  
  expect_that(score_homework(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(score_homework(a1, drop = TRUE), 82)
  expect_equal(score_homework(a1, drop = FALSE), 73.3, tolerance = 0.1)
  expect_equal(score_homework(a2, TRUE), 55)
})

context("Test score_quiz()")
test_that("score_quiz works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(100, 80, 70, 0)
  a2 <- c(10, 40, 50, 75)
  
  expect_that(score_quiz(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(score_quiz(a1, drop = TRUE), 83.3, tolerance = 0.1)
  expect_equal(score_quiz(a1, drop = FALSE), 62.5)
  expect_equal(score_quiz(a2, TRUE), 55)
})

context("Test score_lab()")
test_that("score_lab works correctly", {
  str <- "a"
  num1 <- 13
  num2 <- -1
  
  expect_that(score_lab(str),
              throws_error("Non-numeric argument provided"))
  expect_that(score_lab(num1),
              throws_error("Argument not within 0-12 range provided"))
  expect_that(score_lab(num2),
              throws_error("Argument not within 0-12 range provided"))
  expect_equal(score_lab(0), 0)
  expect_equal(score_lab(1), 0)
  expect_equal(score_lab(2), 0)
  expect_equal(score_lab(3), 0)
  expect_equal(score_lab(4), 0)
  expect_equal(score_lab(5), 0)
  expect_equal(score_lab(6), 0)
  expect_equal(score_lab(7), 20)
  expect_equal(score_lab(8), 40)
  expect_equal(score_lab(9), 60)
  expect_equal(score_lab(10), 80)
  expect_equal(score_lab(11), 100)
  expect_equal(score_lab(12), 100)
})

context("Test get_percentile10()")
test_that("get_percentile10 works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 3, 4, 5)
  a2 <- c(200, 12, 52, 6)
  a3 <- c(1)
  
  expect_that(get_percentile10(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_percentile10(a1), 1.4)
  expect_equal(get_percentile10(a2), 7.8)
  expect_equal(get_percentile10(a3), 1)
})

context("Test get_percentile90()")
test_that("remove_missing works correctly", {
  str <- c("a", "2", "3")
  a1 <- c(1, 2, 3, 4, 5)
  a2 <- c(200, 12, 52, 6)
  a3 <- c(1)
  
  expect_that(get_percentile90(str),
              throws_error("Non-numeric argument provided"))
  expect_equal(get_percentile90(a1), 4.6)
  expect_equal(get_percentile90(a2), 155.6)
  expect_equal(get_percentile90(a3), 1)
})
