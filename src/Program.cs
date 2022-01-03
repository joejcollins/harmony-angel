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
            string lastFile = transformer.CreateBook(@"../data/raw/Recipes.xml");
            // Rename last file to LaTeX
            File.Copy(lastFile, @"../data/processed/RecipesContent.tex", true);

            Console.WriteLine("Press any key to continue...");
            Console.ReadLine();
        }
    }
}

