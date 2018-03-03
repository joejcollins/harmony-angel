/// <summary>
/// 
/// </summary>
namespace ConsoleApp
{
    /// <summary>
    /// Used to count the number of meals within the menu.
    /// </summary>
    class XmlIncrement
    {
        private int _counter = 0;

        public XmlIncrement()
        {
        }

        public void Reset(int input)
        {
            _counter = input;
        }

        public int Counter(int input)
        {
            _counter += input;
            return _counter;
        }
    }
}
