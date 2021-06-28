## 패키지 임포트
library(ggplot2) ## 그래프 및 예제 자료가 들어있음
library(readxl) ## 엑셀 불러옴
library(dplyr) ## 판다스



## 문제 1 데이터 불러오기 및 특성 파악
df_mid <- as.data.frame(ggplot2::midwest)

head(df_mid)
str(df_mid)
dim(df_mid)
summary(df_mid)

## 문제 2 칼럼명 변경 
df_mid <- rename(df_mid, total = poptotal)
df_mid <- rename(df_mid, asian = popasian)

## 문제 3 전체 인구 대비 아시아 인구 백분율 파생 변수 만들고, 히스토그램 만들기
df_mid$asianper <- (df_mid$asian / df_mid$total) * 100
table(df_mid$county)

hist(df_mid$asianper)

group_by(df_mid, df_mid$group)['asianper']


## 문제 4 백분률, 전체 평균 비교 
mean(df_mid$asianper)
df_mid$group <- ifelse(df_mid$asianper > 0.4872462, 'large', 'small')



## 문제 5 빈도수 확인
df_mid[df_mid$group == 'large', c('county', 'asianper')]

table(df_mid$group)
qplot(df_mid$group)
