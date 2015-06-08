Exploratory fork of [R/qtlcharts](http://kbroman.org/qtlcharts/). 

* Using Grunt to produce and install project artifacts.
* iplotMScanone modifications

From terminal :
--------------
- grunt build


From R : 
---------
- remove.packages("qtlcharts")
- devtools::install('/home/richardr/dev/git/qtlcharts/dist/qtlcharts')

Test :
------
library(qtlcharts)
data(grav)
library(qtl)
grav <- calc.genoprob(grav, step=1)
grav <- reduce2grid(grav)

# we're going to subset the phenotypes
phecol <- seq(1, nphe(grav), by=5)

# the times were saved as an attributed
times <- attr(grav, "time")[phecol]

# genome scan
out <- scanone(grav, phe=phecol, method="hk")


# plot with qualitative labels on y-axis
mplotMScanone(out)


# plot with quantitative y-axis
mplotMScanone(out, times=times)


# plot with QTL effects included (and with quantitative y-axis)
plot <- mplotMScanone(out, times=times,
              chartOpts=list(eff_ylab="QTL effect", eff_xlab="Time (hrs)"))