

#
#
##try to download information on scholars
#library(scholar)	
##this package needs ids
#
#authornames=c("Rolf Ypma",'Jacco Wallinga')
#
#
#authornames=c("Rolf Ypma")
#stats=list()
#authFound=c();
#no=0;
#for(auth in authornames){
#
##find id
#ur <- searchCite(auth)
#
#rege=gregexpr(pattern ='=',ur)#find the location of '='
#id=substring(ur,rege[[1]][2]+1)
#no=no+1
#stats[[no]]=get_publications(id)
#
##save the author info
#authFound[[no]]=c(auth)
##derive all the coAuthors
#coAuth=c();
#for(i in 1:dim(stats[[no]])[1])
#	coAuth=c(coAuth,strsplit(toString(stats[[no]]$author[[i]]),',')[[1]])
#}
#
#for(auth in unique(coAuth)){
##find id	
#	ur <- searchCite(auth)
#	if(ur!=''){
#		rege=gregexpr(pattern ='=',ur)#find the location of '='
#		id=substring(ur,rege[[1]][2]+1)
#		no=no+1
#		stats[[no]]=get_publications(id)
#		authFound[[no]]=c(auth)
#	}	
#}
#
#
##make a list of all the publications and links to authors
#Nauth=length(authFound)
#publs=c()
#id=0;
#links=c();
#for(i in 1:Nauth){
#	for(j in 1:dim(stats[[i]])[1]){
##		already in db?
#		ti=toString(stats[[i]]$title[j])
##		first author?
#		val=which(strsplit(toString(stats[[i]]$author[[j]]),',')[[1]]==authFound[i])
#		
#		if(length(val)==1)
#		if(ti %in% publs[,1]){
#			#		establish link between author id and publ id
#			links=rbind(links,c(i,which(publs[,1]==ti),val))
#		}
#		else{
#			publs=rbind(publs,t(c(ti,toString(stats[[i]]$journal[j]),stats[[i]]$cites[j])))
#			id=id+1
#			#		establish link between author id and publ id
#			links=rbind(links,c(i,id,val))
#		}	
#
#	}
#}
#
##also make journals separate nodes
#journals=unique(publs[,2]);
#Njournal=length(journals)
#id=Nauth
#for(journ in journals){
#	id=id+1;
#	for(j in which(publs[,2]==journ))
#		links=rbind(links,c(id,j,6))
#}
#
##set authors to begin at 0
#links[,1]=links[,1]-1;
#links[,2]=links[,2]+Nauth+Njournal-1;
#links[,3]=7-links[,3]
#links=data.frame(links)
#nodes=data.frame(rbind(cbind(authFound,NA,NA,1),cbind(journals,NA,NA,2),cbind(publs,3)))
#
#names(nodes)=c('name','journal','cite','type')
#names(links)=c('source','target','number')
#test
#
#d3ForceNetwork(Links = links, Nodes = nodes,
#		Source = "source", Target = "target",
#		Value = "number", 
#		NodeID = "name",
#		Group = "type", width = 1000, height = 800, charge=-60,
#		opacity = 0.9,file='testAuth.html')
