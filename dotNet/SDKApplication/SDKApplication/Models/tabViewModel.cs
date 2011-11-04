using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SDKApplication.Models
{
    public class tabViewModel
    {
        private Object _ParentModel;
        public Object ParentModel
        {
            get { return _ParentModel; }
            set
            {
                _ParentModel = value;
            }
        }
        private string _ID;
        public string ID
        {
            get { return _ID; }
            set
            {
                _ID = value;
            }
        }
    }
}