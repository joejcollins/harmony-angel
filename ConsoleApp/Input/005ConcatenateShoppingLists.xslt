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
  Add up the shopping list items and concatenate the meal labels,
  so the shopping lists are slightly shorter.
	-->
  <xsl:key name="items-by-type" match="Item" use="@Type" />
  
  <xsl:template match="Shopping">
    <Shopping Title="{@Title}">
      <xsl:for-each select="Item">
        <xsl:variable name="key" select="@Type" />
        <xsl:if test="not(preceding-sibling::Item[@Type=$key])">
          <Item Type="{@Type}"  Unit="{@Unit}">
            <xsl:for-each select="../Item[@Type=$key]">
              <Quantity>
                <xsl:value-of select="@Quantity"/>
              </Quantity>
              <MealsLabel>
                <xsl:value-of select="@MealsLabel"/>
              </MealsLabel>
            </xsl:for-each>
          </Item>
        </xsl:if>
      </xsl:for-each>
    </Shopping>
  </xsl:template>

</xsl:stylesheet>
