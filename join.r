## 패키지 임포트
library(ggplot2) ## 그래프 및 예제 자료가 들어있음
library(readxl) ## 엑셀 불러옴
library(dplyr) ## 판다스

exam <- read.csv("C:\\Users\\admin\\R_course\\data\\csv_exam.csv")
df_mpg <- as.data.frame(ggplot2::mpg)

exam %>% head(4)
## 데이터 합치기 
# 중간고사 점수
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(90,20,30,50,43))

## 기말고사 점수
test2 <- data.frame(id = c(1,2,3,4,5),
                    finalterm = c(20,30,45,21,32))

## id 기준으로 합쳐볼까요 
total <- left_join(test1, test2, by='id') ## 컬럼이름은 str으로 지정해줘야 함 

## 담임선생님 정보 
name <- data.frame(class = c(1,2,3,4,5),
                    teacher = c('choi', 'kim', 'lee', 'park', 'chung'))

## 클래스 기준으로 join  / left_join
exam_new <- left_join(exam, name, by = 'class') ## 기준 컬럼의 데이터가 서로 이빨이 맞아야함
exam_new

## 세로로 합치기/ bind_rows
## 학새 1~5번 시험 데이터 
group_a <- data.frame(id = c(1,2,3,4,5),
                    test = c(40,30,10,30,40))

## 학생 6 ~ 10번 시험 데이터 
group_b <- data.frame(id = c(6,7,8,9,10),
                    test = c(10,23,30,20,11))

group_ab <- bind_rows(group_a, group_b)
group_ab

## 혼자서 해보세요~!
## mpg 데이터에 연료 가격 합치기 

fuel <- data.frame(fl = c('c', 'd', 'e','p','r'),
                price_fuel = c(2.35, 2.38, 2.11, 2.76, 2.22),
                stringsAsFactors = F)
fuel
str(mpg)

fuel_price <- left_join(mpg, fuel, by = 'fl')

fuel_price %>% head(3)

fuel_price %>% select(model, fl, price_fuel) %>% head(3)


##### 정리 
### 1 조건에 맞는 데이터, 로우만 추출
## 로 선택
exam %>% filter(english >= 80)
exam %>% filter(english >= 80 & math >= 30)
exam %>% filter(english >= 80 | math >= 30) 

## 칼럼 선택
exam %>% select(english, math)


### 2 함수 조합하기 , 일부만 출력
exam %>% select(id, math) %>% head(3)

### 3 순서대로 정렬
exam %>% arrange(math) ## 오름차순 / 올라갈수록 숫자가 작아짐
exam %>% arrange(desc(math)) ## 내림차순 / 내려갈수록 숫자가 작아짐

### 4 파생변수 만들기 / 새로운 칼럼만들기
exam %>% mutate(total_Score = math + english + science,
                mean = total_Score / 3 )


### 5 ifelse 사용하기 
exam %>% mutate(total_Score = math + english + science,
                mean = total_Score / 3,
                passfail = ifelse(mean > 80 ,'pass', 'fail'))


### 6 집단별 요약
exam %>% group_by(class) %>% summarise(math_sum = sum(math))

### 7 데이터프레임 합치기 
## 레프트 조인
total <- left_join(test1, test2, by = 'id')
total
## 바인드(걍 아래에 붙여버리기)
all_group <- bind_rows(group_a, group_b)




########################################################
################분석 도전

df_mid <- as.data.frame(ggplot2::midwest)

df_mid %>% head(2)
str(df_mid)
dim(df_mid)
summary(df_mid)

### 미국 동북중부 437개 지역 인구 통계 정보
## popadult는 성인 인구
## poptotal은 전체 인구


## q1 전체 인구 대비 미성년 인구 백분율을 구해, 변수를 추가하세여 
df_mid_new <- df_mid %>% 
            mutate(popkid100 = ((poptotal - popadults)/poptotal) * 100)

## q2 미성년 인구 백분율이 가장 높은 상위 5개 지역의 인구 백분율 표시 

df_mid_new %>% select(county, popkid100) %>% 
            arrange(desc(popkid100)) %>% head(5)

## q3 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고, 각등급에 몇개에 지역이 있는지 알아보시오 

df_mid_new %>% mutate(kidratio = ifelse(popkid100 >= 40, 'large', ifelse(popkid100 >= 30, 'middle', 'small'))) %>% 
            group_by(kidratio) %>% 
            summarise(grade_count = n())


## q4 popasain은 해당 지역의 아시아인 인구를 나타냅니다. 
## 전체 인구 대비 아시아인 인구 백분율 변수를 추가하고, 하위 10개 지역의 state county 아시안 백분율을 출력해바

df_mid %>% mutate(asian100 = (popasian/poptotal) * 100) %>% 
        arrange(asian100) %>% head(10) %>% 
        select(state, county, asian100)
