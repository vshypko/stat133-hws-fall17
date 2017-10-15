HW 03 - Ranking NBA Teams
================
Vitali Shypko
10/14/2017

### Ranking teams

#### Import the data

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)
library(readr)
```

``` r
teams <- read.csv('../data/nba2017-teams.csv', stringsAsFactors = FALSE)
teams <- arrange(teams, desc(teams$salary))
```

#### Plots

``` r
# NBA Teams ranked by Total Salary
ggplot(teams, aes(x = reorder(team, salary), y = salary)) +
  geom_bar(stat = 'identity', fill = 'gray', colour = 'gray') +
  xlab('Team') +
  ylab('Salary (in millions)') +
  ggtitle('NBA Teams ranked by Total Salary') +
  geom_hline(aes(yintercept = mean(teams$salary)), colour = 'darksalmon', size = 2) +
  coord_flip()
```

![](hw03-vitali-shypko_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)

``` r
# NBA Teams ranked by Total Points
ggplot(teams, aes(x = reorder(team, points), y = points)) +
  geom_bar(stat = 'identity', fill = 'gray', colour = 'gray') +
  xlab('Team') +
  ylab('Total Points') +
  ggtitle('NBA Teams ranked by Total Points') +
  geom_hline(aes(yintercept = mean(teams$points)), colour = 'darksalmon', size = 2) +
  coord_flip()
```

![](hw03-vitali-shypko_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

``` r
# NBA Teams ranked by Total Efficiency
ggplot(teams, aes(x = reorder(team, efficiency), y = efficiency)) +
  geom_bar(stat = 'identity', fill = 'gray', colour = 'gray') +
  xlab('Team') +
  ylab('Total Efficiency') +
  ggtitle('NBA Teams ranked by Total Efficiency') +
  geom_hline(aes(yintercept = mean(teams$efficiency)), colour = 'darksalmon', size = 2) +
  coord_flip()
```

![](hw03-vitali-shypko_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

From these plots, we can see that there is a correlation between efficiency and total salary of a team. For example, CLE has the highest total salary and it's also the most efficient. For some other teams, however, the link between salary and efficiency is not so obvious. The correlation between total points and total efficiency if more evident. In fact, for most teams, their position in Total Points plot is +-4 their position in the Total Efficiency plot, which suggests that there is a strong link between points and efficiency.

### Principal Components Analysis (PCA)

``` r
points3 <- teams$points3
points2 <- teams$points2
free_throws <- teams$free_throws
off_rebounds <- teams$off_rebounds
def_rebounds <- teams$def_rebounds
assists <- teams$assists
steals <- teams$steals
blocks <- teams$blocks
turnovers <- teams$turnovers
fouls <- teams$fouls

team <- teams$team

pca_df <- data.frame(points3, points2, free_throws, off_rebounds, def_rebounds, assists,
                 steals, blocks, turnovers, fouls, stringsAsFactors = FALSE)
pca <- prcomp(pca_df, scale. = TRUE)

eigenvalue = round(pca$sdev^2, 4)
prop = round(pca$sdev^2 / sum(pca$sdev^2), 4)
cumprop = cumsum(prop)
eigenvalues <- data.frame(eigenvalue, prop, cumprop)
PC = data.frame(pca$x, eigenvalues, team, stringsAsFactors = FALSE)
PC1 = PC[ , 1]
PC1 = PC[ , 2]
head(PC, 5)
```

    ##          PC1        PC2        PC3        PC4         PC5        PC6
    ## 1  1.1429197 -1.9254795  1.5294444 -0.9201885  0.51632174  0.8038837
    ## 2 -1.6926408 -0.7550453  0.7169699 -0.1673084 -0.06326830 -0.9511131
    ## 3 -0.6469827  1.3120040  0.4496369 -0.0321004 -0.04584683 -1.5195812
    ## 4 -0.6071090  0.4667924  1.0158464  0.5798048 -0.09939715 -0.9225112
    ## 5 -2.2990719 -0.1427248 -1.2177938 -0.7466215  0.50765029 -0.1294754
    ##           PC7        PC8         PC9        PC10 eigenvalue   prop cumprop
    ## 1 -0.07660705  0.3561447 -0.29276673  0.29193783     4.6959 0.4696  0.4696
    ## 2 -0.02461385  0.6795998  0.41729081  0.06438414     1.7020 0.1702  0.6398
    ## 3 -0.51375147 -0.5910190  0.23466108  0.20892464     0.9795 0.0980  0.7378
    ## 4  0.74842650 -0.6081984  0.29012417 -0.57927711     0.7717 0.0772  0.8150
    ## 5 -0.43262618 -0.2741142  0.03513969  0.05141205     0.5341 0.0534  0.8684
    ##   team
    ## 1  CLE
    ## 2  LAC
    ## 3  TOR
    ## 4  MEM
    ## 5  SAS

``` r
# PCA plot (PC1 and PC2)
ggplot(PC, aes(x = -PC1, y = -PC2)) +
  xlab('PC1') +
  ylab('PC2') +
  ggtitle('PCA plot (PC1 and PC2)') +
  geom_text(aes(label = team)) +
  geom_hline(yintercept = 0, colour = 'gray') +
  geom_vline(xintercept = 0, colour = 'gray') +
  scale_y_reverse()
```

![](hw03-vitali-shypko_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

#### Index based on PC1

``` r
# Transformed score
s1 = 100 * ((PC1 - min(PC1)) / (max(PC1) - min(PC1)))
PC$s1 = s1
```

``` r
# NBA Teams ranked by Total Salary
ggplot(PC, aes(x = reorder(team, s1), y = s1)) +
  geom_bar(stat = 'identity', fill = 'gray', colour = 'gray') +
  xlab('Team') +
  ylab('First PC (scaled from 0 to 100)') +
  ggtitle('NBA Teams ranked by scaled PC1') +
  coord_flip()
```

![](hw03-vitali-shypko_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

### Comments and Reflections

Reflect on what was hard/easy, problems you solved, helpful tutorials you read, etc.

-   Was this your first time working on a project with such file structure? If yes, how do you feel about it?

> It was my first project with such file structure. However, in software engineering projects I worked on there was a similar project structure, so I am not entirely new to it. I like when things are organized.

-   Was this your first time using relative paths? If yes, can you tell why they are important for reproducibility purposes?

> This was not my first time using relative paths. They are great because using them allows the project to work on multiple systems without the need to change paths.

-   Was this your first time using an R script? If yes, what do you think about just writing code?

> This was not my first time using R script. We used it in Lab 6.

-   What things were hard, even though you saw them in class/lab?

> Finding PC values and their meaning was challenging to me.

-   What was easy(-ish) even though we haven’t done it in class/lab?

> Drawing horizontal lines on ggplot was pretty straightforward.

-   Did anyone help you completing the assignment? If so, who?

> No one helped me, I completed the assignment by myself.

-   How much time did it take to complete this HW?

> It took me about 6 hours to complete this HW.

-   What was the most time consuming part?

> Making graphs exactly the way they looks like in the instructions was time consuming as well as PCA part. I couldn't get draw the last graph with transformed score s1 for quite a while.

-   Was there anything interesting?

> Everything was interesting. This homework was definitely the most challenging so far, but it also showed that we already can manipulate data and get the information we need from it.
