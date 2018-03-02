<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                exclude-result-prefixes="msxsl">
  <xsl:strip-space elements="*"/>
  <xsl:output omit-xml-declaration="yes" method="text" media-type="text/plain" indent="no"  />
  <!--
  Global parameter
  -->	
	<xsl:param name="MealCount" select="0" />

	<!--
	Format for the book, and introduction
	-->
	<xsl:template match="Book">
    % !TeX root = FoodFile.tex
    % Content Begins
    <xsl:apply-templates select="Menu" />
    % Content Ends
	</xsl:template>

	<!--
  Format for the menu        
	-->
	<xsl:template match="Menu">
		\begin{menu}{<xsl:value-of select="@Title" />}
    <xsl:apply-templates />
    \clearpage
    \end{menu}
	</xsl:template>

  <!--
  Recipe List
  -->
  <xsl:template match="RecipeList">
    \begin{recipelist}
    <xsl:for-each select="./Title">
      <xsl:if test="(position() > 0 and position() &lt; 5)">
        {\scriptsize[<xsl:value-of select="@MealsLabel" />]} <xsl:value-of select="." />\\<xsl:if test="position() = 4">%</xsl:if>
      </xsl:if>
    </xsl:for-each>
    \end{recipelist}%
    \begin{recipelist}
    <xsl:for-each select="./Title">
      <xsl:if test="position() > 4">
        {\scriptsize[<xsl:value-of select="@MealsLabel" />]} <xsl:value-of select="." />\\<xsl:if test="position() = 8">%</xsl:if>
      </xsl:if>
    </xsl:for-each>
    \end{recipelist}\par%
  </xsl:template>
  
  <!--
	Format shopping list.
  Be aware that LaTeX is sensitive to white space, specifically there must be no
  new paragraphs between the minipages, for them to end up side by side.
	-->
  <xsl:template match="ShoppingLists">
    \subsection*{Shopping Lists}
    <xsl:for-each select="./Shopping">%
      \begin{shoppinglist}{<xsl:value-of select="@Title" />}
      <xsl:for-each select="./Item">
        <xsl:value-of select="sum(./Quantity)" /><xsl:text> </xsl:text>
        <xsl:value-of select="@Unit" /><xsl:text> </xsl:text>
        <xsl:value-of select="@Type" /><xsl:text> </xsl:text>
        {\scriptsize[<xsl:call-template name="join"><xsl:with-param name="valueList" select="./MealsLabel"/></xsl:call-template>]}\\
      </xsl:for-each>%
      \end{shoppinglist}%
      <xsl:if test="(position() mod 2) != 1">\par\vfil </xsl:if>%
      <xsl:if test="position() = 4">\vfil\clearpage </xsl:if>%
    </xsl:for-each>%
    \othershoppinglist{Other Shopping}%
    \othershoppinglist{Extra Other Shopping}%
    \vfil\clearpage
  </xsl:template>

  <!-- 
  The template 'join' accepts valueList and separator.  This can be done 
  easily with XPATH 2.0 fn:string-join(sequence, delimiter). However .NET 
  only supports XSLT 1.0, XPATH 1.0. 
  -->
  <xsl:template name="join" >
    <xsl:param name="valueList" select="''"/>
    <xsl:param name="separator" select="','"/>
    <xsl:for-each select="$valueList">
      <xsl:choose>
        <xsl:when test="position() = 1">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(', ', .) "/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
 
  <!--
	Format for the recipe using the recipe environment, if it is an odd
	number in the menu then clear the page before you begin.
	-->
	<xsl:template match="Recipe">
    \begin{recipe}{<xsl:value-of select="@Meals" />}{<xsl:value-of select="@Title" />}% Calories: <xsl:value-of select="format-number(sum(./Ingredients/Item/@Calories),'##0' )" />
    <xsl:apply-templates select="Ingredients" />
    <xsl:apply-templates select="Index" />
    \begin{instructions}
    <xsl:apply-templates select="Stage" />
    \end{instructions}
    \end{recipe}%
  </xsl:template>

  <!--
		Format for the index markers
	-->
  <xsl:template match="Index">
		\index{<xsl:value-of select="normalize-space(text())" /><xsl:if test="./Sub != ''">!<xsl:value-of select="./Sub" /></xsl:if>}
	</xsl:template>

  <!--
		Format for the ingredients list in the ingredients environment
	-->
	<xsl:template match="Ingredients">
		\begin{ingredients}
		<xsl:apply-templates select="Item" />
		\end{ingredients}
	</xsl:template>
	<xsl:template match="Item">
		<xsl:value-of select="@Quantity" /><xsl:text> </xsl:text>
		<xsl:value-of select="@Unit" /><xsl:text> </xsl:text>
		<xsl:value-of select="@Type" /><xsl:text> </xsl:text>
		<xsl:if test="@Process != ''">(<xsl:value-of select="@Process" />)</xsl:if> \\
	</xsl:template>
  
  <!--
		Format for the stage and layout the ingredient within the stage
	-->
	<xsl:template match="Stage">\item <xsl:apply-templates /></xsl:template>
	<xsl:template match="Vegetable|Grocery|Meat|Dairy|Check|Water">
		<xsl:value-of select="@Quantity" />
    <xsl:if test="@Quantity">
      <xsl:text>~</xsl:text>
    </xsl:if>
		<xsl:value-of select="@Unit" /><xsl:text> </xsl:text>
		<xsl:value-of select="@Process" /><xsl:text> </xsl:text>
		<xsl:value-of select="@Type" />
	</xsl:template>
  <xsl:template match="Temperature">
    <xsl:if test="@Level='low'">(160$^{\circ}$C, Gas 3, 325$^{\circ}$F)</xsl:if>
    <xsl:if test="@Level='medium'">(200$^{\circ}$C, Gas 5, 380$^{\circ}$F)</xsl:if>
    <xsl:if test="@Level='high'">(240$^{\circ}$C, Gas 9, 475$^{\circ}$F)</xsl:if>
  </xsl:template>

</xsl:stylesheet>
