<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cml="http://www.joejcollins.co.uk/CookBook/CookML.xsd" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:user="urn:my-scripts">
  <xsl:strip-space elements="*"/>

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
		  Winnow the vegetable shopping lists
	  -->
  <xsl:template match="Shopping">
    <xsl:copy>
      <!-- First Week Vegetables -->
      <xsl:if test="@Title = 'Vegetables'">
        
        <xsl:for-each select="Item">
          <xsl:if test="@MealCounter &lt; 8">
            <xsl:apply-templates select="."  />
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
      <!-- Second Week Vegetables -->
      <xsl:if test="@Title = 'Extra Vegetables'">
        
        <xsl:for-each select="Item">
          <xsl:if test="@MealCounter &gt; 7">
            <xsl:apply-templates select="."  />
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
      <!-- Other Groceries -->
      <xsl:if test="not(contains(@Title, 'Vegetables'))">
        <xsl:for-each select="Item">
          <xsl:apply-templates select="."  />
        </xsl:for-each>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="Item">
    <xsl:element name="Item">
      <xsl:attribute name="Type">
        <xsl:value-of select="@Type" />
      </xsl:attribute>
      <xsl:attribute name="Quantity">
        <xsl:value-of select="@Quantity" />
      </xsl:attribute>
      <xsl:attribute name="Unit">
        <xsl:value-of select="@Unit" />
      </xsl:attribute>
    </xsl:element>
  </xsl:template>


</xsl:stylesheet>
