<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Do an Uncache request</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="numberUncache">Number*:</label>
                <%= Html.TextBox("numberUncache") %>
                <%= Html.ValidationMessage("numberUncache", "*") %>
            </p>
            <p>
                <input type="submit" value="Uncache" />
            </p></center>
			<p> <%= ViewData["codeUncache"] %> </p>
			<p> <%= ViewData["statusUncache"] %> </p>
			<p> <%= ViewData["messageUncache"] %> </p>
			<p> <%= ViewData["numberUncache"] %> </p>
        </fieldset>
<%= Html.Hidden("uncacheID", Model.ID) %>

  <% } %>