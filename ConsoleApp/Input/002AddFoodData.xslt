<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ingredient="urn:Ingredient"
                xmlns:increment="urn:Increment">
  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>

  <!--
		  Format for the book
	  -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <!--
		  Reset the counter
	  -->
  <xsl:template match="Menu">
    <xsl:element name="Menu">
      <xsl:attribute name="Title">
        <xsl:value-of select="@Title" />
      </xsl:attribute>
      <xsl:variable name="reset" select="increment:Reset(0)" />
      <xsl:apply-templates select="Recipe" />
    </xsl:element>
  </xsl:template>
  
  <!-- 
		  Replace the Meals value with and incrementing value, then apply 
      any other templates.
	  -->
  <xsl:template match="Recipe">
    <xsl:copy>
      <xsl:attribute name="Title">
        <xsl:value-of select="@Title" />
      </xsl:attribute>
      <xsl:attribute name="Meals">
        <xsl:value-of select="@Meals" />
      </xsl:attribute>
      <xsl:attribute name="MealCounter">
        <xsl:value-of select="increment:Counter(@Meals)" />
      </xsl:attribute>
      <xsl:apply-templates />
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
