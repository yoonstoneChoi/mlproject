## 패키지 임포트
library(ggplot2) ## 그래프 및 예제 자료가 들어있음
library(readxl) ## 엑셀 불러옴
library(dplyr) ## 판다스

exam <- read.csv("C:\\Users\\admin\\R_course\\data\\csv_exam.csv")
head(exam, 3)
dim(exam)
str(exam)
summary(exam)



## %>% 사용
exam %>% filter(class == 1)
exam %>% filter(class != 1)
exam %>% filter(math > 50 & class ==1) ## &사용 가능
exam %>% filter(math > 50 | english > 90) ## |는 or 기호

## 매쏘드처럼 작동하는지 확인
exam %>% filter(class == 1) %>% head(1) ## 캬~
exam %>% filter(class == 1) %>% head


exam$class %in% c(1,3,5) ##  %in%은 불린으로 반환한다.
exam %>% filter(class %in% c(1,3,5)) ##isin 매쏘드
## 여러 조건들을 넣을 수 있다. 


## 파이썬처럼 써보기
exam[exam$class == 1,]
exam[exam$class %in% c(1,2,3), ] ## 얘는 안됨 ## 얘는 파이썬도 안되나?


## 혼자서 해보기 

## 퀴즈 1 자동차 배기량에 따라, 고속도로 연비 확인, 배기량(disp)이 4이하인차와 5이상인 차중에 어던 차의 고속연비가 평균적으로 더 높을까? 
df_mpg <- as.data.frame(ggplot2::mpg)
df_mpg %>% head(3)
df_mpg_dspl4 <- mpg %>% filter(displ < 4)
df_mpg_dspl5 <- mpg %>% filter(displ > 5)

mean(df_mpg_dspl4$hwy)
mean(df_mpg_dspl5$hwy) ## 연비가 평균적으로 더 안좋다. 

## 퀴즈 2 
df_mpg_audi <- mpg %>% filter(manufacturer == "audi")
df_mpg_toyota <- mpg %>% filter(manufacturer == "toyota")

df_mpg_audi$hwy %>% mean()
df_mpg_toyota$hwy %>% mean()

## 퀴즈 3
mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda"))
mpg_new$hwy %>% mean()



## 필요한 컬럼만 추출
exam %>% select(c(english,math))
exam %>% select(-math) ## 수학빼고 가져오기 
exam %>% select(-math, -english)  ## 두개도 뺄 수 있다. 


## filter와 select 같이 써보기 
## 필터로 먼저 row를 줄이는 것이 데이터 처리하는 것에 유리하다. (메모리를 최대한 효율적으로 활용)
exam %>% 
    select(math, english) %>% 
    filter(math > 80) %>% 
    filter(english > 40)


exam %>% filter(class == 1) %>% select(math, english)


## 갑자기 mpg 문제 하기 
mpg_suv <- mpg %>% filter(class == 'suv')
mpg_compact <- mpg %>% filter(class == 'compact')

## suv와 소형차 간에 시내 연비 평균 확인
mpg_suv$cty %>% mean()
mpg_compact$cty %>% mean()


## R에선 정렬(order by)을 어레인지로 함
exam %>% arrange(desc(math)) ## 디센딩
exam %>% arrange(math) ## 어센딩
exam %>% arrange(class, engilsh)


## mutate() 사용하기, 추가해서 덧붙이기 
exam %>% mutate(total = math + english)  ## 파생변수 만들기
exam %>% mutate(total2 = math + english + science,
                mean = (math + english + science)/3)


exam %>% mutate(total = math + english + science,
                mean = (math + english + science)/3,
                test = ifelse(math > 60, 'pass',' fail')) %>% 
                arrange(total) %>% 
                head(3)

## r에선 인덱스로하면, 1부터 시작함
## 젠장 

## 문제 풀기
mpg_hybrid <- mpg %>% mutate(hybrid = hwy + cty)
# q1 doen
# q2 합산 연비 2로 나눠 평균 연비 변수
mpg_hybrid %>% mutate(mean_hc = mpg_hybrid$hybrid / 2) %>% arrange(desc(mean_hc)) %>% head(3)

# q3 평균 연비변수가 가장 ㅈ높은자동차 3종 폭스바겐이 짱이네
mpg_hybrid %>% arrange(desc(mean_hc)) %>% head(3)
## 가고싶은 곳을 찾아보자 

## 한번에 해봐라
mpg_hybrid %>% mutate(mean_hc = mpg_hybrid$hybrid / 2) %>% arrange(desc(mean_hc)) %>% head(3)

## summarise 함수 사용해보기 
exam %>% summarise(mean_math = mean(math))
exam %>% group_by(class) %>% summarise(mean_math = mean(math))

exam %>% group_by(class) %>% summarise(mean_math = mean(math),
                                    sum_math = sum(math),
                                    median_math = median(math),
                                    min_math = min(math),
                                    max_math = max(math),
                                    sd_math = sd(math),
                                    n = n())  


mpg %>% 
    group_by(manufacturer, drv) %>%
    summarise(mean_cty = mean(cty)) %>%
    arrange(desc(mean_cty)) %>%
    head(5)


## 여기서~! 문제! 회사별로 suv 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬하고 1~5위 까지 출력하기
mpg %>% filter(mpg$class == 'suv') %>%
         group_by(manufacturer) %>% 
         mutate(target = cty + hwy) %>% 
         summarise(target_mean = mean(target)) %>%
         arrange(desc(target_mean)) %>%
         head(5)


## suv 컴팩 별로 자동차 차종의 연비 비교 
mpg %>% group_by(class) %>% summarise(mean_cty = mean(cty))

## 알파벳 순으로 정렬 
mpg %>% group_by(class) %>% 
        summarise(mean_cty = mean(cty)) %>% 
        arrange(desc(mean_cty))


## 고속도로 연비를 구하시오 
mpg %>% group_by(manufacturer) %>% 
    summarise(mean_hwy = mean(hwy)) %>% 
    arrange(desc(mean_hwy))


## 경차 차종을 가장 많이 생산하는 회사는~? 

mpg %>% filter(class == 'compact') %>%
        group_by(manufacturer) %>%
        summarise(count_comp = n()) %>%
        arrange(desc(count_comp))

mpg %>% filter(class == 'compact') %>%
        group_by(manufacturer)



