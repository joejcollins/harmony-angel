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
		  The vegetable shopping lists are duplicates so winnow out the 
      vegetables based on the MealCounter.  If the MealCounter is 7 
      or less then it is the first set of meals.  If the MealCounter
      is 8 or more then the vegetables are for the second set of 
      meals.
	  -->
  <xsl:template match="Shopping">
    <xsl:element name="Shopping">
      <xsl:attribute name="Title">
        <xsl:value-of select="@Title" />
      </xsl:attribute>
      <!-- First Week Vegetables -->
      <xsl:if test="@Title = 'Vegetables'">
        <xsl:for-each select="Item">
          <xsl:if test="@MealsCounter &lt; 8">
            <xsl:apply-templates select="."  />
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
      <!-- Second Week Vegetables -->
      <xsl:if test="@Title = 'Extra Vegetables'">
        <xsl:for-each select="Item">
          <xsl:if test="@MealsCounter &gt; 7">
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
    </xsl:element>
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
      <xsl:attribute name="Process">
        <xsl:value-of select="@Process" />
      </xsl:attribute>
      <xsl:attribute name="MealsLabel">
        <xsl:value-of select="@MealsLabel" />
      </xsl:attribute>
    </xsl:element>
  </xsl:template>


</xsl:stylesheet>
