/// <summary>
/// 
/// </summary>
namespace ConsoleApp
{
    /// <summary>
    /// Used to count the number of meals within the menu.
    /// </summary>
    class Increment
    {
        private int _counter = 0;

        public Increment()
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
