# ===================================================================
# Title: HW 03: Ranking NBA Teams
# Description: Trying to answer a hypothetical question: hypothetical question: 
# If I had to come up with a ranking system for the teams, how would I rank them?
# Input(s): nba2017-roster.csv, nba2017-stats.csv
# Output(s): nba2017-teams.csv
# Author: Vitali Shypko
# Date: 10-14-2017
# ===================================================================

# Packages
library(readr)
library(dplyr)
library(ggplot2)

# Export data tables
dat_roster <- read_csv('../data/nba2017-roster.csv')
dat_stats <- read_csv('../data/nba2017-stats.csv')

# Mutate dat_stats data frame
dat_stats <- mutate(dat_stats, missed_fg = field_goals_atts - field_goals_made)
dat_stats <- mutate(dat_stats, missed_ft = points1_atts - points1_made)
dat_stats <- mutate(dat_stats, points = points1_made + 2 * points2_made + 3 * points3_made)
dat_stats <- mutate(dat_stats, rebounds = def_rebounds + off_rebounds)
dat_stats <- mutate(dat_stats, efficiency = (points + rebounds + assists + steals + blocks 
                                - missed_fg - missed_ft - turnovers) / games_played)

# Export efficiency summary output to the specified file
sink(file = '../output/efficiency-summary.txt')
summary(dat_stats$efficiency)
sink()

# Merge data frames
dat_roster_stats <- merge(dat_roster, dat_stats)

# Create nba2017-teams.csv
team <- dat_roster_stats$team
experience <- dat_roster_stats$experience
salary <- as.numeric(formatC((dat_roster_stats$salary / 1000000), digits = 2, 
                             format = 'f')) # in millions with 2 decimal digits
points3 <- dat_roster_stats$points3_made
points2 <- dat_roster_stats$points2_made
free_throws <- dat_roster_stats$points1_made
points <- dat_roster_stats$points
off_rebounds <- dat_roster_stats$off_rebounds
def_rebounds <- dat_roster_stats$def_rebounds
assists <- dat_roster_stats$assists
steals <- dat_roster_stats$steals
blocks <- dat_roster_stats$blocks
turnovers <- dat_roster_stats$turnovers
fouls <- dat_roster_stats$fouls
efficiency <- as.numeric(formatC((dat_roster_stats$efficiency), digits = 2, 
                                 format = 'f')) # 2 decimal digits
df <- data.frame(team, experience, salary, points3, points2, free_throws,
                   points, off_rebounds, def_rebounds, assists, steals, blocks,
                   turnovers, fouls, efficiency, stringsAsFactors = FALSE)

teams <- summarise(
  group_by(df, team),
  experience = sum(experience),
  salary = sum(salary),
  points3 = sum(points3),
  points2 = sum(points2),
  free_throws = sum(free_throws),
  points = sum(points),
  off_rebounds = sum(off_rebounds),
  def_rebounds = sum(def_rebounds),
  assists = sum(assists),
  steals = sum(steals),
  blocks = sum(blocks),
  turnovers = sum(turnovers),
  fouls = sum(fouls),
  efficiency = sum(efficiency)
)

# Export teams summary output to the specified file
sink(file = '../data/teams-summary.txt')
summary(teams)
sink()

# Export teams table to nba2017-teams.csv
write_csv(teams, '../data/nba2017-teams.csv')

# Export stars plot of teams to teams_star_plot.pdf
pdf(file = '../images/teams_star_plot.pdf')
stars(teams[ ,-1], labels = teams$team)
dev.off()

# Export scatterplot of experience and salary to experience_salary.pdf
experience_salary = ggplot(teams, aes(x = experience, y = salary)) +
  geom_point() +
  geom_label(aes(label = team)) + 
  ggtitle('Scatterplot of Experience and Salary')
ggsave(filename = '../images/experience_salary.pdf', plot = experience_salary)