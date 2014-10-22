/*************************************************************************
 * Project: CookML
 * Copyright: Joe Collins (c) 2009
 * Purpose: Utilities for accessing the database of ingredients.
 * $Author: cookml $
 * $Date: 2009-10-02 16:50:08 +0100 (Fri, 02 Oct 2009) $
 * $Workfile: $
 * $Revision: 7 $
 ************************************************************************/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace CookMLConsole
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
