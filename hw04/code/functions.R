# ===================================================================
# Title: HW 04: Grades Visualizer
# Description: Functions to analyze data
# Input(s): none
# Output(s): none
# Author: Vitali Shypko
# Date: 11-22-2017
# ===================================================================

# Packages
library(stringr)

# remove_missing takes a numeric vector, removes missing values from it,
# and returns the resulting vector.
remove_missing <- function(v) {
  return(v[!is.na(v)])
}

# get_minimum takes a numeric vector and an optional na.rm argument. It returns
# the minimum value of the original input vector if na.rm is FALSE or of
# the vector with no missing values if na.rm is TRUE.
get_minimum <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  v <- sort(v)
  return(v[1])
}

# get_maximum takes a numeric vector and an optional na.rm argument. It returns
# the maximum value of the original input vector if na.rm is FALSE or of
# the vector with no missing values if na.rm is TRUE.
get_maximum <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  v <- sort(v, decreasing = TRUE)
  return(v[1])
}

# get_range takes a numeric vector and an optional na.rm argument. It returns
# the overall range (maximum - minimum) of the original input vector if na.rm
# is FALSE or of the vector with no missing values if na.rm is TRUE.
get_range <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(get_maximum(v) - get_minimum(v))
}

# get_median takes a numeric vector and an optional na.rm argument. It returns
# the median of the original input vector if na.rm is FALSE or of the vector
# with no missing values if na.rm is TRUE.
get_median <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  v <- sort(v)
  if (length(v) %% 2 == 1) {
    return(v[(length(v) / 2) + 1])
  } else {
    return((v[(length(v) / 2)] + v[(length(v) / 2) + 1]) / 2)
  }
}

# get_average takes a numeric vector and an optional na.rm argument. It returns
# the average of the original input vector if na.rm is FALSE or of the vector
# with no missing values if na.rm is TRUE.
get_average <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  sum = 0
  for(i in 1:length(v)) {
    sum = sum + v[i]
  }
  return(sum / length(v))
}

# get_stdev takes a numeric vector and an optional na.rm argument. It returns
# the standard deviation of the original input vector if na.rm is FALSE or of
# the vector with no missing values if na.rm is TRUE.
get_stdev <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  sum = 0
  for (i in 1:length(v)) {
    temp = (v[i] - get_average(v))^2
    sum = sum + temp
  }
  result = sqrt(1 / ((length(v) - 1)) * sum)
  return(result)
}

# get_quartile1 takes a numeric vector and an optional na.rm argument. It
# returns the first quartile of the original input vector if na.rm is FALSE or
# of the vector with no missing values if na.rm is TRUE.
get_quartile1 <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v)[[2]])
}

# get_quartile3 takes a numeric vector and an optional na.rm argument. It
# returns the third quartile of the original input vector if na.rm is FALSE or
# of the vector with no missing values if na.rm is TRUE.
get_quartile3 <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v)[[4]])
}

# count_missing takes a numeric vector and returns the number of missing values
# in it.
count_missing <- function(v) {
  check_if_numeric(v)
  missing = 0
  for (i in 1:length(v)) {
    if (is.na(v[i])) {
      missing = missing + 1
    }
  }
  return(missing)
}

# summary_stats takes a numeric vector and returns a list of summary statistics.
summary_stats <- function(v) {
  check_if_numeric(v)
  missing = count_missing(v)
  v <- remove_missing(v)
  summary <- as.list(c(get_minimum(v), get_percentile10(v), get_quartile1(v),
                       get_median(v), get_average(v), get_quartile3(v),
                       get_percentile90(v), get_maximum(v), get_range(v),
                       get_stdev(v), missing))
  names(summary) <- c("minimum", "percent10", "quartile1", "median", "mean",
                      "quartile3", "percent90", "maximum", "range", "stdev",
                      "missing")
  return(summary)
}

# print_stats takes a list of summary statistics and prints the values in a
# nice format.
print_stats <- function(v) {
  for (i in 1:length(v)) {
    cat(str_pad(names(v[i]), 9, "right"), ":", sprintf("%.4f", (v[[i]])), "\n")
  }
}

# rescale100 takes a numeric vector x, a minimum xmin, and a maximum xmax and
# returns a rescaled vector with a potential scale from 0 to 100.
rescale100 <- function(x, xmin, xmax) {
  check_if_numeric(x)
  return(100 * (x - xmin) / (xmax - xmin))
}

# drop_lowest takes a numeric vector of length n and returns a vector of
# length n - 1 by dropping the minimum value.
drop_lowest <- function(v) {
  check_if_numeric(v)
  lowest = get_minimum(v)
  for (i in 1:length(v)) {
    if (v[i] == lowest) {
      return(v[-i])
    }
  }
}

# score_homework takes a numeric vector and an optional argument drop. It
# returns the average score of the original input vector if drop is FALSE or
# the average score of the vector with dropped lowest score if drop is TRUE.
score_homework <- function(v, drop = FALSE) {
  check_if_numeric(v)
  if (drop == TRUE) {
    v <- drop_lowest(v)
  }
  return(get_average(v))
}

# score_quiz takes a numeric vector and an optional argument drop. It
# returns the average score of the original input vector if drop is FALSE or
# the average score of the vector with dropped lowest score if drop is TRUE.
score_quiz <- function(v, drop = FALSE) {
  check_if_numeric(v)
  if (drop == TRUE) {
    v <- drop_lowest(v)
  }
  return(get_average(v))
}

# score_lab takes a numeric value of lab attendance, and returns the lab score.
score_lab <- function(v) {
  check_if_numeric(v)
  check_argument_within_range(v, 0, 12)
  if (v == 7) {
    return(20)
  } else if (v == 8) {
    return(40)
  } else if (v == 9) {
    return(60)
  } else if (v == 10) {
    return(80)
  } else if (v == 11 || v == 12) {
    return(100)
  }
  return(0)
}

# get_percentile10 takes a numeric vector and an optional na.rm argument. It
# returns the 10 percentile of the original input vector if na.rm is FALSE or
# of the vector with no missing values if na.rm is TRUE.
get_percentile10 <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v, .10)[[1]])
}

# get_percentile90 takes a numeric vector and an optional na.rm argument. It
# returns the 90 percentile of the original input vector if na.rm is FALSE or
# of the vector with no missing values if na.rm is TRUE.
get_percentile90 <- function(v, na.rm = FALSE) {
  check_if_numeric(v)
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v, .90)[[1]])
}

# check_if_numeric takes an argument and checks whether the provided argument
# is numeric. If it is not -- it stops execution of the program.
check_if_numeric <- function(v) {
  if (!(is.vector(v) && is.numeric(v))) {
    stop("Non-numeric argument provided")
  }
}

# check_argument_within_range takes an argument, a minimum value and a maximum
# value and checks whether the provided argument is within the specified range.
# If it is not -- it stops execution of the program.
check_argument_within_range <- function(v, vmin, vmax) {
  if (v < vmin || v > vmax) {
    stop("Argument not within ", vmin, "-", vmax, " range provided")
  }
}
