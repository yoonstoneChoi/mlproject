 ## 그래프 만들기~~ 
library(ggplot2)
library(dplyr) ## 판다스


df_mpg <- as.data.frame(ggplot2::mpg)

ggplot(data = mpg, aes(x = displ, y = hwy)) ## 판대기 선언, aes에 칸 선정

# 그래프 레이어
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() #3 포인터
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3,6) ## 범위 지정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3,6) + ylim(10,39)
## xilm : x리미트
## ylim: y리미트

#qplot() : matplotlib / 전처리시 신속히 시각화 할 때
#ggplot()seaborn / 최종 보고용,,, 아쁘게, 분석 결과,,,,

## X축 cty, y축 hwy 산잠도
gglot(data  = mpq0, we4])


gglot(data = midwest, aes(x = popotal, y=popasian)) + geom_point()

## 집단간 평균 막대르개프
df_mpg  <- mpg%>% 
    group_by(mean_hwy = mean(hwy)) %>% 
    summarise()


ggplot(data = mpg, aes(x = drv, y = mean_hwy)) + geom_col()



ggplot(data = mpg, aes(x = reorder(drv, mean_hwy), y = mean_hwy)) + geom_col()

ggplot(data = mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()



## 히스토그램 그래프는 막대그래프가 아니다!! 구간 및 빈도 확인이다. 
ggplot(data =mpg, aes(x=drv)) + geom_bar()

ggplot(data=mpg, aes(x=hwy)) + geom_bar()


## 평균 막대 그래프! 데이터를 요약한 평균표(꼭 평균표는 아니어도 됨)를 먼저 반들고 그래프 생성 geom_col()

## 빈도 막대 그래프! 별도로 표를 만들지 않고 그래프 생성 geom_bar()


# Q1 suv 차종에서, 어떤 회사가 도시연비가 높은지 알아 볼까? 상위 5개 뽑기
head(mpg, 3)

df <- mpg %>% filter(class == 'suv') %>% 
        group_by(manufacturer) %>% 
        summarise(cty_mean = mean(cty)) %>% 
        arrange(desc(cty_mean)) %>% head(5) 


ggplot(data = df, aes(x=reorder(manufacturer, -cty_mean), y = cty_mean)) + geom_col()



# Q2 자동차 종류(class) 빈도 그래프 만들기 
ggplot(data=mpg, aes(x=class)) + geom_bar()


# Q3 선그래프 그려볼까요~ ?
## 보통 시계열 데이터를 표현할 때 사용합니다. 

economics
ggplot(data=economics, aes(x= date, y= unemploy)) + geom_line()
str(economics)

ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

boxplot(economics$unemploy)

## 상자그림, 상자 수염
ggplot(data = mpg, aes(x= drv, y=hwy)) + geom_boxplot()


# 차 종류가 compact, subcompact, suv 인 도시연비 비교!
class_mpg <- mpg %>% filter(class %in% c('compact', 'subcompact', 'suv'))

ggplot(data = class_mpg ,aes(x= class, y = cty)) + geom_boxplot()

## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 
## geom_point() : 산점도 - 데이터 분포나 뱡향성 확인          ##
## geom_col(): 막대그래프 - 요약자료                         ##
## geom_bar(): 막대 그래프 - 원자료                          ##
## geom_line(): 선 그래프(시계열 데이터 표현 시)              ##
## geom_boxplot(): 상자 그림(데이터 분포, 이상치, 편향 확인)  ##
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 

## 지