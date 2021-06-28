## 패키지 임포트
library(dplyr) ## 판다스

exam <- read.csv("C:\\Users\\admin\\R_course\\data\\csv_exam.csv")

exam[c(3,8,15), 'math'] <- NA ## NA집어넣기 

exam
exam_nomiss <- na.omit(exam)

exam_nomiss$total <-exam_nomiss$math + exam_nomiss$english + exam_nomiss$science

df_val

df_val = exam_nomiss %>% mutate(total_mean = total / 3)

row1 <-  array(c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1))
row1 <- t(row1)
row1
X = df_val[,3]
y = df_val[,7]
X <- matrix(X, nrow=17, ncol=1, byrow=FALSE, dimnames = NULL)



### 회귀를 시도해보자. 
y <- matrix(y, nrow=17, ncol=1, byrow=FALSE, dimnames = NULL)
X <- cbind(row1, X)
theta <- matrix(c(0,0),nrow=2, ncol=1, byrow=FALSE, dimnames = NULL ) 
num_iter = 1:1000
alpha <- 0.01
m <- 17


for(i in 1:125){
    theta[1] = theta[1] - sum((alpha/m)*(X%*%theta - y))
    theta[2] = theta[2] - sum(h%*%((alpha/m)*(X%*%theta - y)))
}

 h <- matrix((t(X)[2,]), nrow=1, ncol=17, byrow=FALSE, dimnames = NULL)


theta
