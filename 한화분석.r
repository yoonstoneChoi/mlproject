# lab 1
# memory에서 전체 변수 제거
rm(list=ls())
# 작업 디렉토리 확인 및 설정
getwd()
setwd('C:\\pywork\\data_course\\r_project') # 내 작업 디렉토리

# 원본 데이터 읽기
data_cust <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BGCON_CUST_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")


data_claim <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BGCON_CLAIM_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

data_cntt <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BGCON_CNTT_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

data_fmly <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BGCON_FMLY_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

data_fpinfo <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BGCON_FPINFO_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

dim(data_cust)
dim(data_claim)
dim(data_cntt)
dim(data_fmly)
dim(data_fpinfo)


# 정상, 사기자 수 확인
count_siu <- table(data_cust$SIU_CUST_YN) # 사기자 수:18801, 정상 수: 1806  # 시각화 필요 
count_siu
names(count_siu) <- c("분석대상", "정상인", "사기자")
pie(count_siu,
    cex=0.8, # 빨간색
    main = "사기자 수",
    labels = paste(names(count_siu), "\n",
                   count_siu, "명", "\n",
                   round(count_siu/sum(count_siu)*100), "%"))


# 결측치 확인  ... NA, NULL, 999, 9999
# 나이데이터를 세대 별로 카테고리화 작업
# y/n -> 0,1 형태로 바꿔야 함
# 나이를 세대별로! 

## 함수 선언
age_to_gen = function(row){ ## 익명함수
  row = floor(row/10) ## 연령대별로 구분 짓기 위해서!
}

## 연령대별로 구분하기
data_cust$AGE = sapply(data_cust$AGE, age_to_gen) ## 각 셀에 함수를 적용한다. 
data_cust$AGE

## y = 1, n = 0으로 변환

yn_to_10 = function(row){
  if(row == "Y")
    row = 1
  else if(row == 'N')
  row = 0
  else
    row = ''
}

data_cust$SIU_CUST_YN = sapply(data_cust$SIU_CUST_YN, yn_to_10)
data_cust$WEDD_YN = sapply(data_cust$WEDD_YN, yn_to_10)
data_cust$FP_CAREER = sapply(data_cust$FP_CAREER, yn_to_10)

## NA를 0으로 처리! 
na_to_0 = function(row){
  if(is.na(row))
    row = 0
  else
    row = row
}

data_cust$RESI_TYPE_CODE = sapply(data_cust$RESI_TYPE_CODE, na_to_0)
data_cust$TOTALPREM = sapply(data_cust$TOTALPREM, na_to_0)


city_to_code = function(row){
  if(row=="서울") 
    row = 1
  else if(row=="부산")
    row = 2
  else if(row=="대구")
    row = 3
  else if(row=="인천")
    row = 4
  else if(row=="광주")
    row = 5
  else if(row=="대전")
    row = 6
  else if(row=="울산")
    row = 7
  else if(row=="세종")
    row = 8
  else if(row=="경기")
    row = 9
  else if(row=="강원")
    row = 10
  else if(row=="충북")
    row = 11
  else if(row=="충남")
    row = 12
  else if(row=="전북")
    row = 13
  else if(row=="전남")
    row = 14
  else if(row=="경북")
    row = 15
  else if(row=="경남")
    row = 16
  else if(row=="제주")
    row = 17
  else
    row = 0
}

data_cust$CTPR = sapply(data_cust$CTPR, city_to_code)

## MINCRDT, MAXCRDT NA 데이터를 6으로 변환

na_to_6 = function(row){
  if(is.na(row))
    row = 6
  else
    row = row
}

data_cust$MINCRDT = sapply(data_cust$MINCRDT, na_to_6)
data_cust$MAXCRDT = sapply(data_cust$MAXCRDT, na_to_6)

data_cust$CUST_INCM = sapply(data_cust$CUST_INCM, na_to_0)
data_cust$JPBASE_HSHD_INCM = sapply(data_cust$JPBASE_HSHD_INCM, na_to_0)

## OCCP_GRP 첫 글자를 빼내서 코드화
occp_gro_1_to_no = function(row){
  row = substr(row,1,1)
  if(row == '')
    return(0)
  else
    return(as.integer(row))
}

data_cust$OCCP_GRP_1 = sapply(data_cust$OCCP_GRP_1, occp_gro_1_to_no)

# 널 문자를 N으로, 변환하는 작업 
table(data_cust$WEDD_YN)
nullstring_to_n = function(row){
  if(row == 'N')
    row = "N"
  else if(row == 'Y')
    row = 'Y'
  else
    row = 'N'
}

data_cust$WEDD_YN = sapply(data_cust$WEDD_YN, nullstring_to_n)
data_cust$WEDD_YN = sapply(data_cust$WEDD_YN, yn_to_10)

write.csv(data_cust, 'C:\\Users\\admin\\R_course\\data\\cust.csv', row.names = F)










