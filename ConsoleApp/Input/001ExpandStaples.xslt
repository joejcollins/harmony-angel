<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:cml="https://joejcollins.github.io/CookML.xsd"
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
    <!-- Couscous -->
    <xsl:if test="@Name='couscous'">
      In a
      <Utensil Name="pan" /> pour <Water Quantity="800" Unit="ml" Type="boiling water" />
      on <Grocery Quantity="400" Unit="g" Type="cous cous" />, cover and
      stand for 10 minutes.
    </xsl:if>
    <!-- Noodles -->
    <xsl:if test="@Name='noodles'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a <Utensil Name="pan" />
      put
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">noodles</xsl:attribute>
      </xsl:element>
      pour on
      <xsl:element name="Water">
        <xsl:variable name="Quantity" select="800" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">ml</xsl:attribute>
        <xsl:attribute name="Type">boiling water</xsl:attribute>
      </xsl:element>
      cover and stand for 10 minutes, then drain.
    </xsl:if>
    <xsl:if test="@Name='pasta shapes'">
      In a <Utensil Name="pan" /> heat
      <Water Quantity="2000" Unit="ml" Type="cold water" /> then add
      <Grocery Quantity="400" Unit="g" Type="pasta shapes"/>
      boil for 12
      minutes then drain.
    </xsl:if>
    <!-- Rice -->
    <xsl:if test="@Name='rice white'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a
      <Utensil Name="pan" />
      put
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">white rice</xsl:attribute>
      </xsl:element>
      and
      <xsl:element name="Water">
        <xsl:variable name="Quantity" select="800" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">ml</xsl:attribute>
        <xsl:attribute name="Type">cold water</xsl:attribute>
      </xsl:element>
      bring to the boil then turn off, cover and stand for 25 minutes.
    </xsl:if>
    <xsl:if test="@Name='rice brown'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a
      <Utensil Name="pan" />
      put
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">brown rice</xsl:attribute>
      </xsl:element>
      and
      <xsl:element name="Water">
        <xsl:variable name="Quantity" select="800" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">ml</xsl:attribute>
        <xsl:attribute name="Type">cold water</xsl:attribute>
      </xsl:element>
      bring to the boil then simmer for 15 minutes,
      then cover and stand for 10 minutes.
    </xsl:if>
    <xsl:if test="@Name='rice turmeric'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a
      <Utensil Name="pan" />
      put
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">white rice</xsl:attribute>
      </xsl:element>,
      <xsl:element name="Check">
        <xsl:variable name="Quantity" select="1" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">tsp</xsl:attribute>
        <xsl:attribute name="Type">ground turmeric</xsl:attribute>
      </xsl:element>,
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="50" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">raisins</xsl:attribute>
      </xsl:element>
      and
      <xsl:element name="Water">
        <xsl:variable name="Quantity" select="800" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">ml</xsl:attribute>
        <xsl:attribute name="Type">cold water</xsl:attribute>
      </xsl:element>
      bring to the boil then simmer for 15 minutes,
      then cover and stand for 10 minutes.
    </xsl:if>
    <!-- Spaghetti -->
    <xsl:if test="@Name='spaghetti'">
      In a <Utensil Name="pan" /> heat
      <Water Quantity="2000" Unit="ml" Type="cold water" /> then add
      <Grocery Quantity="450" Unit="g" Type="spaghetti"/>
      boil for 12
      minutes then drain.
    </xsl:if>
    <xsl:if test="@Name='potatoes'">
      Bake <Vegetable Process="washed" Quantity="1200" Type="baking potatoes" Unit="g" />
      at
      <Temperature Level="high" /> for 40 minutes.
    </xsl:if>
    <xsl:if test="@Name='tagliatelli'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a
      <Utensil Name="pan" />
      put
      <xsl:element name="Water">
        <xsl:variable name="Quantity" select="800" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">ml</xsl:attribute>
        <xsl:attribute name="Type">boiling water</xsl:attribute>
      </xsl:element>
      add
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">tagliatelli</xsl:attribute>
      </xsl:element>
      boil for 12 minutes then drain.
    </xsl:if>
    <xsl:if test="@Name='tortellini'">
      <xsl:variable name="Meals" select="../../@Meals" />
      In a
      <Utensil Name="pan" />
      put
      <xsl:element name="Water">
        <xsl:variable name="Quantity" select="800" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">ml</xsl:attribute>
        <xsl:attribute name="Type">boiling water</xsl:attribute>
      </xsl:element>
      and
      <xsl:element name="Grocery">
        <xsl:variable name="Quantity" select="400" />
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * $Quantity" />
        </xsl:attribute>
        <xsl:attribute name="Unit">g</xsl:attribute>
        <xsl:attribute name="Type">tortellini</xsl:attribute>
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
