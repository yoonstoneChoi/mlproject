# lab 1
# memory에서 전체 변수 제거
rm(list=ls())
# 작업 디렉토리 확인 및 설정
getwd()
setwd('C:\\pywork\\data_course\\r_project') # 내 작업 디렉토리

# 원본 데이터 읽기
data_cust <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BGCON_CUST_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")


data_claim <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BBGCON_CLAIM_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

data_cntt <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BBGCON_CNTT_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

data_fmly <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BBGCON_FMLY_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

data_fpinfo <- read.csv("C:\\Users\\admin\\Downloads\\r_hanwha_Data\\BBGCON_FPINFO_DATA.csv", header=T,sep=',',encoding = 'CP949', fileEncoding="UCS-2")

dim(data_cust)
dim(data_claim)
dim(data_cntt)
dim(data_fmly)
dim(data_fpinfo)
