using System;

namespace ConsoleApp
{
    public enum IngredientType
    {
        Check = 1,
        Dairy = 2,
        Grocery = 3,
        Meat = 4,
        Vegetable = 5,
        Water = 6
    };

    /// <summary>
    /// Type Safe Enum Pattern - not being used at the momment
    /// </summary>
    public sealed class AlternativeIngredientTypes
    {
        private readonly String name;
        private readonly int value;

        public static readonly AlternativeIngredientTypes Check = new AlternativeIngredientTypes(1, "Check");
        public static readonly AlternativeIngredientTypes DAIRY = new AlternativeIngredientTypes(2, "DAIRY");
        public static readonly AlternativeIngredientTypes GROCERY = new AlternativeIngredientTypes(3, "GROCERY");
        public static readonly AlternativeIngredientTypes MEAT = new AlternativeIngredientTypes(4, "MEAT");
        public static readonly AlternativeIngredientTypes VEGETABLE = new AlternativeIngredientTypes(5, "VEGETABLE");

        private AlternativeIngredientTypes(int value, String name)
        {
            this.name = name;
            this.value = value;
        }

        public override String ToString()
        {
            return name;
        }
    }
}
