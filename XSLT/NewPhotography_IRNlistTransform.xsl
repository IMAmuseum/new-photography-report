<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text"/>
    
    <xsl:template match="/a">
        <xsl:for-each select="distinct-values(r/m/mv[@c='IRN'])">
<xsl:value-of select="."/><xsl:text>,
</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>