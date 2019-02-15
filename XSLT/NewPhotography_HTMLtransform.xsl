<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com" xmlns:common="http://exslt.org/common">

    <xsl:output method="html" use-character-maps="control"/>

    <xsl:character-map
        name="control">
        <xsl:output-character character="&#146;" string="'"/>
    </xsl:character-map>
    
    <xsl:key name="x" match="token" use="." />

    <xsl:function name="functx:month-name-en" as="xs:string?" xmlns:functx="http://www.functx.com">
        <xsl:param name="date" as="xs:anyAtomicType?"/>
        <xsl:sequence
            select="
                ('January', 'February', 'March', 'April', 'May', 'June',
                'July', 'August', 'September', 'October', 'November', 'December')
                [month-from-date(xs:date($date))]
                "/>

    </xsl:function>
    <xsl:template match="/">
        <xsl:apply-templates select="a"/>
    </xsl:template>

    <xsl:template match="a">
        <html>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
            <style>
                body{
                    background-color: white;
                    padding: 20px;
                }
                h1{
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    font-size: 28px;
                    font-style: normal;
                    font-variant: normal;
                    font-weight: 750;
                    line-height: 26.4px;
                }
                h2{
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    font-size: 18px;
                    font-style: normal;
                    font-variant: normal;
                    font-weight: 500;
                    line-height: 15.4px;
                }
                h3{
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    font-size: 22px;
                    font-style: normal;
                    font-variant: normal;
                    font-weight: 750;
                    line-height: 15.4px;
                    padding-top: 30px;
                }
                p{
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    font-size: 18px;
                    font-style: normal;
                    font-variant: normal;
                    font-weight: 400;
                    line-height: 20px;
                }
                #table1{
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    font-size: 14px;
                    font-style: normal;
                    font-variant: normal;
                    font-weight: 400;
                    line-height: 20px;
                    border: 2px solid black;
                }
                #table1 tr:nth-child(odd){
                    background-color: #DCDCDC;
                }
                #table2{
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    font-size: 18px;
                    font-style: normal;
                    font-variant: normal;
                    font-weight: 500;
                    line-height: 20px;
                    border: 2px solid black;
                }
                #table2 tr:nth-child(odd){
                    background-color: #DCDCDC;
                }
                th{
                    background-color: #e45944;
                    text-align: center;
                }
                td{
                    padding: 2px;
                }
                #totals{
                    background-color: #4491c9;
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    color: white;
                    font-size: 20px;
                    font-style: normal;
                    font-variant: normal;
                    font-weight: 500;
                    line-height: 40px;
                    border: 2px solid black;
                    padding: 20px;
                    margin: 30px 20px 0px 20px;
                }
                .number{
                    font-family: Tahoma, Verdana, Segoe, sans-serif;
                    color: black;
                    font-size: 35px;
                    line-height: 40px;
                    font-weight: 600;
					padding: 10px; 15px; 15px; 15px;
                }
                img{
                    max-width: 100%;
                    height: auto;
                    align: center;
                }
            </style>
            <head>
                <title>Newfields New Photography Report</title>
            </head>
            <div class="container-fluid">
            <body>
                <center>
                    <img src="https://discovernewfields.org/application/files/4415/2324/0911/Newfields_MainLogo_Tag_Blk.jpg"
                        alt="Newfields Logo" width="150"/>
                    <h1>Newfields New Photography Report</h1>
                    <h2>New photography added to Piction in the week ending Friday, <xsl:value-of
                            select="
                                functx:month-name-en(
                                xs:dateTime(current-date()))"
                            /><xsl:text> </xsl:text><xsl:value-of
                            select="substring-before(./s/d, '-')"
                            /><xsl:text>, </xsl:text><xsl:value-of
                            select="
                                year-from-dateTime(
                                xs:dateTime(current-date()))"
                        /></h2>
                </center>
                
                    <div class="row" id="totals">
                        <div class="col-md-4">
                            <b>Collection Primary Images: </b><span class="number"><xsl:value-of select="count(r/d/@f[contains(., '_v')][ends-with(., '.jpg')])"/></span>
                        </div>
                        <div class="col-md-4">
                            <b>Collection Detail Images: </b><span class="number"><xsl:value-of select="count(r/d/@f[contains(., '_d')][ends-with(., '.jpg')])"/></span>
                        </div>
                        <div class="col-md-4">
                            <b>Non-Collection Images: </b><span class="number"><xsl:value-of select="count(r/d[contains(., 'noncollections')][contains(
                                translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '.tif')])"/></span>
                        </div>
                    </div>
                
                <xsl:if test="count(r/d/@f[contains(., '_v')][ends-with(., '.jpg')]) &gt; 0">                
                <h3>New Collections Primary Photography</h3>
                <table class="table table-bordered table-striped" id="table1" style="width:100%">
                    <tr>
                        <th style="width:8%">Accession Number</th>
                        <th style="width:10%">Title</th> 
                        <th style="width:27%">Creator(s)</th>
                        <th style="width:6%">Date</th>
                        <th style="width:25%">Credit Line</th>
                        <th style="width:7%">Rights</th>
                        <th style="width:9%">Department</th>
                        <th style="width:8%">Upload Date</th>
                    </tr>
                <xsl:for-each select="r">
                    <xsl:if test="contains(d/@f, '_v01_t.jpg')">
                        <xsl:variable name="Creator">
                            <xsl:choose>
                                <xsl:when test="m/mv[@c='CRECREATORREF_TAB']!=''"><xsl:value-of select="replace(m/mv[@c='CRECREATORREF_TAB'][1], '\|\|', '---')"/>
                                </xsl:when>
                                <xsl:when test="m/mv[@c='CRECREATORATTRIBUTION_TAB']!=''"><xsl:value-of select="replace(m/mv[@c='CRECREATORATTRIBUTION_TAB'], '\|\|', '---')"/>
                                </xsl:when>
                                <xsl:when test="m/mv[@c='CRECREATIONCULTUREORPEOPLE_TAB']!=''"><xsl:value-of select="replace(m/mv[@c='CRECREATIONCULTUREORPEOPLE_TAB'], '\|\|', '---')"/>
                                </xsl:when>
                                <xsl:otherwise>undefined</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                    <tr>
                        <td><xsl:value-of select="m/mv[@c='TITACCESSIONNO']"/></td>
                        <td><xsl:value-of select="m/mv[@c='TITMAINTITLE']"/></td> 
                        <td><xsl:value-of select="$Creator"/></td>
                        <td><xsl:value-of select="m/mv[@c='CREDATECREATED']"/></td>
                        <td><xsl:value-of select="m/mv[@c='SUMCREDITLINE']"/></td>
                        <td><xsl:value-of select="m/mv[@c='RIGACKNOWLEDGEMENT']"/></td>
                        <td><xsl:value-of select="substring-after(m/mv[@c='PHYCOLLECTIONAREA'], '-')"/></td>
                        <td><xsl:value-of select="substring-before(m/mv[1]/@dc, ' ')"/></td>
                    </tr>
                    </xsl:if>
                </xsl:for-each>
                </table>
                <h2><xsl:element name="a">
                    <xsl:attribute name="href">NewPhotography_IRNs_<xsl:value-of select="format-dateTime(current-dateTime(),'[Y]-[M]-[D]')"/>.csv</xsl:attribute>List of IRNs
                </xsl:element></h2>
                </xsl:if>
                
                <xsl:if test="count(r/d[contains(., 'noncollections')][contains(
                    translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '.tif')]) &gt; 0">
                <h3>New Non-Collection Photography</h3>
                    <xsl:variable name="Keywords">
                        <xsl:for-each select="r">
                            <xsl:value-of select="m/mv[@c='KEYWORDS']"/>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$Keywords != ''">
                <div class="row">
                    <div class="col-md-8">
                        <xsl:element name="img">
                            <xsl:attribute name="class">img-fluid</xsl:attribute>
                            <xsl:attribute name="src">NewPhotography_WordCloud_<xsl:value-of select="format-dateTime(current-dateTime(),'[Y]-[M]-[D]')"/>.png</xsl:attribute>
                        </xsl:element>
                    </div>
                    <div class="col-md-4">
                <table class="table table-bordered table-striped" id="table2">
                    <tr>
                        <th>Keyword</th>
                        <th>Number of Images</th>
                    </tr>
                <xsl:variable name="rtf">
                    <xsl:for-each select="r">
                        <xsl:if test="contains(
                            translate(n, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '.tif')">
                        <xsl:if test="m/mv[@c='KEYWORDS']!=''">
                        <xsl:call-template name="tokenize">
                            <xsl:with-param name="string" select="m/mv[@c='KEYWORDS']"/>
                            <xsl:with-param name="delim" select="','"/>
                        </xsl:call-template>
                        </xsl:if>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:variable>
                
                <xsl:for-each select="common:node-set($rtf)/token[generate-id() =
                    generate-id(key('x', .)[1])]">
                    <xsl:sort select="count(key('x', .))" order="descending"/>
                    <xsl:sort select="."/>
                    <tr>
                        <td><xsl:value-of select="." /></td>
                        <td><xsl:value-of select="count(key('x', .))" /></td>
                    </tr>
                </xsl:for-each>
                </table>
                    </div>
                </div>
                    </xsl:when>
                    <xsl:otherwise>
                        <div class="row">
                            <div class="col-md-4">
                                <table class="table table-bordered table-striped" id="table2">
                                    <tr>
                                        <th>Keyword</th>
                                        <th>Number of Images</th>
                                    </tr>
                                </table>
                                <p>No keywords associated with new non-collection photography.</p>
                            </div>
                        </div>
                    </xsl:otherwise>
                </xsl:choose>
                </xsl:if>
            </body>
            </div>
        </html>
    </xsl:template>
    
    <xsl:template name="tokenize">
        <xsl:param name="string" />
        <xsl:param name="delim" />
        
        <xsl:choose>
            <xsl:when test="contains($string, $delim)">
                <token><xsl:value-of select="substring-before($string, $delim)" /></token>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="string" select="substring-after($string,
                        $delim)" />
                    <xsl:with-param name="delim" select="$delim" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <token><xsl:value-of select="$string" /></token>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
