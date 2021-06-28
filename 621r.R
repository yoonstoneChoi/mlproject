## 주석 달아야함 

var <- c(1,2,3,4,5)
char <- c(1,5,7,9)
var

va1 <- c(1:5)
va1

### ## ## ##
#          #
#          #
### ## ## ##

ran <- seq(1:5)
ran
ran1 <- seq(1,5)
ran1
ran2 <- seq(1,10, by=3) ## by -> 간격격

      

ran2 + 2
ran2 * 2
ran2 * ran2

ran2 / ran2

ran2**2

ran2 + ran2


ran <- c(1,2,3,4,5,6,7,7)


str <- 'hahahahahah'

str1 <- c('a','b','c')
min(ran1)

paste(str1, collapse = ',') ## ,으로 하나의 문자열로 조인
paste(str1, collapse = ' ') ## 띄어쓰기로 조인성


## 패키지 설치 후 load한다
## ggplot2 패키지 사용 

 install.packages('ggplot2')

library(ggplot2)

x <- c('a','b','c','d','a','b','c','d','a','b','c','d')
qplot(x) 


# Q.1 다섯명의 학생이 시험을 봤음. 시험 점수를 담을 변수를 선언
# 80, 60, 70, 50, 90
# 전체 평균을 구하시오
s_score = c(80,60,70,50,90)
s_mean = mean(s_score) 
print(s_mean) 
 

english <- c(90,80,60,70)
math <- c(50,60,100,20)

df_score <- data.frame(english,math)
df_socre

install.packages("readxl") 

library(readxl)


df_exam = read_excel('C:\\Users\\admin\\R_course\\data\\excel_exam.xlsx') 
df_exam

## 엑셀 파일 첫 번째 행이 컬럼으로 스뷰라라라

library(readxl)
df_exam_novar = read_exel('C:\\Users\\admin\\R_course\\data\\excel_exam_novar.xlsx', col_names =FALSE)

# CSV 읽어오기

df_Csv_exam <- read.csv("C:\\Users\\admin\\R_course\\data\\csv_exam.csv")
df_Csv_exam


## 문자 들어있는 파일 불러오기
df_csv_exam1 <- read.csv("C:\\Users\\admin\\R_course\\data\\csv_exam.csv", stringsAsFactors=F)




## 파일 저장
write.csv(df_csv_exam1, file = "C:\\Users\\admin\\R_course\\data\\csv_exam2.csv")



## RData 파일 활용
save(df_Csv_exam, file = "./data/df_dsa.rda")




