y <- seq(0,1,0.05)
x <- seq(0,1,0.05)
SPIA <- function(x, y, r=1, a=0, h=5) {
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

SPIA2 <- function(x, y, r=1, a=4, h=5) {
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
z <- outer(x,y,SPIA)
w <- outer(x,y,SPIA2)

persp(x,y,z,theta=0,phi=0,expand=1,col="blue")
par(new=TRUE)
persp(x,y,w,theta=0,phi=0,expand=1,col="red")


y <- seq(0,1,0.05)
x <- seq(0,1,0.05)
PPIA <- function(x, y, r=1, a=0, h=5) {
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
v <- outer(x,y,SPIA)
persp(x,y,v,theta=0,phi=0,expand=1,col="blue")



















x <- seq(-10, 10, length= 30)
y <- x
f <- function(x,y) { r <- sqrt(x^2+y^2); 10 * sin(r)/r }
z <- outer(x, y, f)
z[is.na(z)] <- 1
op <- par(bg = "white")
persp(x, y, z, theta = 30, phi = 30, expand = 0.5, col = "blue",
      ltheta = 120, shade = 0.75, ticktype = "detailed",
      xlab = "X", ylab = "Y", zlab = "Sinc( r )"
) -> res
round(res, 3)


xE <- c(-10,10); xy <- expand.grid(xE, xE)
points(trans3d(xy[,1], xy[,2], 6, pmat = res), col = 2, pch =16)
lines (trans3d(x, y=10, z= 6 + sin(x), pmat = res), col = 3)

phi <- seq(0, 2*pi, len = 201)
r1 &lt;- 7.725 # radius of 2nd maximum[第二个最大的半径]
xr <- r1 * cos(phi)
yr <- r1 * sin(phi)
lines(trans3d(xr,yr, f(xr,yr), res), col = "pink", lwd = 2)