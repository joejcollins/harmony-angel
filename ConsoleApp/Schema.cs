using System;
using System.Diagnostics;
using System.Xml;

namespace ConsoleApp
{
    /// <summary>
    /// The Schema is mainly used to provide Intellisense in 
    /// Visual Studio for editing the FoodFile.xml document and 
    /// should provide the lists of ingredients for the different 
    /// ingredient types.
    /// </summary>
    public class Schema
	{
		private XmlDocument m_CookMLSchema;
		private string m_strSchemaPath = @"./Input/CookML.xsd";
		private XmlNamespaceManager m_NSManager;
		private string m_strNameSpace = "http://www.w3.org/2001/XMLSchema";
		private string strPrefix = "xsd";

		/// <summary>
		/// Construct the schema object with a name space manager.  The 
		/// Name space manager is crucial to allowing elements to be 
		/// added to the schema with the correct prefixesd.
		/// </summary>
		public Schema()
		{
			//Initialize the schema document.
			m_CookMLSchema = new XmlDocument();
			m_CookMLSchema.Load(m_strSchemaPath);
			m_NSManager = new XmlNamespaceManager(m_CookMLSchema.NameTable);
			m_NSManager.AddNamespace(strPrefix, m_strNameSpace);
		}

		/// <summary>
		/// Update the CookML schema with information from the database.  This
		/// allows the editor to show a drop down list of ingredients.
		/// </summary>
		public void UpdateSchema()
		{
			Debug.WriteLine("Schema namespace: " + m_strNameSpace);
		    //IDictionaryEnumerator IngredientTypesEnumerator = IngredientTypes;

            foreach (IngredientType ingredientType in Enum.GetValues(typeof(IngredientType)))
			{
				Debug.WriteLine("Ingredient type: " + ingredientType);
				UpdateIngredients(ingredientType);
			}
			m_CookMLSchema.Save(m_strSchemaPath);
		}

		/// <summary>
		/// Update the ingredients for a given type in the CookML schema.		
		/// </summary>
		private void UpdateIngredients(IngredientType ingredientType)
		{
			XmlNode ingredientTypesNode = 
				m_CookMLSchema.SelectSingleNode("//xsd:simpleType[@name='" + ingredientType.ToString() + "']", 
				m_NSManager);

			//Clear out the node completely
			ingredientTypesNode.RemoveAll();

			//Recreate the attribute but with a blank name space because attributes are unqualified.
			XmlNode name = m_CookMLSchema.CreateNode(XmlNodeType.Attribute, "name", "");
			name.Value = ingredientType.ToString();
			ingredientTypesNode.Attributes.SetNamedItem(name);
	
			//Recreate the documentation node
			XmlElement annotation = 
				m_CookMLSchema.CreateElement(strPrefix, "annotation", m_strNameSpace);
			XmlElement documentation = 
				m_CookMLSchema.CreateElement(strPrefix, "documentation", m_strNameSpace);
			documentation.InnerText = ingredientType + " types in the database";
			annotation.AppendChild(documentation);
			ingredientTypesNode.AppendChild(annotation);

			//Recreate the restriction list using the ingredients data
			XmlElement restriction = 
				m_CookMLSchema.CreateElement(strPrefix, "restriction", m_strNameSpace);
			XmlNode baseAttribute = m_CookMLSchema.CreateNode(XmlNodeType.Attribute, "base", "");
			baseAttribute.Value = "xsd:string";
			restriction.Attributes.SetNamedItem(baseAttribute);

            IngredientsData IngredientsData = new IngredientsData();
            foreach (XmlIngredient ingredient in IngredientsData.GetIngredients(ingredientType))
			{
				XmlElement enumeration = m_CookMLSchema.CreateElement(strPrefix, "enumeration", m_strNameSpace);
				XmlNode valueAttribute = m_CookMLSchema.CreateNode(XmlNodeType.Attribute, "value", ""); //blank name space because attributes are unqualified.
				valueAttribute.Value = ingredient.IngredientName;
				enumeration.Attributes.SetNamedItem(valueAttribute);
				restriction.AppendChild(enumeration);
			}
			ingredientTypesNode.AppendChild(restriction);
		}
	}
}
