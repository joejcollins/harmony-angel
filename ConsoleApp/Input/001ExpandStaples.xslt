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
  <!-- Couscous -->
  <xsl:template match="cml:Staple[@Name='couscous']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" /> 
    place
    <Grocery Unit="g" Name="cous cous">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="boiling water">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 500"/>
      </xsl:attribute>
    </Water>
    and cover, leave to stand for 10 minutes.
  </xsl:template>
  <xsl:template match="cml:Staple[@Name='moroccan-couscous']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    mix
    <Grocery Quantity="{($Meals div 2) * 340}" Unit="g" Name="cous cous" />,
    <Check Quantity="{($Meals div 2) * 1}" Unit="tsp" Name="ground cumin" />,
    <Check Quantity="{($Meals div 2) * 1}" Unit="tsp" Name="ground coriander" />,
    <Check Quantity="{($Meals div 2) * 1}" Unit="tsp" Name="ground cinnamon"/>,
    <Grocery Quantity="{($Meals div 2) * 100}" Unit="g" Name="raisins"/>
    and
    <Vegetable Quantity="1" Name="lemon" Process="juiced" />
    pour on
    <Water Quantity="{($Meals div 2) * 500}" Unit="ml" Name="boiling water" />
    and cover, leave to stand for 10 minutes.
  </xsl:template>
  <!-- Noodles -->
  <xsl:template match="cml:Staple[@Name='noodles']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="noodles">
      <xsl:attribute name="Quantity">
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="boiling water">
      <xsl:attribute name="Quantity">
        <xsl:value-of select="($Meals div 2) * 700"/>
      </xsl:attribute>
    </Water>,
    cover and simmer for 5 minutes, then drain.
  </xsl:template>
  <!-- Pasta Shapes -->
  <xsl:template match="cml:Staple[@Name='pasta shapes']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="pasta shapes">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="boiling water">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 700"/>
      </xsl:attribute>
    </Water>,
    cover and simmer for 12 minutes, then drain.
  </xsl:template>
  <!-- Rice White -->
  <xsl:template match="cml:Staple[@Name='rice white']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="white rice">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="cold water">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 680"/>
      </xsl:attribute>
    </Water>,
    bring to the boil then turn off, cover and stand for 25 minutes.
  </xsl:template>
  <!-- Brown Rice -->
  <xsl:template match="cml:Staple[@Name='rice brown']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="brown rice">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="cold water">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 680"/>
      </xsl:attribute>
    </Water>,
    bring to the boil then cover and simmer for 15 minutes,
    then leave to stand for 10 minutes.
  </xsl:template>
  <!-- Turmeric Rice -->
  <xsl:template match="cml:Staple[@Name='rice turmeric']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="white rice">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
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
        <xsl:value-of select="($Meals div 2) * 680"/>
      </xsl:attribute>
    </Water>,
    bring to the boil then turn off, cover and stand for 25 minutes.
  </xsl:template>
  <!-- Spaghetti -->
  <xsl:template match="cml:Staple[@Name='spaghetti']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="spaghetti">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="boiling water">
      <xsl:attribute name="Quantity">
        <xsl:value-of select="($Meals div 2) * 700"/>
      </xsl:attribute>
    </Water> and continue boiling for 12 minutes then drain.
  </xsl:template>
  <!-- Baked Potatoes -->
  <xsl:template match="cml:Staple[@Name='baked potatoes']">
    <xsl:variable name="Meals" select="../../@Meals" />
    Bake
    <Vegetable Process="washed" Name="baking potatoes" Unit="g">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 1200"/>
      </xsl:attribute>
    </Vegetable>
    at
    <Temperature Level="high" /> for 40 minutes.
  </xsl:template>
  <!-- Mashed Potatoes -->
  <xsl:template match="cml:Staple[@Name='mashed potatoes']">
    <xsl:variable name="Meals" select="../../@Meals" />
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
    <Dairy Quantity="75" Unit="g" Name="milk" />.
  </xsl:template>
  <!-- New Potatoes -->
  <xsl:template match="cml:Staple[@Name='new potatoes']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a <Utensil Name="pan" /> place
    <Vegetable Process="washed" Name="new potatoes" Unit="g">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 1200"/>
      </xsl:attribute>
    </Vegetable>
    bring to the boil and simmer for 20 minutes.
  </xsl:template>
  <!-- Tagliatelli -->
  <xsl:template match="cml:Staple[@Name='tagliatelli']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="tagliatelli">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="boiling water">
      <xsl:attribute name="Quantity">
        <xsl:value-of select="($Meals div 2) * 700"/>
      </xsl:attribute>
    </Water> and continue boiling for 12 minutes then drain.
  </xsl:template>
  <!-- Tortellini -->
  <xsl:template match="cml:Staple[@Name='tortellini']">
    <xsl:variable name="Meals" select="../../@Meals" />
    In a
    <Utensil Name="pan" />
    place
    <Grocery Unit="g" Name="tortellini">
      <xsl:attribute name="Quantity" >
        <xsl:value-of select="($Meals div 2) * 340"/>
      </xsl:attribute>
    </Grocery>
    pour on
    <Water Unit="ml" Name="boiling water">
      <xsl:attribute name="Quantity">
        <xsl:value-of select="($Meals div 2) * 700"/>
      </xsl:attribute>
    </Water>
    boil for 5 minutes then drain.
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
