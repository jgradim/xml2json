<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="no" omit-xml-declaration="yes" method="text" encoding="UTF-8" media-type="text/x-json"/>
  <xsl:strip-space elements="*" />
  
  <xsl:template match="*">
    <xsl:if test="not(preceding-sibling::*)">{</xsl:if>
    <xsl:text>"</xsl:text><xsl:value-of select="name()" /><xsl:text>": </xsl:text>
    
    <xsl:apply-templates select="child::node()" />
    
    <!-- close object or separate object attributes -->
    <xsl:if test="following-sibling::*">,</xsl:if>
    <xsl:if test="not(following-sibling::*)">}</xsl:if>
  </xsl:template>
  
  <!-- treat text values -->
  <xsl:template match="text()">
    <xsl:choose>
      <xsl:when test="string(number(.)) = 'NaN'"><!-- string, escape and quote -->
        <xsl:text>"</xsl:text><xsl:value-of select="normalize-space(.)" /><xsl:text>"</xsl:text>
      </xsl:when>
      <xsl:otherwise><!-- number, print as it is -->    
        <xsl:value-of select="normalize-space(.)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
