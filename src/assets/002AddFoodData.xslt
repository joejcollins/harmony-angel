<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ingredient="urn:Ingredient"
                xmlns:increment="urn:Increment">
  <xsl:output method="xml" omit-xml-declaration="no" indent="yes"/>
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
	Expand the utensils, this is in the second step so they can get added to 
  the expanded staples.
	-->
  <xsl:template match="Utensil">
    <xsl:if test="@Name='bowl'">mixing bowl</xsl:if>
    <xsl:if test="@Name='casserole'">casserole dish</xsl:if>
    <xsl:if test="@Name='frying'">frying pan</xsl:if>
    <xsl:if test="@Name='pan'">sauce pan</xsl:if>
    <xsl:if test="@Name='wok'">large wok</xsl:if>
  </xsl:template>

  <!--
  Reset the meal counter for each of the menus.  This is so that the 
  vegetable shopping list can be split between the first and second
  week.  The counter is provided by an extension function (increment).
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
      <xsl:variable name="MealsCounter" select="increment:Counter(@Meals)" />
      <xsl:attribute name="MealsCounter">
        <xsl:value-of select="$MealsCounter" />
      </xsl:attribute>
      <xsl:attribute name="MealsLabel">
        <xsl:choose>
          <xsl:when test="@Meals = 2">
            <xsl:value-of select="$MealsCounter - 1" />-<xsl:value-of select="$MealsCounter" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$MealsCounter" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>

  <!--
  Add the calorie and fat values to each ingredient so they can be summed
  later on.
  -->
  <xsl:template match="Check|Dairy|Grocery|Meat|Vegetable">
    <xsl:element name="{name(.)}">
      <!-- copy the other attributes -->
      <xsl:for-each select="@*">
        <xsl:attribute name="{name(.)}">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:for-each>
      <!-- add data attributes -->
      <xsl:attribute name="Calories">
        <xsl:value-of select="ingredient:PortionCalories(@Quantity, @Unit, @Name)"/>
      </xsl:attribute>
      <xsl:attribute name="Fat">
        <xsl:value-of select="ingredient:PortionFat(@Quantity, @Unit, @Name)"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
