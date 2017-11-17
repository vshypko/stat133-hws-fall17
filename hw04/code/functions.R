remove_missing <- function(v) {
  return(v[!is.na(v)])
}

get_minimum <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  v <- sort(x)
  return(v[1])
}

get_maximum <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  v <- sort(x, decreasing = TRUE)
  return(v[1])
}

get_range <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(get_maximum(v) - get_minimum(v))
}

get_median <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
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

get_average <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  sum = 0
  for(i in 1:length(v)) {
    sum = sum + 1
  }
  return(sum / length(v))
}

get_stdev <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  current_avg = 0
  sum = 0
  avg_sum = 0
  for (i in 1:length(v)) {
    avg_sum = avg_sum + i
    current_avg = get_average(v[1:i])
    sum = sum + (i - current_avg)^2
  }
  return(sqrt((1 / (n - 1)) * sum))
}

get_quartile1 <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v)[[2]])
  #???
}

get_quartile3 <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v)[[4]])
  #???
}

count_missing <- function(v) {
  if(!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  return(sum(v[is.na(v)]))
}

summary_stats <- function(v) {
  if(!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  minimum = get_minimum(v)
  percent10 = get_percentile10(v)
  quartile1 = get_quartile1(v)
  median = get_median(v)
  mean = get_average(v)
  quartile3 = get_quartile3(v)
  percent90 = get_percentile90(v)
  maximum = get_maximum(v)
  range = get_range(v)
  stdev = get_stdev(v)
  missing = count_missing(v)
  
  return(as.list(c(minimum, percent10, quartile1, median, mean, quartile3,
                   percent90, maximum, range, stdev, missing)))
}

print_stats <- function(v) {
  print(summary_stats(v))
  #???
}

rescale100 <- function(x, xmin, xmax) {
  if(!is.numeric(x)) {
    stop("Non-numeric argument provided")
  }
  return(100 * (x - xmin) / (xmax - xmin))
}

drop_lowest <- function(n) {
  if(!is.numeric(n)) {
    stop("Non-numeric argument provided")
  }
  sorted_n <- sort(n)
  lowest = sorted_n[1]
  counter = 0
  for (i in 1:length(n)) {
    if (n[i] == lowest) {
      return(n[-i])
    }
  }
}

score_homework <- function(v, drop = FALSE) {
  if(!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (drop == TRUE) {
    v <- drop_lowest(v)
  }
  return(get_average(v))
}

score_quiz <- function(v, drop = FALSE) {
  if(!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (drop == TRUE) {
    v <- drop_lowest(v)
  }
  return(get_average(v))
}

score_lab <- function(v) {
  if(!is.numeric(v) | v < 0 | v > 12) {
    stop("Non-numeric argument provided")
  }
  switch(
    v,
    11 | 12 = return(100),
    10 = return(80),
    9 = return(60),
    8 = return(40),
    7 = return(20),
    6 = return(0),
    score = return(0)
  )
}

get_percentile10 <- function(v, na.rm = FALSE) {
  if(!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v, .10)[[1]])
}

get_percentile90 <- function(v, na.rm = FALSE) {
  if (!is.numeric(v)) {
    stop("Non-numeric argument provided")
  }
  if (na.rm == TRUE) {
    v <- remove_missing(v)
  }
  return(quantile(v, .90)[[1]])
}
