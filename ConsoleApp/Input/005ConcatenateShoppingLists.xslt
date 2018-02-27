<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:strip-space elements="*"/>
  <!--
  Copy everything that has no other pattern defined 
  -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <!--
  Concatenate shopping lists, first by giving them all a key
	-->
  <xsl:key name="items-by-type" match="Item" use="@Type" />
  
  <xsl:template match="Shopping">
    <Shopping Title="{@Title}">
      
      
      <xsl:variable name="SumQuantity" />
      <xsl:for-each select="Item">
        <Item Type="{@Type}"  Unit="{@Unit}" MealsLabel="{@MealsLabel}">

        </Item>
        <xsl:variable name="CurrentType" select="@Type" />
        
        <xsl:choose>
          <xsl:when test="preceding-sibling::Item[@Type=$CurrentType]">
            <xsl:message>Current matches previous so add</xsl:message>
            <Quantity><xsl:value-of select="@Type"/></Quantity>
          </xsl:when>
          <xsl:otherwise>
            <xsl:message>Doesn't match previous don't add</xsl:message>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:message><xsl:value-of select="preceding-sibling::Item[1]/@Type" /> : <xsl:value-of select="@Type"/></xsl:message>

      </xsl:for-each>
    </Shopping>
  </xsl:template>

</xsl:stylesheet>
