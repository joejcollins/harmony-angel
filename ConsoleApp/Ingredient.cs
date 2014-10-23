using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace ConsoleApp
{
    class Ingredient
    {

        public Ingredient()
        {
        }

        public string Calories(double quantity, string type, string unit)
        {
            //TODO: Get the actual calories per gram and make the calculation.
            return quantity.ToString() + type + unit;
        }

        public Double Fat(double quantity, string type, string unit)
        {
            //TODO: Get the actual amount of fat per gram and make the calculation.
            return 1.5;
        }


    }
}
