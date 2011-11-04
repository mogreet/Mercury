<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Do a Ping request</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center>
            <p>
                <input type="submit" value="Ping" />
            </p></center>
			<p> <%= ViewData["code"] %> </p>
			<p> <%= ViewData["status"] %> </p>
			<p> <%= ViewData["message"] %> </p>
        </fieldset>
<%= Html.Hidden("pingID", Model.ID)%>
  <% } %>

