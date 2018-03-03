using CsvHelper;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System;

namespace ConsoleApp
{
    /// <summary>
    /// Ingredients Data so it can be added to the schema.
    /// </summary>
    public class IngredientsData
    {
        private List<XmlIngredient> m_Ingredients = new List<XmlIngredient>();

        /// <summary>
        /// Get the list of ingredients from the csv file.
        /// </summary>
        public IngredientsData()
        {
            using (TextReader textReader = File.OpenText(@"./Input/Ingredients.csv"))
            {
                var csv = new CsvReader(textReader);
                m_Ingredients = csv.GetRecords<XmlIngredient>().ToList();
            }
        }

        internal double GetCalories(double quantity, string name)
        {
            var thisIngredient = m_Ingredients.FirstOrDefault(ingredient => ingredient.IngredientName == name);
            double calories = (quantity / 100) * thisIngredient.Calories;
            return calories;                
         }

        /// <summary>
        /// Return a list of ingredients to restrict the available types using the schema.
        /// </summary>
        /// <param name="strIngredientType"></param>
        /// <returns>List of ingredients</returns>
        internal List<XmlIngredient> GetIngredients(IngredientType ingredientType)
        {
            var ingredientsOfAType = from ingredient in m_Ingredients where ingredient.IngredientType == ingredientType
                                     select ingredient;
            return ingredientsOfAType.ToList();
        }


    }
}
