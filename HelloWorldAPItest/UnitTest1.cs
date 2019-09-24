using HelloWorldAPI.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace HelloWorldAPItest
{
    public class UnitTest1
    {
        [Fact]
        public void TestGetValuesTest()
        {
            ValuesController vc = new ValuesController();
            IEnumerable<string> t = vc.Get().Value;
            var arr = t.Select(a => a).ToArray();
            Assert.True(arr != null && arr.Length == 2 && arr[0] == "Hello" && arr[1] == "world");
        }

        [Fact]
        public void TestGetValuesTestWithFilter()
        {
            ValuesController vc = new ValuesController();
            IEnumerable<string> t = vc.Get("he").Value;
            var arr = t.Select(a => a).ToArray();
            Assert.True(arr != null && arr.Length == 1 && arr[0] == "Hello");
        }


        [Theory]
        [InlineData(1)]
        [InlineData(22)]
        public void TestGetValue(int id)
        {
            ValuesController vc = new ValuesController();
            Assert.Equal($"Hello {id}!", vc.Get(id).Value);
        }
    }
}
