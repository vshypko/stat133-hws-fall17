### HW 04 - Grades Visualizer
### Data dictionary for clean scores

* The data contains the clean scores for a fictitious STAT 133 course.
* There are 334 rows in the .csv file.
* There are 23 columns in the .csv file.
* The column labels are: "HW1", "HW2", "HW3", "HW4", "HW5", "HW6", "HW7", "HW8", "HW9", "ATT", "QZ1", "QZ2", "QZ3", "QZ4", "EX1", "EX2", "Test1", "Test2", "Homework", "Quiz", "Lab", "Overall", "Grade".
* Description of variables:
    - HW1 - HW9: homework assignments. Each 100 pts max
    - ATT: lab attendance. Number of attended labs (0 to 12)
    - QZ1 - QZ4: quiz scores. QZ1 - 12 pts max, QZ2 - 18 pts max, QZ3 - 20 pts max, QZ4 - 20 pts max
    - EX1, EX2: exam scores. EX1 - 80 pts max, EX2 - 90 pts max
    - Test1, Test2: rescaled versions of EX1, EX2
    - Homework: overall homework score with the lowest HW score dropped
    - Quiz: overall Quiz score with the lowest QZ score dropped
    - Lab: lab points rescaled based on ATT
    - Overall: total number of points, calculated by the formula: Overall = 0.1 * Lab + 0.3 * Homework + 0.15 * Quiz + 0.2 * Test1 + 0.25 * Test2
* There are no missing values in the data set.
