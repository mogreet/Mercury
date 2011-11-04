<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<SDKApplication.Models.tabViewModel>" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="headerStuff" ContentPlaceHolderID="headerContent" runat="server">
    
    <script type="text/javascript">
        $(document).ready(function () {
            $("#tabs").tabs();
            if(<%=ViewData["init"]%> != 1){
               $("#tabs").tabs("option", "disabled", [1,2,3,4,5,6,7,8]);
            }; 
            if(<%=ViewData["init"]%> == 1){
               $("#tabs").tabs("option", "disabled", []);
            }; 
            $("#tabs").tabs("select", <%=ViewData["tabID"]%>);
        });  
	</script>
	
</asp:Content>


<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
     <h2>Mogreet SDK</h2>
    
    <div id="tabs">
	    <ul>
		    <li><a href="#mercury">Mercury</a></li>
		    <li><a href="#ping">Ping</a></li>
		    <li><a href="#send">Send</a></li>
			<li><a href="#lookup">Lookup</a></li>
			<li><a href="#getopt">Getopt</a></li>
		    <li><a href="#setopt">Setopt</a></li>
		    <li><a href="#uncache">Uncache</a></li>
			<li><a href="#info">Info</a></li>
			<li><a href="#transactions">Transactions</a></li>
		</ul>
	    <div id="mercury">
            <% Html.RenderPartial("_mercury", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "mercury" });  %>		    
	    </div>
	    <div id="ping">
	        <% Html.RenderPartial("_ping", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "ping" });  %>		    
	    </div>
	    <div id="send">
	        <% Html.RenderPartial("_send", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "send" });  %>		    
	    </div>
		<div id="lookup">
	        <% Html.RenderPartial("_lookup", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "lookup" });  %>		    
	    </div>
		<div id="getopt">
	        <% Html.RenderPartial("_getopt", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "getopt" });  %>		    
	    </div>
	    <div id="setopt">
	        <% Html.RenderPartial("_setopt", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "setopt" });  %>		    
	    </div>
		<div id="uncache">
	        <% Html.RenderPartial("_uncache", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "uncache" });  %>		    
	    </div>
		<div id="info">
	        <% Html.RenderPartial("_info", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "info" });  %>		    
	    </div>
		<div id="transactions">
	        <% Html.RenderPartial("_transactions", new SDKApplication.Models.tabViewModel { ParentModel = Model, ID = "transactions" });  %>		    
	    </div>
    </div>   
</asp:Content>

