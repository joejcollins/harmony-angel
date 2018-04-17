﻿using System;
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
            string lastFile = transformer.CreateBook(@"./Input/FoodFile.xml");

            // Create the LaTex file
            transformer.ApplyXslt(@"./LaTeX/LaTeX.xslt", lastFile, @"./LaTeX/Content.tex");

            // Create the Mark Down files




            Console.WriteLine("Press any key to continue...");
            Console.ReadLine();
        }
    }
}

