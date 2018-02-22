using System;

namespace ConsoleApp
{
    /// <summary>
    /// Used to get data about the ingredient and insert it into the transformation
    /// </summary>
    public class Ingredient
    {

        public Ingredient()
        {
        }

        public String IngredientName { get; set; }
        public IngredientType IngredientType { get; set; }
        public Int16 Calories { get; set; }
        public float Protein { get; set; }
        public float Carbohydrate { get; set; }
        public float Fat { get; set; }

        public string PortionCalories(double quantity, string type, string unit)
        {
            //TODO: Get the actual calories per gram and make the calculation.
            return quantity.ToString() + type + unit;
        }

        public Double PortionFat(double quantity, string type, string unit)
        {
            //TODO: Get the actual amount of fat per gram and make the calculation.
            return 1.5;
        }
    }

    ///// <summary>
    ///// Mapping class for use by the CsvReader
    ///// </summary>
    //public sealed class IngredientMap : ClassMap<Ingredient>
    //{
    //    public IngredientMap()
    //    {
    //        Map(m => m.IngredientName);
    //        Map(m => m.IngredientType);
    //        Map(m => m.Calories);
    //        Map(m => m.Protien);
    //        Map(m => m.Carbohydrate);
    //        Map(m => m.Fat);
    //    }
    //}


}
