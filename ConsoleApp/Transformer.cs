using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;

namespace ConsoleApp
{
    /// <summary>
    /// Transformer.
    /// </summary>
    public class Transformer
	{
        /// <summary>
        /// 
        /// </summary>
        private string[] xsltFiles;

        /// <summary>
        /// Default constructor for Transformer.
        /// </summary>
        public Transformer()
        {
            // Get the list of transforms starting with a zero.
            xsltFiles = Directory.GetFiles(@"./Input/", "0*.xslt", SearchOption.TopDirectoryOnly);
            Array.Sort(xsltFiles); //because they are not garanteed to be in order
        }

        /// <summary>
        /// Apply the sequence of xslt files to create the cookbook with shopping lists and data.
        /// </summary>
        /// <param name="cmlFile"></param>
        /// <returns></returns>
        public string CreateBook(String cmlFile)
        {
            string workingXmlFile = cmlFile;
            foreach (String xsltFile in xsltFiles)
            {
                workingXmlFile = this.ApplyXslt(xsltFile, workingXmlFile);
            }
            return workingXmlFile;
        }

        /// <summary>
        /// Shorter method signature.
        /// </summary>
        /// <param name="xsltFile">Path to the Xslt</param>
        /// <param name="workingXmlFile">Path to the file to be transformed</param>
        /// <returns>Path to the resulting transformation</returns>
        public String ApplyXslt(String xsltFile, String workingXmlFile)
        {
            return ApplyXslt(xsltFile, workingXmlFile, xsltFile + ".xml");
        }

        /// <summary>
        /// Transform the previously created xml files, whilst adding in the
        /// extensions so the extension objects can be used within the transformation.
        /// </summary>
        /// <param name="xsltFile">Path to the Xslt</param>
        /// <param name="workingXmlFile">Path to the file to be transformed</param>
        /// <param name="outputFile">Path to where the resulting transformation should go</param>
        /// <returns>Path to the resulting transformation</returns>
        public String ApplyXslt(String xsltFile, String workingXmlFile, String outputFile)
        {
            // Create the XslCompiledTransform and load the stylesheet.
            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load(xsltFile);

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
            String nextWorkingFile = outputFile;
            using (XmlWriter xmlWriter = XmlWriter.Create(nextWorkingFile, settings))
            {
                // Transform the file.
                xslt.Transform(workingXmlFile, xsltArguments, xmlWriter);
                Console.WriteLine("Transformed using " + xsltFile);
            }
            return nextWorkingFile;
        }
	}
}
