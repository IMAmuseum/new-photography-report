@ECHO ON

REM change directory to C:\new-photography-report
cd C:\new-photography-report

REM set Piction username and password as variables
call settings.cmd

REM move existing CurrentReport directory to PastReports
move CurrentReport PastReports

REM create new "CurrentReport" folder in C:\NewPhotographyReport, with CollectionImages subfolder
mkdir CurrentReport
mkdir CurrentReport\CollectionImages

REM cURL GET call to Piction API for session verification, output as XML\SURL.xml
curl --insecure https://digitalmedia.imamuseum.org/r/st//piction_login/USERNAME/%username%/PASSWORD/%password% -o "XML\SURL.xml"

REM call saxon to run XSLT\SURLtransform.xsl on XML\SURL.xml to update CMD\PictionCall.cmd
java -jar C:\saxon\saxon-he-11.4.jar -s:XML\SURL.xml -xsl:XSLT\NewPhotography_SURLtransform.xsl -o:CMD\PictionCall.cmd

REM run PictionCall.cmd to set %PictionCall% and %Date% variables
call CMD\PictionCall.cmd

REM cURL GET call to Piction API to retrieve 7 days of new photography metadata, output as CurrentReport\NewPhotographyOutput_%Date%.xml
curl --insecure %PictionCall% -o "CurrentReport\NewPhotographyOutput_%Date%.xml"

REM call saxon to run XSLT\NewPhotography_HTMLtransform.xsl on CurrentReport\NewPhotographyOutput_%Date%.xml, output as CurrentReport\NewPhototgraphyReport_%Date%
java -jar C:\saxon\saxon-he-11.4.jar -s:CurrentReport\NewPhotographyOutput_%Date%.xml -xsl:XSLT\NewPhotography_HTMLtransform.xsl -o:CurrentReport\NewPhotographyReport_%Date%.html

REM call saxon to run XSLT\NewPhotography_IRNlistTransform.xsl on CurrentReport\NewPhototgraphyOutput_%Date%.xml, output as CurrentReport\NewPhotography_IRNs_%Date%.csv
java -jar C:\saxon\saxon-he-11.4.jar -s:CurrentReport\NewPhotographyOutput_%Date%.xml -xsl:XSLT\NewPhotography_IRNlistTransform.xsl -o:CurrentReport\NewPhotography_IRNs_%Date%.csv

REM call saxon to run XSLT\NewPhotography_KeywordTransform.xsl on CurrentReport\NewPhotographyOutput_%Date%.xml, output as CurrentReport\NewPhotography_Keywords_%Date%.txt
java -jar C:\saxon\saxon-he-11.4.jar -s:CurrentReport\NewPhotographyOutput_%Date%.xml -xsl:XSLT\NewPhotography_KeywordTransform.xsl -o:CurrentReport\NewPhotography_Keywords_%Date%.txt

REM generate word cloud and save as CurrentReport\NewPhotography_WordCloud_%Date%.png
java -jar ibm-word-cloud.jar -c IBMconfig.txt -w 1600 -h 1600 -i CurrentReport\NewPhotography_Keywords_%Date%.txt > CurrentReport\NewPhotography_WordCloud_%Date%.png

REM call saxon to run XSLT\NewPhotography_ImageURLtransform.xsl on CurrentReport\NewPhotographyOutput_%Date%.xml, output as CMD\DownloadImages.cmd
java -jar C:\saxon\saxon-he-11.4.jar -s:CurrentReport\NewPhotographyOutput_%Date%.xml -xsl:XSLT\NewPhotography_ImageURLtransform.xsl -o:CMD\DownloadImages.cmd

REM change directory to CurrentReport
cd CurrentReport

REM create PDF version of HTML page
wkhtmltopdf NewPhotographyReport_%Date%.html NewPhotographyReport_%Date%.pdf

REM change directory to CollectionImages
cd CollectionImages

REM call DownloadImages.cmd to initiate download of all collection primary images
call C:\new-photography-report\CMD\DownloadImages.cmd

REM change directory to new-photography-report\PastReports
cd C:\new-photography-report\PastReports

REM rename CurrentReport to 
Rename CurrentReport NewPhotographyReport_expired_%Date%
