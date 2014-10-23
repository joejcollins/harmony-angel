<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ingredient="urn:Ingredient">
  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
  <!-- 
    Copy everything that has no other pattern defined 
  -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <!--
    Add the calorie and fat values to each ingredient
  -->
  <xsl:template match="Check|Dairy|Grocery|Meat|Vegetable|Water">
    <xsl:element name="{name(.)}">
      <xsl:for-each select="@*">
        <xsl:attribute name="Calories">
          <xsl:value-of select="ingredient:Calories(../@Quantity, ../@Type, ../@Unit)"/>
        </xsl:attribute>
        <xsl:attribute name="Fat">
          <xsl:value-of select="ingredient:Fat(../@Quantity, ../@Type, ../@Unit)"/>
        </xsl:attribute>
        <xsl:attribute name="{name(.)}">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
