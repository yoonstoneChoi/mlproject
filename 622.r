

## 실습하기전 갑자기 예제  copy() / 판다스에선 레퍼런스 변수일 경우, A = B했을 때, A를 바꾸면 B도 바뀜 이걸 구분해야함
df_raw <- data.frame(var1 = c(1,2,1), var2 = c(2,3,2)) ## 예제 데이터 프레임
df_new <- df_raw ## 여기선 레퍼런스 변수로 바뀌진 않음,  value copy 형태임, 즉 메모리를 2개 차지함`

df_new <- rename(df_new, v2 = var2) ## var2를 v2로 바꾸겠다는 것, 칼럼명 변경


## ## ## ## ## ## ## ## ## ## ## #
#                                #
#                                #
#        R로하는 데이터 분석      #
#         자동차 가스 배기량      #
#                                #
## ## ## ## ## ## ## ## ## ## ## #

## 패키지 다운로드
install.packages("dplyr") ### 판다스와 유사(데이터 프레임)


## 패키기 임포트
library(ggplot2) ## 그래프 및 예제 자료가 들어있음
library(readxl) ## 엑셀 불러옴
library(dplyr) ## 판다스


## 데이터 가져오기 

mpg <- as.data.frame(ggplot2::mpg) ## 실습 데이터 as.data.frame

## 데이터 확인하기
head(mpg)
dim(mpg)
str(mpg)
View(mpg)
summary(mpg)

## 데이터 복사 및 칼럼명 변경
mpg_new <- mpg

mpg_new <- rename(mpg_new, city = cty)
mpg_new <- rename(mpg_new, highway = hwy)

## 파생변수 만들기 
df <- data.frame(var1 = c(1,2,3), var2 = c(2,4,1)) ## 예시

sum(df$var1)
sum(df$var2)

df$var_sum <- df$var1 + df$var2 # 예시
df$var_mean <- (df$var1 + df$var2)/2 ## 예시

## 다시 mpg데이터

mpg$total <- (mpg$cty + mpg$hwy)/2  ## 도로(시내 도로, 고속 도로) 구분 없이 평균 연비
head(mpg)

## 여기서 잠깐1, 통계적으로 평균은 대표하는 숫자를 의미한다. 

## 중심극한정리 => 편차를 다 더하면 0이 나온다. 

summary(mpg$total) ## 기본적인 통계 정보 확인

hist(mpg$total) ## total의 히스토(빈도)그램을 보자, 

## 조건문 사용
ifelse(mpg$total >= 20, 'pass', 'fail') ## 20보다 크거나 같으면, 트루, 아니면 펄스, 말은 암거나 가능
ifelse(mpg$total >= 20, TRUE, FALSE) ## 억지로 불린 만들기 
mpg$total >= 20 ## 불린으로 줌

mpg$total[mpg$total >= 20] # 불린으로 인덱싱
## 응용해보기
head(mpg)
mpg[mpg$manufacturer == "hyundai"]


mpg$test <- ifelse(mpg$total >= 20, 'pass', 'fail') ## 파생변수 추가

## 빈도수 구하기 
table(mpg$test)


qplot(mpg$test)


## A등급 : 30이상, B등급 : 20~ 29, C등급 : 20미만
mpg$grade <- ifelse(mpg$total >= 30, 'A', ifelse(mpg$total >= 20, 'B', 'C')) ## 30보다 크면 A인데 아니면, 다시 이프엘스로 B나 C가 나온다.

head(mpg)
table(mpg$grade) ## 그레이드 별 빈도
qplot(mpg$grade)

## 등급을 더 쪼개보자
mpg$grade3 <- ifelse(mpg$total >= 30, 'A', ifelse(mpg$total >= 25, 'B', ifelse(mpg$total >= 20 , 'C', 'D')))
table(mpg$grade3)

#