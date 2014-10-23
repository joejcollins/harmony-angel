using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp
{
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
