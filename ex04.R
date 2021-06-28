# 조건에 맞는 데이터만 추출하기  
library(dplyr)
exam <- read.csv("./data/csv_exam.csv")
head(exam)
dim(exam)

exam %>% filter(class == 1)
?filter

exam %>% filter(class == 2) 
exam %>% filter(math > 50 & class == 1) 
exam %>% filter(class == 2 & english >= 80)
exam %>% filter(math >= 90 | english >= 90)

exam %>% filter(class == 1 | class == 3 | class== 5)
exam %>% filter(class %in% c(1, 3, 5))
class1 <- exam %>% filter(class == 1)
class1
2 -> a
a
exam %>% filter(class == 1) -> class1
class1

mean(class1$math)

# Q1.
mpg <- as.data.frame(ggplot2::mpg)
mpg_displ_4 <- mpg %>% filter(displ <= 4)
mpg_displ_5 <- mpg %>% filter(displ >= 5)
mean(mpg_displ_4$hwy)
mean(mpg_displ_5$hwy)


# Q2.
mpg_audi <- mpg %>% filter(manufacturer == "audi")
mpg_toyota <- mpg %>% filter(manufacturer == "toyota")
mean(mpg_audi$cty)
mean(mpg_toyota$cty)

# Q3.
mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(mpg_new$hwy)


# 필요한 컬럼만 추출
exam %>% select(math)
exam %>% select(english)
exam %>% select(math, english)
exam %>% select(-math) # math 빼고 다 선택
exam %>% select(-math, -english)

# filter와 select 조합하여 사용
exam %>% 
  filter(class == 1) %>% 
  select(english)

exam %>% select(id, math) %>% head
exam %>% select(id, math) %>% head(3)

# Q1. 컬럼 선택 (cty, class)
mpg <- as.data.frame(ggplot2::mpg)
df <- mpg %>% select(class, cty)
head(df, 3)

# Q2.
df_suv <- df %>% filter(class == "suv")
df_compact <- df %>% filter(class == "compact")
mean(df_suv$cty)
mean(df_compact$cty)

# 정렬 하기
exam %>% arrange(desc(math))
exam %>% arrange(math)
exam %>% arrange(class, math)

mpg %>% filter(manufacturer == "audi") %>% arrange(desc(hwy)) %>% head(5) -> a
a

exam

exam %>% mutate(total = math + english + science) %>% head(3)
exam %>% mutate(total = math + english + science,
                mean = (math + english + science) / 3) %>% head(3)
exam %>% mutate(total = math + english + science,
                mean = (math + english + science) / 3,
                test = ifelse(science >= 60, "pass", "fail")) %>% 
  arrange(total) %>% 
  head(3)

exam %>% mutate(total = math + english + science,
                mean = (math + english + science) / 3,
                test = ifelse(science >= 60, "pass", "fail")) %>% 
  arrange(desc(total)) %>% 
  head(3)
  

# Q1. mpg 데이터 복사, 합산 연비 컬럼 추가
mpg
mpg_new <- mpg  
mpg_new <- mpg_new %>% mutate(total = cty + hwy)
head(mpg_new)
# Q2. 합산 연비 컬럼을 2로 나눔.
mpg_new <- mpg_new %>% mutate(mean = total / 2)
head(mpg_new)
# Q3. 평균연비 상위 3개 출력
mpg_new %>% arrange(desc(mean)) %>% head(3)

# Q4.
mpg %>% mutate(total = cty + hwy,
               mean = total / 2) %>% 
      arrange(desc(mean)) %>% 
      head(3)

# 집단별로 요약 하기
exam %>% summarise(mean_math = mean(math))

exam %>% group_by(class) %>% summarise(mean_math = mean(math))
exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math), #평균
            sum_math = sum(math),   #합계
            median_math = median(math), # 중앙값
            min_math = min(math), # 최소값
            max_math = max(math), # 최대값
            sd_math = sd(math), # 표준편차
            n = n()) # 갯 수
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(5)
  
mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

mpg %>% group_by(manufacturer) %>% 
  filter(class == 'suv') %>% 
  mutate(tot = (cty + hwy) ) %>% 
  summarise(mean_tot = mean(tot)) %>% 
  arrange(desc(mean_tot)) %>% 
  head(5)

# Q1. suv, compact 자동차 차종의 연비 비교
mpg %>% group_by(class) %>% summarise(mean_cty = mean(cty))

# Q2. 알파벳 순 정렬, 도시 연비가 높은 순으로 정렬
mpg %>% group_by(class) %>% summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

# Q3. 고속도로연비 가장 높은 회사.
mpg %>% group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

# Q4. 경차 차종을 가장 많 생산 회사
mpg %>% filter(class == "compact") %>% 
  group_by(manufacturer) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

# 데이터 프레임 합치기
# 중간 고사 점수
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
# 기말 고사 점수
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))
test1
test2

# id 기준으로 합치기
total <- left_join(test1, test2, by="id") # 기준 컬럼명을 문자열로 표시
total

# 단임 선생님
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))
exam
name

exam_new <- left_join(exam, name, by="class")
exam_new

# 세로 합치기
# 학생 1~5번 시험 데이터
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
# 학생 6 ~10번 시험 데이터
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))
group_a
group_b

group_all <- bind_rows(group_a, group_b)
group_all

# mpg 데이타에 연료 가격 합치기
fuel <- data.frame(fl = c("c", "d", "e", "p", "r"),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
str(mpg)

mpg_new <- left_join(mpg, fuel, by="fl")
head(mpg_new, 3)

mpg_new %>% select(model, fl, price_fl) %>% head(3)

# 정리
# 1. 조건에 맞는 데이터 로우만 추출
exam %>% filter(english >= 80)
exam %>% filter(english >= 80 & math >= 50)
exam %>% filter(english >= 80 | math >= 50)
exam %>% filter(english %in% c(60, 70, 80))

# 2. 필요한 컬럼만 추출
exam %>% select(math)

# 3. 함수 조합하기, 일부만 추력
exam %>% select(id, math) %>% head(3)

# 4. 순서대로 정렬
exam %>% arrange(math) #오름차순
exam %>% arrange(desc(math)) # 내림차순

# 5. 파생 변수 추가 하기
exam %>% mutate(total = math + english + science)
exam %>% mutate(test = ifelse(science >= 60, "pass", "fail"))

# 6. 집단별 요약
exam %>% group_by(class) %>% 
  summarise(mean_math = mean(math))

# 7. 데이터 프레임 합치기
# 가로로 합치기
total <- left_join(test1, test2, by="id")
# 세로로 합치기
group_all <- bind_rows(group_a, group_b)

bind_cols(group_a, group_b)
