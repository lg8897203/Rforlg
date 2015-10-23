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

x = getURLContent("http://www.omegahat.org/RCurl/data.gz")
     class(x)
attr(x, "Content-Type")
x
     curl = getCurlHandle()
     dd = getURLContent("http://www.omegahat.org/RJSONIO/RJSONIO.pdf",
                        curl = curl,
                        header = dynCurlReader(curl, binary = TRUE,
                                           value = function(x) {
                                                    print(attributes(x)) 
                                                    x}))