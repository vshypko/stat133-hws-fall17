HW 02 - Basics of Data Frames
================
Vitali Shypko
9/24/2017

### Import the data in R

``` r
# import data using read.csv() with specified column types
colClass_csv = c("character", # Player
                 "character", # Team
                 "factor",    # Position
                 "character", # Experience
                 "double",    # Salary
                 "integer",   # Rank
                 "integer",   # Age
                 "integer",   # GP
                 "integer",   # GS
                 "integer",   # MIN
                 "integer",   # FGM
                 "integer",   # FGA
                 "integer",   # Points3               
                 "integer",   # Points3_atts
                 "integer",   # Points2
                 "integer",   # Points2_atts
                 "integer",   # FTM
                 "integer",   # FTA
                 "integer",   # OREB
                 "integer",   # DREB
                 "integer",   # AST
                 "integer",   # STL
                 "integer",   # BLK
                 "integer")   # TO

players_stat_base <- read.csv('data/nba2017-player-statistics.csv', stringsAsFactors = FALSE, 
                              colClasses = colClass_csv)
str(players_stat_base)
```

    ## 'data.frame':    441 obs. of  24 variables:
    ##  $ Player      : chr  "Al Horford" "Amir Johnson" "Avery Bradley" "Demetrius Jackson" ...
    ##  $ Team        : chr  "BOS" "BOS" "BOS" "BOS" ...
    ##  $ Position    : Factor w/ 5 levels "C","PF","PG",..: 1 2 5 3 4 3 4 5 4 2 ...
    ##  $ Experience  : chr  "9" "11" "6" "R" ...
    ##  $ Salary      : num  26540100 12000000 8269663 1450000 1410598 ...
    ##  $ Rank        : int  4 6 5 15 11 1 3 13 8 10 ...
    ##  $ Age         : int  30 29 26 22 31 27 26 21 20 29 ...
    ##  $ GP          : int  68 80 55 5 47 76 72 29 78 78 ...
    ##  $ GS          : int  68 77 55 0 0 76 72 0 20 6 ...
    ##  $ MIN         : int  2193 1608 1835 17 538 2569 2335 220 1341 1232 ...
    ##  $ FGM         : int  379 213 359 3 95 682 333 25 192 114 ...
    ##  $ FGA         : int  801 370 775 4 232 1473 720 58 423 262 ...
    ##  $ Points3     : int  86 27 108 1 39 245 157 12 46 45 ...
    ##  $ Points3_atts: int  242 66 277 1 111 646 394 35 135 130 ...
    ##  $ Points2     : int  293 186 251 2 56 437 176 13 146 69 ...
    ##  $ Points2_atts: int  559 304 498 3 121 827 326 23 288 132 ...
    ##  $ FTM         : int  108 67 68 3 33 590 176 6 85 26 ...
    ##  $ FTA         : int  135 100 93 6 41 649 217 9 124 37 ...
    ##  $ OREB        : int  95 117 65 2 17 43 48 6 45 60 ...
    ##  $ DREB        : int  369 248 269 2 68 162 367 20 175 213 ...
    ##  $ AST         : int  337 140 121 3 33 449 155 4 64 71 ...
    ##  $ STL         : int  52 52 68 0 9 70 72 10 35 26 ...
    ##  $ BLK         : int  87 62 11 0 7 13 23 2 18 17 ...
    ##  $ TO          : int  116 77 88 0 25 210 79 4 68 39 ...

``` r
# import data using readr's read_csv() with specified column types
library("readr")
players_stat_readr <- read_csv('data/nba2017-player-statistics.csv', 
                               col_types = cols(
                                 col_character(), # Player
                                 col_character(), # Team
                                 col_factor(c("C", "PF", "PG", "SF", "SG")),    # Position
                                 col_character(), # Experience
                                 col_double(),    # Salary
                                 col_integer(),   # Rank
                                 col_integer(),   # Age
                                 col_integer(),   # GP
                                 col_integer(),   # GS
                                 col_integer(),   # MIN
                                 col_integer(),   # FGM
                                 col_integer(),   # FGA
                                 col_integer(),   # Points3               
                                 col_integer(),   # Points3_atts
                                 col_integer(),   # Points2
                                 col_integer(),   # Points2_atts
                                 col_integer(),   # FTM
                                 col_integer(),   # FTA
                                 col_integer(),   # OREB
                                 col_integer(),   # DREB
                                 col_integer(),   # AST
                                 col_integer(),   # STL
                                 col_integer(),   # BLK
                                 col_integer()))
str(players_stat_readr)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    441 obs. of  24 variables:
    ##  $ Player      : chr  "Al Horford" "Amir Johnson" "Avery Bradley" "Demetrius Jackson" ...
    ##  $ Team        : chr  "BOS" "BOS" "BOS" "BOS" ...
    ##  $ Position    : Factor w/ 5 levels "C","PF","PG",..: 1 2 5 3 4 3 4 5 4 2 ...
    ##  $ Experience  : chr  "9" "11" "6" "R" ...
    ##  $ Salary      : num  26540100 12000000 8269663 1450000 1410598 ...
    ##  $ Rank        : int  4 6 5 15 11 1 3 13 8 10 ...
    ##  $ Age         : int  30 29 26 22 31 27 26 21 20 29 ...
    ##  $ GP          : int  68 80 55 5 47 76 72 29 78 78 ...
    ##  $ GS          : int  68 77 55 0 0 76 72 0 20 6 ...
    ##  $ MIN         : int  2193 1608 1835 17 538 2569 2335 220 1341 1232 ...
    ##  $ FGM         : int  379 213 359 3 95 682 333 25 192 114 ...
    ##  $ FGA         : int  801 370 775 4 232 1473 720 58 423 262 ...
    ##  $ Points3     : int  86 27 108 1 39 245 157 12 46 45 ...
    ##  $ Points3_atts: int  242 66 277 1 111 646 394 35 135 130 ...
    ##  $ Points2     : int  293 186 251 2 56 437 176 13 146 69 ...
    ##  $ Points2_atts: int  559 304 498 3 121 827 326 23 288 132 ...
    ##  $ FTM         : int  108 67 68 3 33 590 176 6 85 26 ...
    ##  $ FTA         : int  135 100 93 6 41 649 217 9 124 37 ...
    ##  $ OREB        : int  95 117 65 2 17 43 48 6 45 60 ...
    ##  $ DREB        : int  369 248 269 2 68 162 367 20 175 213 ...
    ##  $ AST         : int  337 140 121 3 33 449 155 4 64 71 ...
    ##  $ STL         : int  52 52 68 0 9 70 72 10 35 26 ...
    ##  $ BLK         : int  87 62 11 0 7 13 23 2 18 17 ...
    ##  $ TO          : int  116 77 88 0 25 210 79 4 68 39 ...
    ##  - attr(*, "spec")=List of 2
    ##   ..$ cols   :List of 24
    ##   .. ..$ Player      : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ Team        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ Position    :List of 3
    ##   .. .. ..$ levels    : chr  "C" "PF" "PG" "SF" ...
    ##   .. .. ..$ ordered   : logi FALSE
    ##   .. .. ..$ include_na: logi FALSE
    ##   .. .. ..- attr(*, "class")= chr  "collector_factor" "collector"
    ##   .. ..$ Experience  : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
    ##   .. ..$ Salary      : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_double" "collector"
    ##   .. ..$ Rank        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Age         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ GP          : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ GS          : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ MIN         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FGM         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FGA         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points3     : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points3_atts: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points2     : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ Points2_atts: list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FTM         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ FTA         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ OREB        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ DREB        : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ AST         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ STL         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ BLK         : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   .. ..$ TO          : list()
    ##   .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
    ##   ..$ default: list()
    ##   .. ..- attr(*, "class")= chr  "collector_guess" "collector"
    ##   ..- attr(*, "class")= chr "col_spec"

------------------------------------------------------------------------

### Right after importing the data

``` r
# replace all the occurences of "R" in Experience column and convert the column to integers.
# column conversion happens implicitly
players_stat_base$Experience <- as.integer(replace(players_stat_base$Experience,
                                                   players_stat_base$Experience=="R", 1))
players_stat_readr$Experience <- as.integer(replace(players_stat_readr$Experience,
                                                    players_stat_readr$Experience=="R", 1))
```

------------------------------------------------------------------------

### Performance of players

``` r
# computing EFF
# EFF = (PTS + REB + AST + STL + BLK - Missed FG - Missed FT - TO) / GP
# summary(EFF)
# hist(EFF, main = "Histogram of Efficiency (EFF)", xlab = "EFF", ylab = "Frequency")
```

``` r
# Display the player name, team, salary, and EFF value of the top-10 players by EFF in decreasing order (display this information in a data frame).
```

``` r
# Provide the names of the players that have a negative EFF.
```

``` r
# Use the function cor() to compute the correlation coefficients between EFF and all the variables used in the EFF formula.
#EFF_PTS = cor(EFF, PTS)
#EFF_REB = cor(EFF, REB)
#EFF_STL = cor(EFF, STL)
#EFF_AST = cor(EFF, AST)
#EFF_BLK = cor(EFF, BLK)
#EFF_Missed_FT = cor(EFF, - Missed_FT)
#EFF_Missed_FG cor(EFF, - Missed_FG)
#EFF_TO = cor(EFF, TO)
# Notice that Missed_FG, Missed_FT, and TO contribute negatively to EFF, so make sure to take into account this negative association when calculating the correlation coefficients.
```

``` r
# Display the computed correlations in descending order, either in a vector or a data frame. And create a barchart with the correlations (bars in decreasing order) like the one below.
#EFF_cor <- sort(c(EFF_PTS, EFF_REB, EFF_STL, EFF_AST, EFF_BLK, EFF_Missed_FT, EFF_Missed_FG, EFF_TO), decreasing = TRUE)
#EFF_cor
#boxplot(EFF_cor, main = "Correlations between Player Stats and EFF")
```

------------------------------------------------------------------------

### Efficiency and Salary

``` r
#plot(players_stat_base$Efficiency, players_stat_base$Salary, pch=16, col = "darkgray", cex = 0.95, cex.lab = 1.1, cex.main = 1.5, xlab = "Efficiency", ylab = "Salary", main = "Efficiency and Salary")
#lines(lowess(players_stat_base$Efficiency, players_stat_base$Salary), lwd = "4", col = "red")
#cor(players_stat_base$Efficiency, players_stat_base$Salary)
```

``` r
#players2 <- players_stat_base[players_stat_base$MPG >= 20]
#plot(players2$Efficiency, players2$Salary, pch=16, col = "darkgray", cex = 0.95, cex.lab = 1.1, cex.main = 1.5, xlab = "Efficiency", ylab = "Salary", main = "Efficiency and Salary (for players with MPG >= 20)")
#lines(lowess(players2$Efficiency, players2$Salary), lwd = "4", col = "red")
#cor(players2$Efficiency, players2$Salary)
```

------------------------------------------------------------------------

### Comments and Reflections

-   What things were hard, even though you saw them in class/lab?

> I don't recall anything hard that I had to do in this lab that was already covered in class.

-   What was easy(-ish) even though we haven’t done it in class/lab?

> Installing and using readr package was pretty straightforward.

-   Did you need help to complete the assignment? If so, what kind of help?

> I didn't understand how to add additional variables to my data frame in part 4. I asked about it on Piazza and received help.

-   How much time did it take to complete this HW?

> I spent about 5-6 hours to complete this homework.

-   What was the most time consuming part?

> In Part 4 I didn't get how to add additional variables to my data frame. I had to wait for an answer on Piazza, so that part took the longest time to complete.

-   Was there anything that you did not understand? or fully grasped?

> No, I think I understood every part of the lab.

-   Was there anything frustrating in particular?

> One frustrating thing was figuring out the necessary format that col\_types expects in read\_csv. I tried to reuse the column types list I created for base data.csv method, but it didn't work.

-   Was there anything exciting? Something that you feel proud of? (Don’t be shy, we won’t tell anyone).

> The exciting thing for me in this lab was that I started to realize how flexible data analysis may be. There are so many parameters that influence each other. It feels great to be able to analyze the data and see the dependencies.
