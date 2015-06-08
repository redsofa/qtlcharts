Exploratory fork of [R/qtlcharts](http://kbroman.org/qtlcharts/). 

* Using Grunt to produce and install project artifacts.
* iplotMScanone modifications

From terminal :
--------------
- grunt build


From R : 
---------
- remove.packages("qtlcharts")
- devtools::install('/[Where_You_Checked_Out_Code]/dist/qtlcharts')

Test :
------
- See the ./src/tests/testmplotMScanOne.R file