## 라이브러리 설치
install.packages('ggiraphExtra')
install.packages('maps')
install.packages('stringi')
devtools::install_github('cardiomoon/kormaps2014')


## 라이브러리 임포트
library(ggplot2)
library(dplyr) ## 판다스
library(ggiraphExtra)
library(tibble) ## 대소문자
library(maps)
library(kormaps2014)

################ 범죄자 데이터 확인(미국)

str(USArrests)
dim(USArrests)
summary(library)
boxplot(USArrests)
head(USArrests, 3)

crim <- rownames_to_column(USArrests, var = 'state') ## 인덱스를 칼럼으로 변경
crim$state <- tolower(crim$state) ## 도시이름 소문자로 변경
head(crim)

## 지도 그림 그리기~
state_map <- map_data('state') ## 지도 데이터 불러오기
str(state_map)
 
ggChoropleth(data = crim,  ## 지도에 표현할 데이터
            aes(fill = Murder,  ## 색으로 표현할 컬럼
                map_id = state), ## 지역 기준 칼ㄻ
            map = state_map)   ## 지도 데이터



str(changeCode(korpop1))

korpop1 <- rename(korpop1, pop =  총인구_명,
                            name = 행정구역별_읍면동)

head(changeCode(korpop1))

ggChoropleth(data =changeCode(korpop1),
            aes(fill = pop,
                map_id = code,
                tooltip = name),
            map = kormap1,
            interactive = T)


ggChoropleth(data =korpop1,
            aes(fill = pop,
                map_id = code,
                tooltip = name),
            map = kormap1,
            interactive = T)


## 결핵환자 수 단계 구분 지도 
str(changeCode(tbc))


ggChoropleth(data = tbc,
            aes(fill = NewPts,
                map_id = code,
                tooltip = name),
            map = kormap1,
            interactive = T)

head(kormap1)





















