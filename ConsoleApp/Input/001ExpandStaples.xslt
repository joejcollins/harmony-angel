<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:cml="http://www.joejcollins.co.uk/CookBook/CookML.xsd"
                exclude-result-prefixes="msxsl cml">
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" indent="yes"/>

  <!-- 
    Copy everything that has no other pattern defined 
  -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="staples" />
    </xsl:copy>
  </xsl:template>
  <!--
		Expand the staples, first because they use the utensils
	-->
  <xsl:template name="staples" match="cml:Staple">
    <xsl:if test="@Name='cous cous'">
      In a
      <Utensil Name="pan" /> pour <Water Quantity="800" Unit="ml" Type="boiling water" />
      on <Grocery Quantity="400" Unit="g" Type="cous cous" />, cover and
      stand for 10 minutes.
    </xsl:if>
    <xsl:if test="@Name='noodles'">
      In a <Utensil Name="pan" />
      put
      <Grocery Quantity="400" Unit="g" Type="noodles" />,
      pour on
      <Water Quantity="800" Unit="ml" Type="boiling water" />
      cover and stand for 10 minutes, then drain.
    </xsl:if>
    <xsl:if test="@Name='pasta shapes'">
      In a <Utensil Name="pan" /> heat
      <Water Quantity="2000" Unit="ml" Type="cold water" /> then add
      <Grocery Quantity="450" Unit="g" Type="pasta shapes"/>
      boil for 12
      minutes then drain.
    </xsl:if>
    <xsl:if test="@Name='rice'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a
      <Utensil Name="pan" />
      boil
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity"><xsl:value-of select="($Meals div 2) * $Quantity" /></xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">white rice</xsl:attribute>
      </xsl:element>
      in
      <Water Quantity="800" Unit="ml" Type="boiling water" />
      then turn off, cover and stand for 30 minutes.
    </xsl:if>
    <xsl:if test="@Name='spaghetti'">
      In a <Utensil Name="pan" /> heat
      <Water Quantity="2000" Unit="ml" Type="cold water" /> then add
      <Grocery Quantity="450" Unit="g" Type="spaghetti"/>
      boil for 12
      minutes then drain.
    </xsl:if>
    <xsl:if test="@Name='potatoes'">
      Bake <Vegetable Process="washed" Quantity="1200" Type="baking potatoes" Unit="g" />
      medium for 40 minutes.
    </xsl:if>
    <xsl:if test="@Name='tagliatelli'">
      In a
    </xsl:if>
    <xsl:if test="@Name='tortellini'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a
      <Utensil Name="pan" />
      boil
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity"><xsl:value-of select="($Meals div 2) * $Quantity" /></xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">tortellini</xsl:attribute>
      </xsl:element>
      in
      <xsl:element name="Water">
        <xsl:variable name="Quantity" select="800" />
        <xsl:attribute name="Quantity"><xsl:value-of select="($Meals div 2) * $Quantity" /></xsl:attribute>
        <xsl:attribute name="Unit">ml</xsl:attribute>
        <xsl:attribute name="Type">boiling water</xsl:attribute>
      </xsl:element>
      boil for 5 minutes then drain.
    </xsl:if>
  </xsl:template>
  <!--
		Remove all the namespaces (to make it easier to read).  The namespace is really
    only there in the first place to get the editor to respond to the xsd.  After this
    point there will be no editing by hand anyway.
	-->
  <xsl:template match="*">
    <!-- remove element prefix (if any) -->
    <xsl:element name="{local-name()}">
      <!-- process attributes -->
      <xsl:for-each select="@*">
        <!-- remove attribute prefix (if any) -->
        <xsl:attribute name="{local-name()}">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
