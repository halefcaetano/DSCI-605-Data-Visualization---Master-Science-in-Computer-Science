# Add your code here for this assignment. 
install.packages("tidyverse")
library(tidyverse)
library(readr)
Salaries <- read_csv("Module2/Salaries.csv")
View(Salaries)
new_salaries <- Salaries %>% select(rank, discipline, sex, salary) %>%
  filter(!is.na(salary)) 
group <- new_salaries %>% group_by(rank, discipline, sex) %>% 
  count() 
print(group)
wide <- group %>% spread(key = sex, value = n, fill = FALSE)   
final <- wide %>% gather(key = "sex", value = "n", -rank, na.rm = TRUE) %>% 
  separate(rank, into = "rank", sep = "_") 
print(final)