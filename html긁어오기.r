## HTML 읽어오기 

## 크롤링 작업
## 1. 게시글 목록을 가지고 와보겠다.
##1) 제목, 조회수, 게시글 url 수집
##2) 게시글 내용가져오기~ 

library(stringr) ## 스트링 작업




##1) 제목조회수게시글url수집
url = 'https://www.clien.net/service/board/park?&od=T31&category=0'
reader = readLines(url, encoding = 'UTF-8')

head(reader, 20)
str(reader)  # chr [1:2174]

reader_txt = reader[str_detect(reader, 'subject_fixed')] # 공지빼고 30개 ## 이 회사는 탭키로 인덴트를 준다. 
ttt = gsub("><.*?", "", reader_txt) ## tag관련 된 것을 다 뺀다. 
#ttt = gsub(">", "", ttt) 
ttt = gsub("\t", "", ttt)
ttt[1]
title_index = which(str_detect(reader, 'subject_fixed'))-2 ## 제목위에 있던, 링크 위치를 불러온 것. 2번째 위에 
title_index
body = reader[title_index] ## body 링크주소 가져오기
body

## 내 방식으로 해 본 것. #################################
#reader_body = reader[str_detect(reader, 'list_subject')]
#reader_body2 = reader_body[2:31]
##########################################################

body2 = str_extract(body, "(?<=href).*(?=data)") ## 정규표현식 사용하기 ## href ~ data-role 사이로 지정
str_sub(body2, 3, end = -3)

url_list = past0('https://www.clien.net', str_sub(body2, 3, end=-3))

page_dat = cbind(ttt, url_list)
page_dat


