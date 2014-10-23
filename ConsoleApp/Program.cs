/*************************************************************************
 * Project: CookML
 * Copyright: Joe Collins (c) 2003
 * Purpose: 
 * $Author: cookml $
 * $Date: 2011-07-20 13:01:57 +0100 (Wed, 20 Jul 2011) $
 * $Workfile: $
 * $Revision: 12 $
 ************************************************************************/
using System;
using System.IO;

namespace CookML
{
    class Program
    {
        static void Main(string[] args)
        {
            // Update the schema so it includes all the ingredient types
            ConsoleApp.Schema schema = new ConsoleApp.Schema();
            schema.UpdateSchema();
            // Transform the CookML 
            ConsoleApp.Transformer transformer = new ConsoleApp.Transformer();
            string lastFile = transformer.CreateBook(@"../../Input/FoodFile.xml");
            // Rename last file to LaTeX
            File.Copy(lastFile, @"../../Output/Content.tex", true);

            Console.WriteLine("Press any key to continue...");
            Console.ReadLine();
        }
    }
}
