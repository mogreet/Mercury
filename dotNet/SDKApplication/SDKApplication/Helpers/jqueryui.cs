using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TabExample.Helpers
{     
   public static class jQueryUiHelper
    {
        public static string InsertIcon(string iconName) 
        {
			
            return string.Format("<span class='ui-icon ui-{0}' style='float: left; margin-right: .2em;\'></span>"
                ,iconName);      
        }
    }
}
