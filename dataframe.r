## 데이터 프레임
english <- c(90,80,60,70)
math <- c(50,60,100,20)
class <- c(1,1,2,2)

df_score <- data.frame(english,math,class)
df_score

mean(df_score$english) ## 해당 칼럼의 정보만 보고 싶을 때, $뒤에 쓴다.

df_score2 <-  data.frame(english = c(90,54)
                        ,math = c(20,10)
                        ,class = c(1,2))
df_score2

## Q1, dataframe과 c를 조합해서 프레임 만들기 
df_fruit <- data.frame(제품 = c('사과', '딸기', '수박'),
                        가격 = c(1800, 1500, 3000),
                        판매량 = c(24,38,13))
df_fruit


## Q2, 앞에서 만든 데이터 프레임을 이용해서 과일 가격 평균 판매량을 구해보시오. 
mean(df_fruit$가격)


## 외부데이터 가져오기
install.packages("readxl")


library(readxl)

.libPaths("C:\\Users\\admin\\Documents\\R\\win-library\\4.1") 

?.libPaths

df_exams = read_excel('C:\\Users\\admin\\R_course\\data\\excel_exam.xlsx') 

df_exams


## 데이터 읽어오기 
exam <- read.csv("C:\\Users\\admin\\R_course\\data/csv_exam.csv")
head(exam, 3)
tail(exam)

install.packages("ggplot2")

library(ggplot2)

x = c(1,2,3,4,5)
qplot(x) 


View(exam) ## 표로 보기 

dim(exam) ## 차원, 행렬 확인


rm(exam) ## 지우기 
exam
str(exam) ## 데이터 타입 확인

summary(exam) ## describe와 같다. ## 데이타 분포의 폭을 보기 위해서 

## 4분위 값을 보는 이유, IQR을 기준으로 mean max를 구한다.(R) 
## IQR mean값보다 작으면 이산값이다. 
## IQR MAX값보다 큰 값을 이산값이라 할 수 있다. 

a = 3
b = 2

# pandas의 desc
# min, max 값은 왜 볼까?
# 데이터 분포의 폭이 얼마나 크게 되어져 있는지 보기 위함.
# 4분위값은 왜 볼까?
# 근데 r에서 min, max값은 iqr(사분위값)을 기준으로 알려준다.(pandas에서는 리얼 min, max)
# 통계에서는 iqr min, iqr max값보다 작으면 이상값이라고 정의한다. 
# 이 기준이 이상치를 내 마음대로 지울 수 있는 타당성을 부여해줌
# 이러한 기준 없이 내 맘대로 지우면 데이터 조작에 해당한다. 
# 분석하기 좋은 데이터는 어떤 데이터일까? -> 정규분포인 데이터
# 내 데이터가 정규분포인지 아닌지 어케 봄? summary에서 중앙값이랑 평균이 같으면(근사하면) 정규분포이다(좌우대칭에 가깝다).
# 그래서 summary 보는 것이 중요하다. 


##### mpg 데이터를 이용한 기술통계해보기 

library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

## 데이터 확인하기
head(mpg)
dim(mpg)
str(mpg)
View(mpg)
summary(mpg)
## Mean과 IQR MAX MIN 정보를 확인하여, 한쪽으로 쏠려있거나, 한 데이터를 확인한다. 
## 데이터를 볼 때, 최빈값, 중간값을 확인할 필요가 있다. 


?qplot
table(mpg$hwy)

