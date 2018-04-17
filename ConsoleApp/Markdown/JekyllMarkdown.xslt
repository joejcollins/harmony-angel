<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="msxsl" 
                xmlns:file="urn:File">
  <xsl:strip-space elements="*"/>
  <xsl:output omit-xml-declaration="yes" method="text" media-type="text/plain" indent="no"  />
  <!--
  Global parameter
  -->	
	<xsl:param name="MealCount" select="0" />

	<!--
	Format for the book, and introduction
	-->
	<xsl:template match="Book">
---
layout: default
title: Home
---
    <xsl:for-each select="Menu" >
      <xsl:value-of select="file:Write(concat('../docs/', @Title, '.md'), 'content')"/>
    </xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
