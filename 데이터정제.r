## 데이터 정제

## 패키지 임포트
library(dplyr) ## 판다스


# 결측치 만들기 

df <- data.frame(gender = c('m', 'f', NA, 'm', 'f'),
                score = c(5,4,3,2,NA))

## 아스키코드 상, NA이도 값이 있다. 그냥 우리가 보기에 아무것도 없을 뿐

## 결측치 확인 
is.na(df) ## TRUE FALSE 반환

table(is.na(df)) ## 결측치 빈도 확인
df %>% is.na() %>% table() ## 위와 동일
## 전체 테이블에서 결측치가 ~% 이상일 경우 데이터를 버리기도 한다 

table(is.na(df$gender)) ## 컬럼별로 확인 가능

## 결측치 존재 시, NA 반환 
mean(df$score) 
sum(df$score)
## 계산이 안되쥬~ 

## 결측치 행 제거

df %>% filter(!is.na(score))
df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

df_nomiss <- df %>% filter(!is.na(score) & !is.na(gender))

df_nomiss

df_nomiss2 <- na.omit(df)

df_nomiss2

mean(df$score, na.rm = TRUE) ## 결측치 빼고 계산해줌 

exam <- read.csv("C:\\Users\\admin\\R_course\\data\\csv_exam.csv")

exam[c(3,8,15), 'math'] <- NA ## NA집어넣기 
exam

exam %>% summarise(mean_math = mean(math, na.rm = TRUE),
                    sum_math = sum(math, na.rm = TRUE),
                    median_math = median(math, na.rm = TRUE))


## 결측치 대체법
# -대표값으로 바꾸기 (평균, 최빈값, 중앙값, 가중평균....)
# - 통계분석 기법을 적용하는 방법, 예측값 추정하는 방법
# 통계분석 기법을 적용한다는 것은, 추이를 보고 해당되는 값을 넣기도 하고 회귀분석을해서 넣기도 함.
# 설득력 없는 것은 평균이다. 적용하기 앞서, 왜 해당 값을 정했는지 설득시킬 수 있어야한다. 데이터 특성을 확인해야 함 


## 평균가지고, 결측치 제거해볼까요~!! 
mean(exam$math, na.rm = TRUE)

exam$math <- ifelse(is.na(exam$math), mean(exam$math, na.rm = TRUE), exam$math) ## 소수점은 담당자랑 얘기하기

## 해보고 싶은 것, 회귀분석, 결측치 정리

mean(exam$math) ## NA를 채우고나서, 특성이 바뀌었는지 확인해야 함



## mpg로 실습해봅시다 
mpg <- as.data.frame(ggplot2::mpg)

mpg[c(65, 123, 21, 54, 12), 'hwy'] <- NA


# Q1 drv 별로 hwy 평균이 어떻게 다른지 확인! , 결측치 있는지 있는지 확인! 
# 결측치 있는지 확인 

table(is.na(mpg$drv))
table(is.na(mpg$hwy))

## drv 별로, hwy 평균 확인
# 혼자 풀어보겠음


## 이상한 데이터를 찾아라! - 이상치 정제하기
# 성별 변수에 3이라든가 몸무게에 700이라든지 그런 것
# 결측치를 처리하고 나서, 진행


## 이상치 만들기 
outlier <- data.frame(gender = c(1,2,1,3,2,1),
                    score = c(5,4,3,4,2,6))

## 이상치 확인
table(outlier$gender) ## 성별은 두가진데 3개로 나온다 신기
table(outlier$score) ## 빈도를 통해 이상치를 볼 수 있다. 

## 이상치를 제거하거나, 처리를 한다. 
## NA로 바꾼담에 그담에 
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)


## 이상치 제거. score 1~5 범위가 아닌 값
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)

## 성별 별로 score 평균 구하시오 
out_nomiss <- na.omit(outlier)

out_nomiss %>% group_by(gender) %>% summarise(mean_score = mean(score))

## 통계적 판단: 상하위 0.3% 극단치 또는 상자그림 1.5IQR 벗어나면 극단치
## 논리적 판단: 내 맘

boxplot(mpg$hwy)$stats ## 요거 좋드라

## 통계적 기준의 이상치 처리 
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)


table(is.na(mpg$hwy))