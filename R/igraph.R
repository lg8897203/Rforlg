library(igraph)

g <- graph(c(0,1, 0,2, 1,3, 0,3), directed=T)

g1 <- graph.full(4)
g1

m <- matrix(runif(4*4), nrow=4)
m

g <- graph.adjacency(m > 0.5)
g

plot(g, layout=layout.fruchterman.reingold)



d <- c(0, 1, 10, 110)
d[,2]

z<-1:12
dim(z)<- c(3,4)
z
z[,2]


rc <- read.csv("C:\\Users\\alienware\\Desktop\\R\\appskai [Edges].csv")

t <- rc[c(1,2)]

gg = graph.data.frame(d = t, directed = T)

par(mar = c(0, 0, 0, 0))
set.seed(14)
plot(gg, layout = layout.fruchterman.reingold, vertex.size = 5, vertex.label = NA,
    edge.color = grey(0.5), edge.arrow.mode = "-")




1:10 %in% c(1,3,5,9)

df<-data.frame(
        Name=c("Alice", "Becka", "James", "Jeffrey", "John"), 
        Sex=c("F", "F", "M", "M", "M"), 
        Age=c(13, 13, 12, 13, 12),
        Height=c(56.5, 65.3, 57.3, 62.5, 59.0),
        Weight=c(84.0, 98.0, 83.0, 84.0, 99.5)
); df

tmp1 = df[df[,3] == "13",]
tmp1

tmp2 = df[(df[,2] == "M")&(df[,4] %in% tmp1[,4]), c(2,4)]
tmp2

people = data.frame(id = tmp1[, 4], name = tmp1[, 3])
people

?plot
