#import data from csv
setwd('C:/Users/Rolf/Desktop/Dropbox/Hughes committees')
df=read.csv('Fellows - Sheet1.csv')
df=df[1:max(which(as.character(df$Last)!='')),]
n=dim(df)[1]

disciplines=read.csv('Fellows - Sheet2.csv')

hierFields=as.character(disciplines[,1])

fields=unique(as.vector(c(as.character(df$Field),as.character(df$X.1),as.character(df$X.2),as.character(df$X.3),as.character(df$X.4),as.character(as.matrix(disciplines)))))
#remove whitespace
fields=fields[-which(fields=='')]
fields=fields[-which(is.na(fields))]
no=0;
links=c();
#make links between Fellows and their fields
for(i in 1:n){
	field=toString(df$Field[i]);
	id=which(fields==field);
	

	if(field!='')
		links=rbind(links,c(i-1,id-1+n,1))
	
	field=toString(df$X[i]);
	id2=which(fields==field);
	if(length(id2)>0)
		links=rbind(links,c(i-1,id2-1+n,1))
	
	field=toString(df$X.1[i]);
	id2=which(fields==field);
	if(length(id2)>0)
		links=rbind(links,c(i-1,id2-1+n,1))
	
	field=toString(df$X.2[i]);
	id2=which(fields==field);
	if(length(id2)>0)
		links=rbind(links,c(i-1,id2-1+n,1))
	
	field=toString(df$X.3[i]);
	id2=which(fields==field);
	if(length(id2)>0)
		links=rbind(links,c(i-1,id2-1+n,1))
	
	field=toString(df$X.4[i]);
	id2=which(fields==field);
	if(length(id2)>0)
		links=rbind(links,c(i-1,id2-1+n,1))
}



#make links between fields
fieldtype=rep(1,length(fields))#highlvl field?
nh=length(hierFields)
for(i in 1:nh){
	hf=hierFields[i]
	idhf=which(fields==hf)
	for(j in 2:dim(disciplines)[2]){
		field=toString(disciplines[i,j])
		if(field!=''){
			idf=which(fields==field)
			fieldtype[idf]=2#lower level
			if(length(idf)==0||length(idhf)==0)
				print(field)
			links=rbind(links,c(idhf-1+n,idf-1+n,2))
		}
	}
}

type=as.character(df$type)
type[type=='RF']=2
type[type=='']=1
type[type=='City']=3
isOfficer=as.numeric(df$officer!='')
isDOS=as.numeric(df$DOS!='')
isTutor=as.numeric(df$tutor!='')
isExtra=as.numeric(df$extra!='')

fellowding=cbind(paste(df$First,df$Last),as.character(df$officer),isDOS,isTutor,isExtra,as.character(df$DOS),
		as.character(df$extra),as.numeric(type),as.character(df$gender))
nodes=data.frame(rbind(fellowding,cbind(fields,'',0,0,0,0,'',fieldtype+5,'')))
names(nodes)=c('name','officer', 'isDOS', 'isTutor','isExtra','DOS','extra','type','gender')
nodes$isDOS=as.numeric(nodes$isDOS)-1
nodes$isTutor=as.numeric(nodes$isTutor)-1
nodes$isExtra=as.numeric(nodes$isExtra)-1
nodes$type=as.numeric(nodes$type)


links=data.frame(links)
names(links)=c('source','target','type')


#d3ForceNetwork(Links = links, Nodes = nodes,
#		Source = "source", Target = "target",
##		Value = "number", 
#		NodeID = "name",
#		Group = "type", width = 1000, height = 800, charge=-300,
#		opacity = 0.9,file='Fellows.html')
#
#
##export to JSON to copy paste to script
#library(rCharts)
#library(rjson)
#toJSONarray
#cat(toJSON(list(job_id = "1", 
#		page = "1", 
#		rows = lapply(seq(nrow(nodes)), function(x) list((nodes[x,]))))))

jsonstring=toJSON(lapply(seq(nrow(nodes)), function(x) list((nodes[x,]))))
nodeString = paste(paste('var nodes = [',gsub('\\[','',gsub(']','',jsonstring)),sep=''),'];',sep='')

jsonstring=toJSON(lapply(seq(nrow(links)), function(x) list((links[x,]))))
linkString= paste(paste('var links = [',gsub('\\[','',gsub(']','',jsonstring)),sep=''),'];',sep='')

cat(linkString,"\n",nodeString,file='fellowdata.txt')


