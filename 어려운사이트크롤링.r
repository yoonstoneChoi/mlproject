install.packages("htmltab")




library(stringr) ## 스트링 작업
library(htmltab)
library(XML)


# url = 'https://finance.naver.com/item/sise_day.nhn?code=272210&page=1'

# readHTMLTable(url, Encoding = 'EUC-KR')

# readLines(url, eoncoding = "EUC-KR")
# htmltab(url, encoding = 'EUC-KR')
# a = readLines(url, encoding = 'EUC-KR')

url = 'https://gall.dcinside.com/board/lists/?id=superidea&page=1'
b = readLines(url, encoding = 'UTF-8')
head(b)
index1 = which(str_detect(b, "gall_subject")) ## 종류
index2 = which(str_detect(b, "gall_tit ub-word"))+1
index3 = which(str_detect(b, "data-nick")) ## 작성자


b2 = b[index2] ## 제목, 본문 내용 들어잇음
b3 = b[index3] ## 작성자명
b3

title = str_trim(str_extract(b2, ("(?<=</strong>).*(?=</a>)" )))
writer = str_extract(b3, ("(?<=data-nick).*(?=data-uid)" ))
writer2 = str_sub(writer, 3, end=-3)


## 정규표현식 ~ str_extract 필요한 문자만 뺀다. (?<= 이후에 시작할 문자)     .*는 모든 문자 (?=끝날 문자) //  "(?<= ).*(?= )"
## str_trim : 빈문자 묶기 

con_url = str_sub(str_extract(b2, ("(?<= href).*(?=view)")), 3, end=-2)
con_url
con_url2 <- paste0('https://gall.dcinside.com/', con_url)
con_url2
data = cbind(title, con_url2)
data2 = cbind(data, writer2)


write.csv(data2, "dcccc.csv", row.names = F)

## 최종버전 해보기!! 
##  제목, url, 글쓴이, 조회수, 작성일

## 일단 글쓴이를 가져와보자 
b[index1]
data2

