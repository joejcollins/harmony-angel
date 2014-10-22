<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cml="http://www.bagbatch.co.uk/CookBook/CookML.xsd" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:user="urn:my-scripts">
  <xsl:strip-space elements="*"/>
	<!--
 Producing a search and replace function in XSLT is entirely 
 possible, it is just much easier to use C# instead.
-->
	<msxsl:script language="C#" implements-prefix="user">
	<![CDATA[
	public string ReturnData()
	{
	//	System.Data.OleDb.OleDbConnection myConnection = new System.Data.OleDb.OleDbConnection();
	//	myConnection.ConnectionString = "";
	//	return myConnection.ConnectionString;
		return "";
	}
	]]>
   </msxsl:script>
	<xsl:output method="xml" omit-xml-declaration="no" />
	<!--
		Format for the book
	-->
	<xsl:template match="cml:Book">
		<cml:Book>
			<xsl:value-of select="user:ReturnData()" />
			<xsl:apply-templates select="cml:Menu" />
		</cml:Book>
	</xsl:template>
	<!--
		Format the Menu
	-->
	<xsl:template match="cml:Menu">
		<xsl:element name="cml:Menu">
			<xsl:attribute name="Title">
				<xsl:value-of select="@Title" />
			</xsl:attribute>
			<ShoppingList>
				<VegetableShopping>
					<xsl:for-each select="cml:Recipe/cml:Stage/cml:Vegetable">
						<xsl:sort select="@Type" />
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
							<xsl:attribute name="Meal">
								<xsl:value-of select="./../../@Meals" />
							</xsl:attribute>
						</xsl:element>
					</xsl:for-each>
				</VegetableShopping>
				<GroceryShopping>
					<xsl:for-each select="cml:Recipe/cml:Stage/cml:Grocery">
						<xsl:sort select="@Type" />
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
							<xsl:attribute name="Meal">
								<xsl:value-of select="./../../@Meals" />
							</xsl:attribute>
						</xsl:element>
					</xsl:for-each>
				</GroceryShopping>
				<MeatShopping>
					<xsl:for-each select="cml:Recipe/cml:Stage/cml:Meat">
						<xsl:sort select="@Type" />
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
							<xsl:attribute name="Meal">
								<xsl:value-of select="./../../@Meals" />
							</xsl:attribute>
						</xsl:element>
					</xsl:for-each>
				</MeatShopping>
				<DairyShopping>
					<xsl:for-each select="cml:Recipe/cml:Stage/cml:Dairy">
						<xsl:sort select="@Type" />
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
							<xsl:attribute name="Meal">
								<xsl:value-of select="./../../@Meals" />
							</xsl:attribute>
						</xsl:element>
					</xsl:for-each>
				</DairyShopping>
				<CheckShopping>
					<xsl:for-each select="cml:Recipe/cml:Stage/cml:Check">
						<xsl:sort select="@Type" />
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
							<xsl:attribute name="Meal">
								<xsl:value-of select="./../../@Meals" />
							</xsl:attribute>
						</xsl:element>
					</xsl:for-each>
				</CheckShopping>
			</ShoppingList>
			<xsl:apply-templates select="cml:Recipe" />
		</xsl:element>
	</xsl:template>
	<!-- 
		Recipe
	-->
	<xsl:template match="cml:Recipe">
		<xsl:element name="cml:Recipe">
			<xsl:attribute name="Meals">
				<xsl:value-of select="@Meals" />
			</xsl:attribute>
			<xsl:attribute name="Title">
				<xsl:value-of select="@Title" />
			</xsl:attribute>
			<xsl:element name="Ingredients">
				<xsl:for-each select="cml:Stage/cml:Vegetable|cml:Stage/cml:Grocery|cml:Stage/cml:Dairy|cml:Stage/cml:Meat|cml:Stage/cml:Check">
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
					</xsl:element>
				</xsl:for-each>
			</xsl:element>
			<xsl:apply-templates select="cml:Stage" />
		</xsl:element>
	</xsl:template>
	<!-- 
		Stage - the contents of the stage can be copied without 
		any transformations.
	-->
	<xsl:template match="cml:Stage">
		<xsl:copy-of select="." />
	</xsl:template>
	
</xsl:stylesheet>
