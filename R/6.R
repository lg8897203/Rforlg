r <- seq(0,5,0.5)
x <- seq(0,1,0.05)
SPIA <- function(x, r, y=0.6, a=4, h=5) {
S1 <- (54+105*x+41*x^2-10*x^3)*y/(6*r*(1+x)*(27+27*x-4*x^2))
S2 <- (162+495*x+496*x^2+155*x^3-8*x^4)*y*a/(2*h*r*(1+x)*(27+27*x-4*x^2)^2-2*y^2*(162+495*x+496*x^2+155*x^3-8*x^4))
P1 <- (9+15*x)*h/(9*(1+x))
P2 <- (9+11*x)*a/(27+27*x-4*x^2)
P3 <- (9+11*x)*y*2*S2/(27+27*x-4*x^2)
PA1 <- P1+P2+P3
PB1 <- P1-P2-P3
PA2 <- (3*h+a+y*2*S2+x*(PA1-PB1))/(3*(1+x))
PB2 <- (3*h-a-y*2*S2-x*(PA1-PB1))/(3*(1+x))
PA1*(PB1-PA1+y*2*S2+a+h)/(2*h)+PA2*((y*2*S2+a+h)/(2*h)+(1+x)*(PB2-PA2)/(2*h)-x*(PB1-PA1)/(2*h))-r*(S1+S2)^2
}

r <- seq(0,5,0.5)
x <- seq(0,1,0.05)
PPIA <- function(x, r, y=0.6, a=4, h=5) {
PA <- h+(h*r*a)/(3*h*r-y^2*x^2-y^2)
PB <- h-(h*r*a)/(3*h*r-y^2*x^2-y^2)
S2 <- ((1+x)*y)/(2*h*r)
S1 <- ((1-x)*y)/(2*h*r)
SA1 <- S1*PA
SA2 <- S2*PA
SB1 <- S1*PB
SB2 <- S2*PB
DA <- (1/h)*(h+(h*r*a)/(3*h*r-y^2*x^2-y^2))

PA*DA-(r/2)*(SA1^2+SA2^2)
}
z <- outer(x,r,SPIA)
v <- outer(x,r,PPIA)

persp(x,r,z,theta=0,phi=0,expand=1,col="blue",xlab = " ", ylab = " ", zlab = " ")
par(new=TRUE)
persp(x,r,v,theta=0,phi=0,expand=1,col="red",xlab = "¦È", ylab = "¦Á", zlab = "¦Ð", ticktype = "detailed")



