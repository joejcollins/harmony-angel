using System;
using System.Xml;
using System.Xml.Xsl;

namespace ConsoleApp
{
    /// <summary>
    /// Transformer.
    /// </summary>
    public class Transformer
	{
        string inputDirectory = @"./assets/";
        string outputDirectory = @"../data/interim/";

        /// <summary>
        /// 
        /// </summary>
        string[] xsltFiles = { "001ExpandStaples.xslt", 
            "002AddFoodData.xslt",
            "003ListsAndStructure.xslt",
            "004FilterVegetableLists.xslt",
            "005ConcatenateShoppingLists.xslt",
            "006LaTeX.xslt"};

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
        /// Transform the previously created xml files, whilst adding in the
        /// extensions so the extension objects can be used within the transformation.
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
            XmlIngredient ingredient = new XmlIngredient();
            xsltArguments.AddExtensionObject("urn:Ingredient", ingredient);
            XmlIncrement increment = new XmlIncrement();
            xsltArguments.AddExtensionObject("urn:Increment", increment);

            // Set the conformance to auto so it can fuck up a bit sometimes.
            XmlWriterSettings settings = new XmlWriterSettings();
            settings.ConformanceLevel = ConformanceLevel.Auto;
            // Remove the BOM (Byte Order Mark) which messes up the LaTeX processor
            settings.Encoding = new System.Text.UTF8Encoding(false);

            // Use the 
            String nextWorkingFile = outputDirectory + xsltFile + ".xml";
            using (XmlWriter xmlWriter = XmlWriter.Create(nextWorkingFile, settings))
            {
                // Transform the file.
                xslt.Transform(workingXmlFile, xsltArguments, xmlWriter);
            }
            return nextWorkingFile;
        }
	}
}
