library(RCurl)
require(RJSONIO)
library(PKI) # for RSA 
library(gmp) # for big int
name = "3265580161@qq.com"
pwd = "a123456"
name1 <- URLencode(name, reserved=T)
name2 <- base64(name1)[1]
url_login = 'http://login.sina.com.cn/sso/login.php?client=ssologin.js(v1.4.5)'
d <- debugGatherer()
cH <- getCurlHandle(followlocation=T, 
                    autoreferer = T,
                    verbose=T, 
                    debugfunction=d$update, 
                    ssl.verifyhost=F, ssl.verifypeer=F, 
                    cookiejar='./cookies', cookiefile='./cookies')

preurl <- paste('http://login.sina.com.cn/sso/prelogin.php?entry=weibo&callback=sinaSSOController.preloginCallBack&su=', 
                name2, '&rsakt=mod&client=ssologin.js(v1.4.5)&_=1364875106625', sep='')
prelogin <- getURL(preurl, curl=cH)
preinfo <- fromJSON(gsub('^.*\\((.*)\\).*$','\\1',prelogin))
servertime <- preinfo$servertime
pcid <- preinfo$pcid
nonce <- preinfo$nonce
pubkey <- preinfo$pubkey
rsakv <- preinfo$rsakv
pub_n <- "165138424261149263963666229661164814908887524950166142962960019363944425161240370251403452452001165143400173133423045791330687304650944332950460079059702342999940532642226896299225258939028313437520982527474148958262129523279095471616009516621824844891755906467794220597075349492626446841979774101805104112707" 
pub_n <- as.bigz(pub_n)
rsaPublickey_pem <- PKI.mkRSApubkey(pub_n,65537)
rsaPublickey <- PKI.load.key(rsaPublickey_pem)
message <- paste0(servertime ,'\t', nonce, '\n', pwd)
sp <- PKI.encrypt(charToRaw(message), rsaPublickey)
sp <- raw2hex(sp,"")
pinfo=c(
  'entry'= 'weibo',
  'gateway'= '1',
  'from'= '',t
  'savestate'= '7',
  'userticket'= '1',
  'ssosimplelogin'= '1',
  'vsnf'= '1',
  'vsnval'= '',
  'su'= name2,
  'service'= 'miniblog',
  'servertime'= servertime,
  'nonce'= nonce,
  'pwencode'= 'rsa2',
  'sp'= sp,
  'encoding'= 'UTF-8',
  'url'= 'http://weibo.com/ajaxlogin.php?framelogin=1&callback=parent.sinaSSOController.feedBackUrlCallBack',
  'returntype'= 'META',
  'rsakv' = rsakv)
bkp_ctype <- Sys.getlocale('LC_CTYPE')
if(bkp_ctype == 'zh_CN.UTF-8'){Sys.setlocale('LC_CTYPE', 'C')}
x <- try(ttt <- postForm('http://login.sina.com.cn/sso/login.php?client=ssologin.js(v1.4.5)', .params=pinfo, curl= cH, style='post'), silent=T)
if(class(x) == 'try-error') 
{cat('no!!!!!!');return(NULL)}
newurl <- gsub("^.*location.replace\\(\\'(.+)\\'\\);.*$","\\1",ttt[1])
x <- try( xxx <- getURL(newurl, curl=cH, .encoding='UTF-8'), silent=T)
Sys.setlocale('LC_CTYPE', bkp_ctype)
if(class(x) == 'try-error') {cat('no!!!!!!');return(NULL)}
uid <- gsub("^.*uniqueid\\\":\\\"(.+)\\\",.*$","\\1",xxx)
url <-  paste0("http://weibo.com/u/",uid)
url <- "http://weibo.com/2660243037/CqdqXpLUm?type=comment"
respo <- getURL(url, curl = cH)



