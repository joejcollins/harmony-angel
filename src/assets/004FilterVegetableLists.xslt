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
	The vegetable shopping lists are duplicates so winnow out the 
  vegetables based on the MealCounter.  If the MealCounter is 7 
  or less then it is the first set of meals.  If the MealCounter
  is 8 or more then the vegetables are for the second set of 
  meals.
	  -->
  <xsl:template match="Shopping">
    <Shopping Title="{@Title}">
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
    </Shopping>
  </xsl:template>

  <!--
  Output each item
  -->
  <xsl:template match="Item">
    <xsl:copy>
      <xsl:copy-of select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
