<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Do a Setopt request</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="numberSetopt">Number*:</label>
                <%= Html.TextBox("numberSetopt") %>
                <%= Html.ValidationMessage("numberSetopt", "*") %>
            </p>
            <p>
                <label for="campaignIdSetopt">Campaign ID*:</label>
                <%= Html.TextBox("campaignIdSetopt") %>
	            <%= Html.ValidationMessage("campaignIdSetopt", "*") %>
            </p>
			<p>
                <label for="statusCodeSetopt">Status Code*:</label>
                <%= Html.TextBox("statusCodeSetopt") %>
	            <%= Html.ValidationMessage("statusCodeSetopt", "*") %>
            </p>
            <p>
                <input type="submit" value="Setopt" />
            </p></center>
			<p> <%= ViewData["codeSetopt"] %> </p>
			<p> <%= ViewData["statusRSetopt"] %> </p>
			<p> <%= ViewData["messageSetopt"] %> </p>
			<p> <%= ViewData["campaignIdSetopt"] %> </p>
			<p> <%= ViewData["statusCodeSetopt"] %> </p>
			<p> <%= ViewData["statusSetopt"] %> </p>
        </fieldset>
<%= Html.Hidden("setoptID", Model.ID) %>

  <% } %>