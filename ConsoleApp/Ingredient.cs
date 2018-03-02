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

        public string PortionCalories(double quantity, string unit, string name)
        {
            IngredientsData IngredientsData = new IngredientsData();
            double returnValue;
            if (unit == "g")
            {
                returnValue = IngredientsData.GetCalories(quantity, name);
            }
            else
            {
                returnValue = 0;
            }
            return returnValue.ToString();
        }

        public Double PortionFat(double quantity, string unit, string name)
        {
            //TODO: Get the actual amount of fat per gram and make the calculation.
            return 1.5;
        }
    }
}
