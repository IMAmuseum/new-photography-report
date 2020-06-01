<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="a">set PictionCall=https://digitalmedia.imamuseum.org/r/st/IQ/SURL/<xsl:value-of select="SURL"/>/SEARCH/AGE:"53"/LIMIT/PHOTO/METADATA/ALL/MAXROWS/5000

set Date=<xsl:value-of select="format-dateTime(current-dateTime(),'[Y]-[M]-[D]')"/>
    </xsl:template>
</xsl:stylesheet>