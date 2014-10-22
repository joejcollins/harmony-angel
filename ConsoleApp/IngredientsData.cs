/*************************************************************************
 * Project: CookML
 * Copyright: Joe Collins (c) 2009
 * Purpose: Utilities for accessing the database of ingredients.
 * $Author: cookml $
 * $Date: 2011-01-12 19:05:57 +0000 (Wed, 12 Jan 2011) $
 * $Workfile: $
 * $Revision: 10 $
 ************************************************************************/
using System;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;

namespace CookMLConsole
{
	/// <summary>
	/// IngredientsDatabase.
	/// </summary>
	public class IngredientsData
	{
		private string mstrConnection;
		private OleDbConnection m_Connection = new OleDbConnection();
		private string selectCmd;
		private OleDbDataAdapter m_Adaptor;
		private DataSet m_DataSet = new DataSet();

		/// <summary>
		/// Default constructor for IngredientsDatabase.
		/// </summary>
		public IngredientsData()
		{
  			mstrConnection = "Provider=Microsoft.Jet.OLEDB.4.0;";
			mstrConnection += "Data Source=";
			//mstrConnection += System.IO.Directory.GetCurrentDirectory().ToString().TrimEnd('b', 'i', 'n');
			mstrConnection += "..\\..\\Input\\Ingredients.mdb;";
			m_Connection.ConnectionString = mstrConnection;
		}

		/// <summary>
		/// Return a list of ingredients to restrict the available types using the schema.
		/// </summary>
		/// <param name="strIngredientType"></param>
		/// <returns>List of ingredients</returns>
		public DataSet Ingredients(string strIngredientType)
		{
			selectCmd = "SELECT IngredientName FROM tblIngredientTypes INNER JOIN tblIngredients ON tblIngredientTypes.ID = tblIngredients.IngredientType WHERE (((tblIngredientTypes.IngredientType)='" + strIngredientType + "'));";
			m_Adaptor = new OleDbDataAdapter(selectCmd, m_Connection);
			m_Adaptor.Fill(m_DataSet, strIngredientType);
			return m_DataSet;	
		}

		/// <summary>
		/// Return a list of ingredient types to restrict the available types using the schema.
		/// </summary>
		/// <returns>List of ingredient types</returns>
		public DataSet IngredientTypes()
		{
			selectCmd = "SELECT * FROM tblIngredientTypes;";
			m_Adaptor = new OleDbDataAdapter(selectCmd, m_Connection);
			m_Adaptor.Fill(m_DataSet, "IngredientTypes");
			return m_DataSet;	
		}
	}
}
