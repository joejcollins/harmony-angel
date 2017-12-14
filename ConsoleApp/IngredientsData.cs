using CsvHelper;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ConsoleApp
{
    /// <summary>
    /// Ingredients Data so it can be added to the schema.
    /// </summary>
    public class IngredientsData
    {
        private List<Ingredient> m_Ingredients = new List<Ingredient>();

        /// <summary>
        /// Get the list of ingredients from the csv file.
        /// </summary>
        public IngredientsData()
        {
            using (TextReader textReader = File.OpenText(@"./Input/Ingredients.csv"))
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
        public List<Ingredient> GetIngredients(IngredientType ingredientType)
        {
            var ingredientsOfAType = from ingredient in m_Ingredients where ingredient.IngredientType == ingredientType
                                     select ingredient;
            return ingredientsOfAType.ToList();
        }
    }
}
