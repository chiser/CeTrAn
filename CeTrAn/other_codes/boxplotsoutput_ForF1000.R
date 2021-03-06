whisker1 =F ## if put to true: whiskers will be 10 and 90% of data, if false whiskers are data in the 1.5 IQR as usual

require("ggplot2")
abc= c(1:8, rgb(202,100,20,maxColorValue = 255),rgb(100,0,200,maxColorValue = 255))

theme_jack <- function (base_size = 12, base_family = "") {
    theme_bw(base_size = base_size, base_family = base_family) %+replace%
        theme(
            #axis.text = element_text(colour = "white"),
            #axis.title.x = element_text(colour = "pink", size=rel(3)),
            #axis.title.y = element_text(colour = "blue", angle=45),
            #panel.background = element_rect(fill="green"),
            #panel.grid.minor.y = element_line(size=3),
            axis.text.x=element_text(size=10, colour = abc)
            ,panel.grid.major = element_line(colour = "grey")#,

           # plot.background = element_rect(fill="red")
           #,panel.grid = element_blank()
           ,panel.grid.major.x = element_blank()
           #,axis.text.x = element_text(angle=90, vjust=0)



    )
}
theme_set(theme_jack())

f <- function(x) {
  r <- quantile(x, probs = c(0.10, 0.25, 0.5, 0.75, 0.90))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}


data <- read.csv("~/output _table.csv")

## this code modify the name of the "other" variable
	levels(data$other)=c (levels(data$other),"2012", "2013")
	data$other[data$other=="2ndcross"]="2013"
	data$other[data$other=="1stcross"]="2012"
	data$other=droplevels(data$other)
##


p=ggplot(data, aes(x=factor(genotype),y= stripe_deviation.1, fill= other))
 if(whisker1){
  plot=p+ stat_summary(fun.data = f, geom="boxplot",position=position_dodge(1))	
 }else{
  plot=p+ geom_boxplot(position=position_dodge(0.9))
 }
 

 pdf("testing_boxplot_f1000.pdf")
 plot+ labs(x="genotype",y="stripe deviation [°]", fill="session",title="")+
 	ylim(0, max(data$stripe_deviation.1)+0.1)+
 	scale_fill_grey(start = 0.4, end = 1)+
	geom_hline(aes(yintercept=44), color="red")
 dev.off()