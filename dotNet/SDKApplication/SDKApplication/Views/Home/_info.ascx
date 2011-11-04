<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Do an Info request</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="numberInfo">Number*:</label>
                <%= Html.TextBox("numberInfo") %>
                <%= Html.ValidationMessage("numberInfo", "*") %>
            </p>
            <p>
                <input type="submit" value="Get Info" />
            </p></center>
			<p> <%= ViewData["codeInfo"] %> </p>
			<p> <%= ViewData["statusInfo"] %> </p>
			<p> <%= ViewData["messageInfo"] %> </p>
			<p> <%= ViewData["numberInfo"] %> </p>
			<p> <%= ViewData["carrierIdInfo"] %> </p>
			<p> <%= ViewData["carrierInfo"] %> </p>
			<p> <%= ViewData["handsetIdInfo"] %> </p>
			<p> <%= ViewData["handsetInfo"] %> </p>
        </fieldset>
<%= Html.Hidden("infoID", Model.ID) %>

  <% } %>