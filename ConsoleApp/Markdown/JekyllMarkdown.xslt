<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="msxsl">
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
    % !TeX root = FoodFile.tex
    % Content Begins
    <xsl:for-each select="Menu" >
    <xsl:result-document method="xml" href="file_{@id}-output.xml" >
      <xsl:copy-of select="."/>
    </xsl:result-document>
  </xsl:for-each>
    % Content Ends
	</xsl:template>

</xsl:stylesheet>
