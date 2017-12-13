using System;
using System.Collections.Generic;
using System.IO;
using CsvHelper;
using System.Linq;

namespace ConsoleApp
{
    /// <summary>
    /// IngredientsDatabase.
    /// </summary>
    public class IngredientsData
    {
        private List<Ingredient> m_Ingredients = new List<Ingredient>();

        /// <summary>
        /// Default constructor for IngredientsDatabase.
        /// </summary>
        public IngredientsData()
        {
            using (TextReader textReader = File.OpenText(@"./ConsoleApp/Input/Ingredients.csv"))
            {
                var csv = new CsvReader(textReader);
                m_Ingredients = csv.GetRecords<Ingredient>().ToList();
            }
        }

        /// <summary>
        /// Return a list of ingredients to restrict the available types using the schema.
        /// </summary>
        /// <param name="strIngredientType"></param>
        /// <returns>List of ingredients</returns>
        public List<Ingredient> Ingredients(IngredientTypes ingredientType)
        {
            var ingredientsOfAType = from ingredientx in m_Ingredients where ingredientx.IngredientType == ingredientType
                                     select ingredientx;
            return ingredientsOfAType.ToList();
        }
    }
}
