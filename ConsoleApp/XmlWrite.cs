using System.IO;

namespace ConsoleApp
{
    class XmlFile
    {
        public string Write(string fileName, string text)
        {
            File.WriteAllText(fileName, text);
            return fileName;
        }
    }
}
