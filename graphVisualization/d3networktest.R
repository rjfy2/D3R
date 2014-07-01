library(d3Network)

setwd('C:/Users/Rolf/Desktop/New folder')

#subjects
disciplines=cbind(rbind('Math','Bio','Law','Medicine'),c('m','b','l','med'))
Nd=dim(disciplines)[1]
#specify the authors
authors=cbind(rbind('Joe','Henk','Sarah'),c('j','h','s'))
# publications, and the author id, subject
publications=(cbind(matrix(1:100,100),rbind(matrix('j',40),matrix('h',10),matrix('s',50)),disciplines[ceiling(runif(100,0,Nd)),2]))





#make the nodes: authors, publications, disciplines
nodes=data.frame(rbind(as.matrix(authors[,1]),as.matrix(disciplines[,1]),as.matrix(publications[,1])))
Na=dim(authors)[1]

Np=dim(publications)[1]

#what kind of nodes?
nodes=cbind(nodes,matrix(1,Na+Np+Nd))
nodes[(Na+1):(Na+Nd),2]='Discipline';
nodes[(Na++Nd+1):(Na+Nd+Np),2]='Publication';

#make links
links=c();
for(i in 1:Np){
#	find corresponding author
	no=which(authors[,2]==publications[i,2]);
	links=rbind(links,c(Na+Nd+i-1,no-1))
#	find corresponding field
	no=which(disciplines[,2]==publications[i,3]);
	links=rbind(links,c(Na+Nd+i-1,Na+no-1))
}

nodes=data.frame(nodes)
names(nodes)=c('name','group')

#links=links[1:4,]
#links=rbind(links,c(4,1))
links=data.frame(links)
names(links)=c('source','target')

d3ForceNetwork(Links = links, Nodes = nodes,
		Source = "source", Target = "target",
#		Value = "value", 
		NodeID = "name",
		Group = "group", width = 550, height = 400,
		opacity = 0.9,file='test4.html')

## Load RCurl package for downloading the data
#library(RCurl)
#
## Gather raw JSON formatted data
#URL <- "https://raw.githubusercontent.com/christophergandrud/d3Network/master/JSONdata/miserables.json"
#MisJson <- getURL(URL, ssl.verifypeer = FALSE)
#
## Convert JSON arrays into data frames
#MisLinks <- JSONtoDF(jsonStr = MisJson, array = "links")
#MisNodes <- JSONtoDF(jsonStr = MisJson, array = "nodes")
#d3ForceNetwork(Links = MisLinks, Nodes = MisNodes,
#		Source = "source", Target = "target",
#		Value = "value", NodeID = "name",
#		Group = "group", width = 550, height = 400,
#		opacity = 0.9)
