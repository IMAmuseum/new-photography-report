<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:common="http://exslt.org/common"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:key name="x" match="token" use="." />
    
    <xsl:template match="/a">
        <xsl:variable name="rtf">
            <xsl:for-each select="r">
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="string" select="m/mv[@c='KEYWORDS']"/>
                    <xsl:with-param name="delim" select="','"/>
                </xsl:call-template>
            </xsl:for-each>
        </xsl:variable>
        
        <xsl:for-each select="common:node-set($rtf)/token[generate-id() =
            generate-id(key('x', .)[1])]">
            <xsl:sort select="." />
            <xsl:value-of select="." /><xsl:text>&#x9;</xsl:text><xsl:value-of select="count(key('x',
                .))" /><xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
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
    
    
    <xsl:template match="a">
        <xsl:for-each select="r">
            <xsl:if test="m/mv/@c='KEYWORDS'">
                <xsl:variable name="KeywordValue"><xsl:value-of select="m/mv[@c='KEYWORDS']"/></xsl:variable>
                <xsl:value-of select="replace($KeywordValue, ',', '&#x9;')"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>