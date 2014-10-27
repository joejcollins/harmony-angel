using System;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;

namespace ConsoleApp
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
		/// HDR = Column names in header
		/// IMEX = Avoid a crash
		/// </summary>
		public IngredientsData()
		{
            mstrConnection = "Provider=Microsoft.ACE.OLEDB.12.0;";
			mstrConnection += "Data Source=";
			mstrConnection += "..\\..\\Input\\Ingredients.xlsx;";
            mstrConnection += "Extended Properties = \"Excel 12.0 Xml;HDR=YES;IMEX=1\"";
			m_Connection.ConnectionString = mstrConnection;
		}

		/// <summary>
		/// Return a list of ingredients to restrict the available types using the schema.
		/// </summary>
		/// <param name="strIngredientType"></param>
		/// <returns>List of ingredients</returns>
		public DataSet Ingredients(string strIngredientType)
		{
			selectCmd = "SELECT IngredientName FROM [tblIngredients$A1:H200] WHERE IngredientType='" + strIngredientType + "'";
			m_Adaptor = new OleDbDataAdapter(selectCmd, m_Connection);
			m_Adaptor.Fill(m_DataSet, strIngredientType);
			return m_DataSet;	
		}
	}
}
