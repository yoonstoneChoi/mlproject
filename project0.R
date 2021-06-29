######################################################################
# [건강정보 데이터 분석] 01. 기본탐색
######################################################################

 
# ------------------------------------------------------------------------
### 문제시나리오: 환자의 유방암 여부를 예측할 수 있는 분류규칙의 도출

## 환자의 유방암과 상관관계가 있는 9개 세포학적 특성
#  ==> 1: 양성가능성 매우약함 ~ 10: 매우 악성인 상황

# ID: 환자아이디
# **clumpThickness: 덩어리 두께 
# sizeUniformity" 셀크기 균일성
# shapeUniformity: 셀모양 균일성 
# **maginalAdhesion: 한계부착력
# singleEpithelialCellSize: 단일상피세포크기 
# **bareNuclei: 기저핵 
# **blandChromatin: 브랜드 염색질 
# **normalNucleoli: 정상 핵소체
# **mitosis: 유사 분열, 체세포 분열

# class: 클래스 ==> 2: 양성(benign), 4: 악성(malignant)


# --------------------------------------------------
# 분석에 필요한 패키지 일괄 설치 및 로딩
# --------------------------------------------------
rm(list)
# 필요한 패키지 목록 생성
pkg <- c('readr', 'dplyr', 'magrittr', 
         'skimr', 'Hmisc', 'psych', 
         'ggplot2', 'gridExtra', 'doBy', 'summarytools', 
         'PerformanceAnalytics', 'corrplot', 'naniar')

# 필요패키지 설지여부를 체크해 미설치패키지 목록을 저장
new_pkg <- pkg[!(pkg %in% rownames(installed.packages()))]
new_pkg
# 미설치 패키지 목록이 1개라도 있으면, 일괄 인스톨 실시
if (length(new_pkg)) install.packages(new_pkg, dependencies = TRUE)

# 필요패키지를 일괄 로딩실시
suppressMessages(sapply(pkg, require, character.only = TRUE))  
# - suppressMessages() 함수를 통해 패키지 로딩시 나타나는 복잡한 설명/진행상황 문구 출력억제


# --------------------------------------------------
# 데이터셋 준비
# --------------------------------------------------

## 예제 데이터 준비
# UC Irvine Machine Learning Repository 보유데이터 활용

# UCI 머신러닝 저장소 사이트 접속

loc_uci <- "http://archive.ics.uci.edu/ml/machine-learning-databases/" 


# 사이트 접속정보
loc_url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/" 

# 데이터 위치정보
loc_cancer  <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"

# 접속 URL 준비
url <- paste(loc_uci, loc_cancer, sep='')
url


# 기본패키지 read.table() 함수를 이용해 온라인상의 데이터셋파일 로딩
raw <- read.csv(file=url,
                header=F, sep=',',
                stringsAsFactors = F,
                strip.white = T,
                na.strings = c('.','?','NA'))

dim(raw)

# readr::read_delim() 함수를 이용해 온라인상의 데이터셋파일 로딩
library(readr)
my <- read_delim(file=url,
                 col_names = F,
                 delim = ',',
                 trim_ws=T,
                 na = c(',','?','NA'))

dim(my)
head(my)
library(dplyr)

# --------------------------------------------------
# 데이터셋 기본정보 설정
# --------------------------------------------------

# 데이터셋 변수컬럼명 반영
names(my) <- c('id', 'thick', 'unisize', 'unishape', 'adhesion', 'cellsize', 'bareNuc', 'chromatin', 'normnuc', 'mitosis', 'class')

## 환자 아이디 변수컬럼 제외
 my <- my[-1]
head(my)


# --------------------------------------------------
# 데이터셋 기본구조 및 간단내용 조회
# --------------------------------------------------
str(my)
describe(my)
tail(my)
summary(my) ## 기술 통계데이터


# 정보설정내용 확인


# 데이터셋 간단조회



# - 전체 데이터셋 내용을 앞에서부터, 뒤에서부터 6개 레코드씩 간단하게 조회하여
#   어떠한 변수컬럼이 있는지, 어떠한 raw데이터로 구성이 되어 있는지 살펴봄




# --------------------------------------------------
# 데이터셋 기술통계분석
# --------------------------------------------------

# 데이터셋 기본 기술통계 



# 기술통계 패키지이용 분석
psych::describe(my) ## ~패키지의 :: 클래스 사용
Hmisc::describe(my)
skimr::skim(my) ## 유용하다~!


## 기술통계분석 새로운 패키지
library(summarytools)
summarytools::descr(my)


# --------------------------------------------------
# 데이터셋 전체 산점도 매트릭스
# --------------------------------------------------

# 산점도 매트릭스: 전체변수
plot(my)
hist(my)


# 전체변수간 상관관계 매트릭스
# (일부 NA포함 변수는 출력안됨)
round(cor(my,use = 'complete.obs'),2)  ##뒤에 숫자는 소수점 몇째 자리까지.
round(cor(my,use = 'complete.obs'),3) ## 'complte.obs' == NA값 제거 
plot(round(cor(my, use = 'complete.obs'),3))



# 데이터셋의 
# NA요소 제거 옵션설정 
# 상관관계 분석
temp <- cor(my, use = 'complete.obs')
round(temp,2)


# psych::pairs.panels() 함수이용
library(psych)
pairs.panels(my,
             method = 'spearman',
             hist.col='green',
             density=T,
             ellipses = T)




# PerformanceAnalytics::chart.Correlation() 함수이용
library(PerformanceAnalytics)
chart.Correlation(my, histogram = T)


# corrplot::corrplot() 함수이용
library(corrplot)
corrplot(cor(my, use ='complete.obs')) ## 전부 그림
corrplot.mixed(cor(my, use= 'complete.obs')) ## 반은 그림 반은 숫자
corrplot(cor(my, use= 'complete.obs'), method = 'pie')


### End of Source ####################################################


######################################################################
# [건강정보 데이터 분석] 02. 데이터 가공과 정제
######################################################################

 
# --------------------------------------------------
# 데이터셋 준비
# --------------------------------------------------


# 데이터셋 파일 온라인에서 로딩
# --------------------------------------------------
# 사이트 접속정보
 loc_url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/" 

# 데이터 위치정보
loc_cancer  <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"

# 접속 URL 준비
url <- paste(loc_uci, loc_cancer, sep = '') 

# readr::read_delim()함수이용 온라인상의 데이터셋 로딩
my <- read_delim(file=url,
                 col_names = F,
                 delim = ',',
                 trim_ws=T,
                 na = c(',','?','NA'))

 
# 데이터셋 구조파악


glimpse(my)


# 데이터셋 파일 오프라인으로 저장
# --------------------------------------------------
# 데이터셋 변수컬럼명 반영
names(my) <- c('id', 'thick', 'unisize', 'unishape', 'adhesion', 'cellsize', 'barenuc', 'chromatin', 'normnuc', 'mitosis', 'class')



# 정보설정내용 확인
str(my)



# 메모리상의 사용중인 데이터셋 하드디스크로 저장
write.csv(my, file='C:\\pywork\\data_course\\r_project\\data\\my_cancer.csv', row.names = F, quote = F)






# 오프라인 데이터셋파일 메모리로 로딩
# --------------------------------------------------
# readr::read_delim()함수이용 플레인텍스트 파일 로딩
my <- read_delim(file='C:\\pywork\\data_course\\r_project\\data\\my_cancer.csv', col_names = T,
                 delim = ',',trim_ws = T,
                 na = c('.','?','NA'))





# 데이터셋 구조파악
head(my,3)
dim(my)
glimpse(my)
str(my)



## 환자 아이디 변수컬럼 제외

my <- my[-1]


# 데이터셋 구조파악
head(my)
str(my)
# 데이터셋 간단조회
head(my); tail(my)

# 데이터셋 기본요약
summary(my)


# --------------------------------------------------
# 결측치 처리 
# --------------------------------------------------



# 데이터셋에 포함된 결측치 현황파악
# --------------------------------------------------
# NA관련 함수이용 결측치 포함유무 확인
table(is.na(my))
anyNA(my) ## NA가 있는가 하나라도
sapply(my, anyNA) ## 칼럼별로 있는지 알려준다. 
table(is.na(my$barenuc))



# 기술통계 함수이용 결측치 포함현황 파악

summary(my)
psych::describe(my) 
Hmisc::describe(my)
skimr::skim(my) ## 빈도그래프를 같이 보여준다. 




# 결측값 규모파악

library(magrittr)
my %>% is.na %>% sum
my %>% sapply(is.na) %>% colSums() ## 컬럼별로 결측치 확인해보기. 
my %>% sapply(is.na) %>% colSums()


# 결측치 패키지 이용 현황파악
# --------------------------------------------------
# naniar 패키지이용 결측치 현황파악
install.packages('naniar')

library(naniar)

# NA갯수
n_miss(my)

# 시그널갯수
n_complete(my)
# 변수별 NA현황
miss_var_summary(my)

# 데이터셋 단위에 포함된 결측치 일괄 제거
# --------------------------------------------------
# 원본데이터셋의 NA현황 재확인
summary(my)
dim(my)
anyNA(my)
my %>% is.na %>% sum



# NA포함 레코드/변수 일괄 삭제 전처리
# stats::na.omit()함수이용
my_omt <- na.omit(my)
anyNA(my)
my_omt %>% is.na %>% sum
dim(my_omt)



# stats::complete.cases()함수이용
my_cpt <- complete.cases(my)
anyNA(my_cpt)
my_cpt %>% is.na %>% sum
dim(my_cpt)




# 특정변수의 NA값을 임의값으로 단순대체
# --------------------------------------------------
# 기저핵(barenuc)변수 NA현황
anyNA(my$barenuc)
my$barenuc %>% is.na %>% sum

# 기저핵(barenuc)변수의 NA를 대체할 대표치 산정
# 0이나평균값, 중앙값, 최빈값을 활용함
barenuc_avg <- my$barenuc %>% mean(na.rm =T) %>% print
barenuc_med <- my$barenuc %>% median(na.rm =T) %>% print
barenuc_mode <- my$barenuc %>% table %>% which.max %>% names %>% as.integer %>% print


# 기저핵(barenuc)변수의 NA를 최빈값으로 대체
my$bareNuc[is.na(my$barenuc)] <- barenuc_mode

# 기저핵(barenuc)변수의 NA값 대체결과 확인
anyNA(my$barenuc)
my$barenuc %>% is.na %>% sum


# 데이터셋의 전체변수들에 포함된 결측치를 임의의 값으로 일괄 대체
# --------------------------------------------------
# 각 변수별 NA값을 각 변수별 중앙값으로 일괄 단순대체
# 각 변수별 중앙값 산정
sapply(my, median, na.rm = T)

# 각 변수별 중앙값을 각 변수별 NA마다 대체입력
my <- sapply(my, function(x)
             ifelse(is.na(x), yes = median(x, na.rm = T), no = x)) %>% as.data.frame



# my데이터셋에 포함된 NA값 재확인
table(is.na(my$barenuc))
anyNA(my)








# --------------------------------------------------
# 이상치 처리 
# --------------------------------------------------

## 이상치의 기준을 잘 정해야한다. 업계에서 허용하는 이상치 확인
## IQR을 확인하자. 



# 박스플롯 이용 분포현황 파악
# --------------------------------------------------
boxplot(my[1:9], main = '임상조직 세포 틍성 박스플롯 분포포')



# 연속형 변수중 단일상피세포크기(cellsize) 관련 변수 기술통계파악 
Hmisc::describe(my$cellsize)


# 박스플롯팅
bp <- boxplot(my$cellsize, main = '단일상피세포포')
## 중앙값이 아래로 편향되어 있음을 확인. 

# 박스플롯 내부구조 파악
str(bp)


# 박스플롯 내부구조 중 분위수(Quantile) 파악
bp$stats
# [1,]    0.1013 -> 하한선(lower fence) ## 맨아래 보다 작은 값들
# [2,]  595.9350 -> Q1: 1분위수(25%)
# [3,] 1000.0000 -> Q2: 2분위수(50%), 중앙값
# [4,] 1725.3325 -> Q3: 3분위수(75%)
# [5,] 3419.2500 -> 상한선(upper fence)

# 상한선값
bp$stats[5]


# 박스플롯 내부구조 중 이상치항목 탐색
bp$out
summary(bp$out)
Hmisc::describe(bp$out)

# - 상한선(upper fence) 값보다 큰 값은 절단(trimming)하거나
#   또는 상한선값으로 조정(winsorizing)하는 방향으로 전처리 필요
library(dplyr)


# 단일상피세포크기(cellsize) 변수 이상치 처리 
# --------------------------------------------------
# 상한선(upper fence) 값보다 큰 값을 절단화(trimming)
my_trim <- my %>% filter(cellsize <= bp$stats[5])


# - 원본 데이터셋에서 cellsize변수값이 상한선보다 낮은 값으로만
#   레코드를 선정해서 별도의 서브셋을 만들어 줌





# 이상치처리한 서브셋 기술통계량 확인

psych::describe(my_trim$cellsize)
boxplot(my_trim$cellsize)
Hmisc::describe(my_trim$cellsize)


# 상한선(upper fence) 값보다 큰 값을 상한선값으로 조정화(winsorizing)
my$cellsize_ws <- ifelse(my$cellsize > bp$stats[5], yes = bp$stats[5], no = my$cellsize)


# - 원본 데이터셋에서 ceelsize변수값이 상한선보다 큰경우에 
#   상한선 값으로 변경해서 원본데이터셋에 파생변수로 추가함

# 이상치처리한 파생변수 기술통계량 확인




# --------------------------------------------------
# 스케일링 
# --------------------------------------------------

# 정규화(normalization): 센터링옵션(centering) 
# ==> -1 ~ +1 사이로 변환, ctr: centering
my_centering <- my %>% scale(center = T) 
head(my_centering)
summary(my_centering)
## 인사이트를 얻기엔 이게 좋음(-1 ~ 1)



# 정규화(normalization): 레인징옵션(ranging) 
# ==> 0 ~ 1 사이로 변환, rng: ranging
my_ranging<- my %>% scale(center = F) 
summary(my_ranging)
## 비율적으로보면 0~1이 좋음


# 표준화(standardization): z-스코어(z-score) 
# ==> 평균0, 표준편차가 1인 표준정규분포로 변환
# - snd: standard normal distribution
my_snd <- my %>% scale(center = T, scale = T)
summary(my_snd) # 분산을 비교할 수 있다. 


par(mfrow = c(3,1)) ## 표 볼 때 한번에 3개 보겠다.
boxplot(my_centering, main = '정규화 : 센터링 옵션션')
boxplot(my_ranging, main = '정규화 : 레인징징 옵션션')
boxplot(my_snd, main = '표준화 : z-score')

par(mfrow = c(1,1)) ## 하나만 보는걸로 리셋
## 분산이 중요하다면 표준화
## 범위가 중요하다면 정규화 




# --------------------------------------------------
# 범주형 변수 리코딩 하기 
# --------------------------------------------------

# 판정결과변수 탐색
table(my$class)
Hmisc::describe(my$class)

# 판정결과 변수인 class 변수컬럼 레이블 반영
library(doBy)
my$class_c <- recodeVar(my$class, src = c(2,4), tgt = c('benign', 'malignant'))



# - benign: 양성, malignant: 악성


# 리코딩한 변수 기술통계 분석
class_freq <- table(my$class_c) %>% sort(decreasing = T) %>% head(5) %>% print








# janitor::tabyl() 함수이용
library(janitor)
install.packages('janitor')
tabyl(my$class_c, sort = T)




# epiDisplay::tab1() 함수이용
install.packages('epiDisplay')
library(epiDisplay)
tab1(my$class_c, sort.group = 'decreasing', cum.percent = T, main = 'class(판정결과) 분포포')
barchart(table(my$class_c) %>% sort(decreasing = T))


# --------------------------------------------------
# 연속형 변수의 구간화를 통한 파생변수 만들기
# --------------------------------------------------

# 변수리코딩
# doBy::recodeVar() 함수이용
library(doBy)
num <- list(1:2, 3:5, 6:8, 9:10) ## 범위 지정
check <- list('저 위험', '중 위험', '고 위험', '사망각')
my$thick_c <- recodeVar(my$thick, 
                        src = num,
                        tgt = check)
## 범위로 지정 해줌^^ 
barchart(table(my$thick_c) %>% sort())





# 리코딩한 변수 빈도수 분석

# - 위험위 순서가 고위험 > 저위험 > 정밀진단 > 중위험 순으로 나와서 
#   해석하기에 어려움

# 리코딩을 위험수준별 순서대로 변환
my$thick_f_freq <- factor(my$thick, levels=c(1:2, 3:5, 6:8, 9:10),
                       labels = c('저 위험', '저 위험','중 위험',
                                  '중 위험','중 위험','고 위험','고 위험',
                                  '고 위험', '사망각','사망각')
                       ) ## factor를 통해, 정렬

# 리코딩한 변수 빈도수 분석
thick_f_freq <- table(my$thick_f_freq) %>% print



# - 위험의 순서가 저위험 > 중위험 > 고위험 > 정밀진단 순으로 나와서 해석하기 용이함

# 리코딩변수 비율 분석
thick_prop <- thick_f_freq %>% prop.table %>% print
thick_prop
# 리코딩변수 빈도와 비율값 데이터프레임으로 출력
thick_df <- data.frame(freq = c(thick_f_freq),
                       pect = c(round(thick_f_freq)))%>% print



# janitor::tabyl() 함수이용
tabyl(my$thick_f_freq)


# epiDisplay::tab1() 함수이용
tab1(my$thick_f_freq, cum.percent = T, main = '핳하 헣헣')




# --------------------------------------------------
# 임상실험 샘플 수집시기 파생변수화
# --------------------------------------------------

# 유방암진단 임상실험 샘플 수집시기(UCI코딩북)
# - Group 1: 367 instances (January 1989) 
# - Group 2: 70 instances (October 1989) 
# - Group 3: 31 instances (February 1990) 
# - Group 4: 17 instances (April 1990) 
# - Group 5: 48 instances (August 1990) 
# - Group 6: 49 instances (Updated January 1991) 
# - Group 7: 31 instances (June 1991) 
# - Group 8: 86 instances (November 1991
                       

# 수집시기별 샘플수 산정

n1989 <- c(367, 70) %>% sum %>% print
n1990 <- c(31, 17, 48) %>% sum %>% print
n1991 <- c(49,31,86) %>% sum %>% print
total <- c(n1989, n1990, n1991) %>% sum %>% print

# 파생변수생성
my$time <- rep(c(1,2,3), c(n1989, n1990, n1991))
Hmisc::describe(my$time)
my$time


# 파생변수 리코딩
my$time_c <- recodeVar(my$time,
                       src = c(1,2,3),
                       tgt = c('y89', 'y90', 'y91'))




# janitor::tabyl() 함수이용
tabyl(my$time_c, sort = T) %>% print


# epiDisplay::tab1() 함수이용
tab1(my$time_c, sort.group = 'decreasing',
     cum.percent = T,
     main = '임삼실험 샘플 수집 시기기')







### End of Source ####################################################

######################################################################
# [건강정보 데이터 분석] 03. 변수간 관계특성 분석
######################################################################
 

# --------------------------------------------------
# 데이터셋 준비
# --------------------------------------------------

# 데이터셋 파일 로딩
# --------------------------------------------------

# readr::read_delim() 함수이용 티블형식으로 로딩
my <- read_delim(file = 'C:\\pywork\\data_course\\r_project\\data\\my_cancer.csv',
                 col_names = T,
                 delim = ',', trim_ws = T,
                 na = c('.','?','NA'))




# 간단 데이터셋 파악
dim(my)
str(my)
head(my)
summary(my)


# --------------------------------------------------
# 결측값 처리
# --------------------------------------------------

# 변수컬럼별 결측값 규모파악
my %>% sapply(is.na) %>% colSums


# 각 변수별 중앙값 파악
sapply(my, median, na.rm = T)

# 각 변수별 중앙값을 각 변수별 NA마다 대체입력
 my <- sapply(my, function(x)
              ifelse(is.na(x), yes = median(x, na.rm = T), no = x))

 my = my %>% as.data.frame
 

# 변수컬럼별 결측값 규모 재파악
 my %>% sapply(is.na) %>% colSums

# --------------------------------------------------
# 변수 리코딩
# --------------------------------------------------


# 종양유형(class) 변수 리코딩
# --------------------------------------------------

# 종양유형변수 탐색



# 종양유형 변수인 class 변수컬럼 레이블 반영
my$class_c <- recodeVar(my$class,
                        src = c(2,4),
                        tgt = c('양성', '악성성'))



# - benign: 양성, malignant: 악성


# 리코딩한 변수 기술통계 분석
# --------------------------------------------------
# 빈도수 계산
class_freq <- table(my$class_c) %>% sort(decreasing = T)
class_freq

# 비율 계산
class_prop <- class_freq %>% prop.table %>% sort(decreasing = T) %>%
              print


# 빈도수와 비율을 데이터프레임으로 조회
class_df <- data.frame(freq = c(class_freq), pect = paste(c(round(class_prop * 100, 3)), '%'))

class_df

# 기술통계 분석
# janitor::tabyl() 함수이용
tabyl(my$class_c, sort = T) %>% print


# epiDisplay::tab1() 함수이용
tab1(my$class_c, sort.group =  'decreasing', cum.percent = T, main = 'class(종양유형)분포포')




# --------------------------------------------------
# 종양유형(class)에 따른 임상조직 세포특성차이 분석
# --------------------------------------------------

# stats::aggregate() 이용 요약집계 작업
# --------------------------------------------------
# 요약집계 기준변수: 종양유형(class) 1개 
# 요약집계 결과변수: 암세포특성변수 1개씩 설정
# 요약집계 통계함수: 평균(mean) 1개

aggregate(thick ~ class_c, my, mean)

aggregate(unisize ~ class_c, my, mean)

aggregate(unishape ~ class_c, my, mean)

aggregate(adhesion ~ class_c, my, mean)

my$class_c



# for 반복구문을 이용한 1:1 요약집계 자동화

names(my)

for(i in 2:9){
  aggregate(x = list(my[i]),
            by = list(my$class_c),
            FUN = mean %>% print)
  cat('\n')
}







# stats::aggregate() 이용 요약집계 작업
# --------------------------------------------------
# 요약집계 기준변수: 종양유형(class) 1개 
# 요약집계 결과변수: 암세포특성변수 2개 이상 설정
# 요약집계 통계함수: 평균(mean) 1개













# psych::describeBy() 이용 요약집계 작업
# --------------------------------------------------
psych::describeBy(x = my[2:10], group = my$class_c)
my %>%  filter(!is.na(thick)) %>% group_by(class_c) %>% dplyr::summarize(thick_avg = mean(thick),
                                                                         thick_std = sd(thick)) 



# dplyr:: group_by()와 summarize() 이용 요약집계 작업
# --------------------------------------------------


# 요약집계 기준변수: 종양유형(class) 1개 
# 요약집계 결과변수: 암세포특성변수 1개씩 설정
# 요약집계 통계함수: 평균(mean), 표준편차(sd) 2개




# 결측치 먼저 필터링하고 연산




# 요약집계 기준변수: 종양유형(class) 1개 
# 요약집계 결과변수: 암세포특성변수 2개씩 설정
# 요약집계 통계함수: 평균(mean), 표준편차(sd) 2개




# 요약집계 결과변수: 암세포특성변수 여러 개 설정




# --------------------------------------------------
# 종양유형(class)에 따른 임상조직 세포특성차이 시각화
# --------------------------------------------------

# ggplot2::ggplot() 함수이용
# --------------------------------------------------

























# caret::featurePlot() 함수이용
# --------------------------------------------------
# install.packages("caret")




















# --------------------------------------------------
# 파생변수 생성
# --------------------------------------------------

# 임상실험 샘플 수집시기(time) 파생변수화
# --------------------------------------------------

# 유방암진단 임상실험 샘플 수집시기(UCI코딩북)
# - Group 1: 367 instances (January 1989) 
# - Group 2: 70 instances (October 1989) 
# - Group 3: 31 instances (February 1990) 
# - Group 4: 17 instances (April 1990) 
# - Group 5: 48 instances (August 1990) 
# - Group 6: 49 instances (Updated January 1991) 
# - Group 7: 31 instances (June 1991) 
# - Group 8: 86 instances (November 1991


# 수집시기별 샘플수 산정





# 파생변수생성



# 파생변수 리코딩





# janitor::tabyl() 함수이용



# epiDisplay::tab1() 함수이용







# --------------------------------------------------
# 종양유형(class)과 임상시기(time)에 따른 임상조직 세포특성차이 분석
# --------------------------------------------------

# stats::aggregate() 이용 요약집계 작업
# --------------------------------------------------
# 요약집계 기준변수: 종양유형(class), 임상시기(time) 2개 
# 요약집계 결과변수: 암세포특성변수 1개씩 설정
# 요약집계 통계함수: 평균(mean) 1개


















# for 반복구문을 이용한 1:1 요약집계 자동화










# stats::aggregate() 이용 요약집계 작업
# --------------------------------------------------
# 요약집계 기준변수: 종양유형(class), 임상시기(time) 2개 
# 요약집계 결과변수: 암세포특성변수 2개 이상 설정
# 요약집계 통계함수: 평균(mean) 1개











# psych::describeBy() 이용 요약집계 작업
# --------------------------------------------------












# dplyr:: group_by()와 summarize() 이용 요약집계 작업
# --------------------------------------------------


# 요약집계 기준변수: 종양유형(class), 임상시기(time) 2개 
# 요약집계 결과변수: 암세포특성변수 1개씩 설정
# 요약집계 통계함수: 평균(mean), 표준편차(sd) 2개




# 결측치 먼저 필터링하고 연산





# 요약집계 기준변수: 종양유형(class), 임상시기(time) 2개 
# 요약집계 결과변수: 암세포특성변수 2개씩 설정
# 요약집계 통계함수: 평균(mean), 표준편차(sd) 2개




# 요약집계 결과변수: 암세포특성변수 여러 개 설정




# --------------------------------------------------
# 종양유형(class)과 임상시기(time)에 따른 임상조직 세포특성차이 시각화
# --------------------------------------------------

# ggplot2::ggplot() 함수이용
# --------------------------------------------------





















# 멀티캔버스 이용




# --------------------------------------------------
# 연속형 변수의 구간화를 통한 파생변수 만들기
# --------------------------------------------------

# 변수리코딩
# doBy::recodeVar() 함수이용









# 리코딩한 변수 빈도수 분석

# - 위험위 순서가 고위험 > 저위험 > 정밀진단 > 중위험 순으로 나와서 
#   해석하기에 어려움

# 리코딩을 위험수준별 순서대로 변환




# 리코딩한 변수 빈도수 분석

# - 위험의 순서가 저위험 > 중위험 > 고위험 > 정밀진단 순으로 나와서 해석하기 용이함

# 리코딩변수 비율 분석


# 리코딩변수 빈도와 비율값 데이터프레임으로 출력



# janitor::tabyl() 함수이용



# epiDisplay::tab1() 함수이용





# --------------------------------------------------
# 종양유형(class)에 따른 임상조직 세포특성차이 교차분석
# --------------------------------------------------

# stas::xtabs() 함수이용 1:1 교차분석 작업
# --------------------------------------------------










# --------------------------------------------------
# 종양유형(class)과 임상시기(time)에 따른 임상조직 세포특성차이 시각화
# --------------------------------------------------


# CGPfunctions::PlotXTabs() 함수이용
# --------------------------------------------------
# install.packages('CGPfunctions')









# ggplot2::ggplot() 함수이용
# --------------------------------------------------























### End of Source ####################################################

