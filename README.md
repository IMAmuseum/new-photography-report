# Piction New Photography Report

This repository contains a Windows batch file (new-photography-report.cmd) which automates the creation of weekly reports of new photography at the Indianapolis Museum of Art at Newfields. The batch file triggers the following steps:

* file and subdirectory management
* query to Piction (digital asset management system) API to verify session credentials
* query to Piction API to return all metadata about images added to the system within the past 7 days
* XSLT transformation of session identifier and image metadata XML returns from the Piction API
* creation of HTML report file and component parts:
	* CSV list of item IRNs (Newfields' collection management system unique identifiers)
	* IBM Word Cloud Generator keywords .txt file
	* PNG word cloud
* XSLT transformation of image metadata return to output collection image download command
* calling image download command to download low resolution primary collection images for Registration to load into EMu

## Dependencies

The Piction New Photography Report requires the Java Runtime Environment (https://www.oracle.com/technetwork/java/javase/downloads/index.html), curl (https://curl.haxx.se/), and SAXON XSLT Processor (http://saxon.sourceforge.net/) be installed on the Windows machine and accessible from the command line. Follow the installation instructions at the above links. Be sure to set the JAVA_HOME environment variable to the installed version of JRE.

To test installation of these application from a terminal window, confirm that the curl and Saxon applications' help lists can be retrieved:

	curl --help
	java -jar C:\saxon\saxon9he.jar

*NOTE: This application was written with saxon9he.jar as the active version of Saxon. If your Windows machine has a different version, the two Saxon commands in new-photography-report.cmd need to be modified to reflect the version of Saxon installed on your machine.*

This report also requires the IBM Word Cloud Generator (https://www.softpedia.com/get/Office-tools/Other-Office-Tools/IBM-Word-Cloud-Generator.shtml) be installed in the main new-photography-report folder, stored in the folder "IBM World Cloud." The following related files should be stored in the primary new-photography-report folder:

* ibm-word-cloud.jar
* IBMconfig.txt

See the IBMconfig.txt file in this repository for an example of possible word cloud settings.

## Installation

The Piction New Photography Report batch file has been designed to run on a Windows machine from C:\new-photography-report.

From the terminal:

	cd C:\
	git clone https://github.com/IMAmuseum/new-photography-report.git .\new-photography-report

## Settings

The Piction New Photography Report batch process requires a settings file, settings.cmd, in the main application directory. This file is called while running the application to set the Piction username and password for retrieving data and image assets. This file should contain:

	set username=[USERNAME]
	set password=[PASSWORD]

