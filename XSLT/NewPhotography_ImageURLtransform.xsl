<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:template match="a">
@echo OFF
<xsl:for-each select="r">
    <xsl:if test="contains(
        translate(n, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '_v01') and starts-with(translate(n, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'ps_') and ends-with(translate(n, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '.jpg')">wget --no-check-certificate --output-document=<xsl:value-of select="substring-after(o[1]/@u, 'PS_')"/> "https://digitalmedia.imamuseum.org/piction/<xsl:value-of select="o[1]/@u"/>"<xsl:text>&#xa;</xsl:text> 
                </xsl:if>
            </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>