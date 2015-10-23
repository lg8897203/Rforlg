# 抓取数据（目前只写了feeds部分的抓取）
f_weibo_get <- function(cH=ch0, N=200, hisnick='chenyibo', is_e=F){
  # N       想要获取的微博条数
  # hisnick 对方的ID
  # is_e    是否企业版
  # 根据操作系统选择加载包
  pkgs <- installed.packages()[, 1]
  if(!'XML' %in% pkgs){
    install.packages('XML', 
                     repos='http://mirrors.ustc.edu.cn/CRAN/')
  }
  if(!'RCurl' %in% pkgs){
    install.packages('RCurl')
  }
  if(!'RJSONIO' %in% pkgs){
    install.packages('RJSONIO', 
                     repos='http://mirrors.ustc.edu.cn/CRAN/')
  }
  
  sysname <- Sys.info()['sysname']
  if(length(grep('Windows', sysname)) == 1){
    try(memory.limit(4000), silent=T)
    require(RJSONIO)
  } else{
    require(RJSONIO)
  }
  require(RCurl)
  require(XML)
  
  # 先看一共有多少微博
  pg <- 1
  the1url <- paste('http://weibo.com/', hisnick, '/profile?page=', pg, sep='')
  the1get <- getURL(the1url, curl=cH, .encoding='UTF-8')
  oid <- gsub('^.*\\[\'oid\'\\] = \'([^\']+)\';.*$', '\\1', the1get)
  uid <- gsub('^.*\\[\'uid\'\\] = \'([^\']+)\';.*$', '\\1', the1get)
  if(is_e){
    onick <- gsub('^.*\\[\'onick\'\\] = \"([^\']+)\";.*$', '\\1', the1get)
    number <- gsub('^.*<strong>([0-9]+)</strong><span>微博.*$', '\\1', the1get)
  } else{
    onick <- gsub('^.*\\[\'onick\'\\] = \'([^\']+)\';.*$', '\\1', the1get)
    number <- gsub('^.*<strong node-type=\\\\"weibo\\\\">([0-9]+)<\\\\/strong>.*$', '\\1', the1get)
  }
  cnt <- min(as.numeric(number), N)
  # pages <- ceiling(min(as.numeric(number), N)/45)
  pages <- 1e+10
  
  weibo_data <- data.frame(weibo_content=NULL, weibo_time=NULL)

library(RJSONIO)
library(RCurl)

   the1url="http://s.weibo.com/weibo/%E8%8D%A3%E8%80%807%E5%8F%91%E5%B8%83%E4%BC%9A&page=1"
    the1get=getURL(the1url)
    k=strsplit(the1get,"\\n")[[1]]
    
    temp=k[grep("key=tblog_search_weibo&value=weibo_nologin_url",k)]
    temp
}


