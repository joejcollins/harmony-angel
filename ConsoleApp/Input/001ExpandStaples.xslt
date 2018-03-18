<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:cml="https://joejcollins.github.io/CookML.xsd"
                exclude-result-prefixes="msxsl cml">
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" indent="yes"/>
  <!-- 
  Copy everything that has no other pattern defined and apply the caloric
  staples template.
  -->
  <xsl:template match="*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="staples" />
    </xsl:copy>
  </xsl:template>
  <!-- 
  Check that all the recipes have a number of meals.  If they don't print
  a message to the console and drop them from further processing becuause
  they would just cause an exception.
  -->
  <xsl:template match="cml:Recipe[not(@Meals)]">
    <xsl:message>Meal '<xsl:value-of select="@Title"/>' has no 'Meals' value and has been dropped.</xsl:message>
  </xsl:template>
  <!--
  Add the meal Title to the index node, so the meals can be categorised in
  the index.
  -->
  <xsl:template name="Index" match="cml:Index">
    <Index>
      <xsl:value-of select="."/>
      <Sub>
        <xsl:value-of select="../@Title"/>
      </Sub>
    </Index>
  </xsl:template>
  <!--
	Expanding the staples is the first step because they use the utensils 
  (which will be replaced with localised text) and because the staple
  tag will add other ingredients to the shopping lists.    
	-->
  <xsl:template name="staples" match="cml:Staple">
    <!-- Get the number of meals -->
    <xsl:variable name="Meals" select="../../@Meals" />
    <!-- Couscous -->
    <xsl:if test="@Name='couscous'">
      In a
      <Utensil Name="pan" /> 
      place
      <Grocery Unit="g" Name="cous cous">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="boiling water">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 600"/>
        </xsl:attribute>
      </Water>,
      and cover, leave to stand for 10 minutes.
    </xsl:if>
    <!-- Noodles -->
    <xsl:if test="@Name='noodles'">
      In a 
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="noodles">
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="boiling water">
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water>,
      cover and simmer for 5 minutes, then drain.
    </xsl:if>
    <xsl:if test="@Name='pasta shapes'">
      In a
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="pasta shapes">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="boiling water">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water>,
      cover and simmer for 12 minutes, then drain.
    </xsl:if>
    <!-- Rice -->
    <xsl:if test="@Name='rice white'">
      In a
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="white rice">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="cold water">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water>,
      bring to the boil then turn off, cover and stand for 25 minutes.
    </xsl:if>
    <xsl:if test="@Name='rice brown'">
      In a
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="brown rice">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="cold water">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water>,
      bring to the boil then cover and simmer for 15 minutes,
      then leave to stand for 10 minutes.
    </xsl:if>
    <xsl:if test="@Name='rice turmeric'">
      In a
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="white rice">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>,
      <Check Unit="tsp" Name="ground turmeric">
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * 1"/>
        </xsl:attribute>
      </Check>
      and
      <Grocery Unit="g" Name="raisins">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 50"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="cold water">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water>,
      bring to the boil then turn off, cover and stand for 25 minutes.
    </xsl:if>
    <!-- Spaghetti -->
    <xsl:if test="@Name='spaghetti'">
      In a
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="spaghetti">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="boiling water">
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water> and continue boiling for 12 minutes then drain.
    </xsl:if>
    <xsl:if test="@Name='baked potatoes'">
      Bake 
      <Vegetable Process="washed" Name="baking potatoes" Unit="g">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 1200"/>
        </xsl:attribute>
      </Vegetable>
      at
      <Temperature Level="high" /> for 40 minutes.
    </xsl:if>
    <xsl:if test="@Name='mashed potatoes'">
      In a <Utensil Name="pan" /> place
      <Vegetable Process="washed" Name="potatoes" Unit="g">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 1200"/>
        </xsl:attribute>
      </Vegetable>
      bring to the boil and simmer for 20 minutes.
      Then mash with 
      <Dairy Quantity="25" Unit="g" Name="butter" /> 
      and
      <Dairy Quantity="75" Unit="g" Name="milk" /> .
  </xsl:if>
    <xsl:if test="@Name='new potatoes'">
      In a <Utensil Name="pan" /> place
      <Vegetable Process="washed" Name="new potatoes" Unit="g">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 1200"/>
        </xsl:attribute>
      </Vegetable>
      bring to the boil and simmer for 20 minutes.
    </xsl:if>
    <xsl:if test="@Name='tagliatelli'">
      In a
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="tagliatelli">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="boiling water">
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water> and continue boiling for 12 minutes then drain.
    </xsl:if>
    <xsl:if test="@Name='tortellini'">
      In a
      <Utensil Name="pan" />
      place
      <Grocery Unit="g" Name="tortellini">
        <xsl:attribute name="Quantity" >
          <xsl:value-of select="($Meals div 2) * 400"/>
        </xsl:attribute>
      </Grocery>
      pour on
      <Water Unit="ml" Name="boiling water">
        <xsl:attribute name="Quantity">
          <xsl:value-of select="($Meals div 2) * 800"/>
        </xsl:attribute>
      </Water>
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
