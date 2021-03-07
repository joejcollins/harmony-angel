using System;

namespace ConsoleApp
{
    /// <summary>
    /// Used to get data about the ingredient and insert it into the transformation
    /// </summary>
    public class XmlIngredient
    {

        public XmlIngredient()
        {
        }

        public String IngredientName { get; set; }
        public IngredientType IngredientType { get; set; }
        public Int16 CaloriesIn100g { get; set; }
        public float ProteinIn100g { get; set; }
        public float CarbsIn100g { get; set; }
        public float FatIn100g { get; set; }
        public float SpecificGravity { get; set; }

        /// <summary>
        /// Get the calories for a specified portion.  It returns a 
        /// System.String but could return a System.Double if 
        /// necessary.  An XSLT extension object ought to be able
        /// to do either.  However, it doesn't seem to matter
        /// which is used in this case.
        /// </summary>
        /// <param name="quantity"></param>
        /// <param name="unit"></param>
        /// <param name="name"></param>
        /// <returns></returns>
        public string PortionCalories(double quantity, string unit, string name)
        {
            IngredientsData ingredientsData = IngredientsData.Instance;
            double returnValue = 0;
            returnValue = ingredientsData.GetCalories(quantity, unit, name);
            return returnValue.ToString();
        }


        /// <summary>
        /// Equivalent types see <https://msdn.microsoft.com/en-us/magazine/bb986125.aspx>
        /// 
        /// 3C XPath Type -> Equivalent .NET Class (Type) 
        /// String -> System.String
        /// Boolean -> System.Boolean
        /// Number -> System.Double
        /// Result Tree Fragment -> System.Xml.XPath.XPathNavigator
        /// Node Set -> System.Xml.XPath.XPathNodeIterator
        /// </summary>
        /// <param name="quantity"></param>
        /// <param name="unit"></param>
        /// <param name="name"></param>
        /// <returns></returns>
        public Double PortionFat(double quantity, string unit, string name)
        {
            //TODO: Get the actual amount of fat per gram and make the calculation.
            return 1.5;
        }
    }
}
