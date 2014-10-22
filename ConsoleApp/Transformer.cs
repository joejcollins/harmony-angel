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
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;
using System.Diagnostics;

namespace CookMLConsole
{
	/// <summary>
	/// Transformer.
	/// </summary>
	public class Transformer
	{
        string inputDirectory = "..//..//Input//";

        /// <summary>
        /// 
        /// </summary>
        string[] xsltFiles = { "001ExpandStaplesAndUtensils.xslt", 
                                 "002AddFoodData.xslt", 
                                 "003ListsAndStructure.xslt", 
                                 //"004MergeLists.xslt",
                                 "005LaTeX.xslt"
                             };

        /// <summary>
        /// Default constructor for Transformer.
        /// </summary>
        public Transformer()
        {
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="cmlFile"></param>
        /// <returns></returns>
        public string CreateBook(String cmlFile)
        {
            string workingXmlFile = cmlFile;
            foreach (String xsltFile in xsltFiles)
            {
                workingXmlFile = this.ApplyXslt(xsltFile, workingXmlFile);
                Console.WriteLine("Transformed using " + xsltFile);
            }
            return workingXmlFile;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="xsltFile"></param>
        /// <param name="workingXmlFile"></param>
        /// <returns></returns>
        private String ApplyXslt(String xsltFile, String workingXmlFile)
        {
            // Create the XslCompiledTransform and load the stylesheet.
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load(inputDirectory + xsltFile);

            // Create an XsltArgumentList, and add the ingredient as an extension object
            XsltArgumentList xsltArguments = new XsltArgumentList();
            Ingredient ingredient = new Ingredient();
            xsltArguments.AddExtensionObject("urn:Ingredient", ingredient);

            // Set the conformance to auto so it can fuck up a bit sometimes.
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.ConformanceLevel = ConformanceLevel.Auto;
            // Remove the BOM (Byte Order Mark) which messes up the LaTeX processor
            settings.Encoding = new System.Text.UTF8Encoding(false);

            // Use the 
            String nextWorkingFile = inputDirectory + xsltFile + ".xml";
            using (XmlWriter xmlWriter = XmlWriter.Create(nextWorkingFile, settings))
            {
                // Transform the file.
                xslt.Transform(workingXmlFile, xsltArguments, xmlWriter);
            }
            return nextWorkingFile;
        }
	}
}
