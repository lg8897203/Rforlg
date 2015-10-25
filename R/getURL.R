library(RCurl)
d <- debugGatherer()
cH <- getCurlHandle(followlocation=T, 
                    autoreferer = T,
                    verbose=T, 
                    debugfunction=d$update, 
                    ssl.verifyhost=F, ssl.verifypeer=F, 
                    cookiejar='./cookies', cookiefile='./cookies')
url_login = 'http://ninghao.net/user/login'
pinfo=c(
	'name'='8897203@163.com',
	'pass'='8227879',
	'form_id'='user_login',
	'op'='登录'

)

ttt<- postForm(url_login, .params=pinfo, curl=cH, style='post')



write.table(ttt, file = "test4.txt")

url <- "http://ninghao.net/video/1723"
d <- getURL(url, curl = cH)
write.table(d, file = "test6.txt")

url_down <- "http://ninghao.net/system/dynamics/video/drupal-dm-02-02-pm-download-1340598315.mp4"
temp3 <- getURL(url_down)
temp3
temp <- getBinaryURL(url_down, curl = cH)
note <- file("下载模块2.mp4",open="wb")
writeBin(temp,note)
close(note)

temp2<-getURLContent(url_down,curl=cH,binary = TRUE)
note <- file("下载模块2.mp4",open="wb")
writeBin(temp2,note)
close(note)

//获取课程链接
html=getURL("http://ninghao.net/course/tag/drupal")
temp=strsplit(html,"<div class=\"thumbnail\">")[[1]]
temp=strsplit(temp,"\"><img typeof=\"foaf:Image\"")
temp=temp[-1]
temp=unlist(temp)
temp=strsplit(temp,"href=\"")
files=lapply(temp,function(x){x[2]})
files=unlist(files)
files=data.frame(files)
write.table(html, file = "html_drupal.txt")
write.csv(files, file = "files_drupal_ninghao.csv")

html2=getURL("http://ninghao.net/course/tag/drupal?page=1")
temp=strsplit(html2,"<div class=\"thumbnail\">")[[1]]
temp=strsplit(temp,"\"><img typeof=\"foaf:Image\"")
temp=temp[-1]
temp=unlist(temp)
temp=strsplit(temp,"href=\"")
files=lapply(temp,function(x){x[2]})
files=unlist(files)
files=data.frame(files)
write.csv(files, file = "files_drupal_ninghao_2.csv")

//获取视频链接
links=read.csv("files_drupal_ninghao.csv")
d <- debugGatherer()
cH <- getCurlHandle(followlocation=T, 
                    autoreferer = T,
                    verbose=T, 
                    debugfunction=d$update, 
                    ssl.verifyhost=F, ssl.verifypeer=F, 
                    cookiejar='./cookies', cookiefile='./cookies')
url_login = 'http://ninghao.net/user/login'
pinfo=c(
	'name'='8897203@163.com',
	'pass'='8227879',
	'form_id'='user_login',
	'op'='登录'

)
ttt<- postForm(url_login, .params=pinfo, curl=cH, style='post')

url=getURL(links$files[1],curl=cH)
tmp=strsplit(url,"<div class=\"header span6\"><a href=\"")[[1]]
tmp=strsplit(tmp,"\">")
tmp=tmp[-1]
videos=lapply(tmp,function(x){x[1]})
videos=unlist(videos)
write.csv(videos,"tmp.csv")

//获取视频下载链接
dlinks=read.csv("tmp.csv")
dlinks=paste("http://ninghao.net",dlinks$x[1],sep='')
durl=getURL(dlinks,curl=cH)
tmpp=strsplit(durl,"<source src=\"")[[1]]
tmpp=strsplit(tmpp,"\" type=\"video/mp4\">")
tmpp=tmpp[-1]
videolink=lapply(tmpp,function(x){x[1]})
videolink=unlist(videolink)

//下载视频
videolink=as.character(videolink)
name=strsplit(videolink,"http://ninghao.net/system/dynamics/video/")[[1]]
name=name[2]
name=as.character(name)
tempd <- getBinaryURL(videolink, curl = cH)
noted <- file(name,open="wb")
writeBin(tempd,noted)
close(noted)	
