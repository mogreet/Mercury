<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

			
<h3>Create a Mercury Object</h3>




    <% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="clientId">Client Id*:</label>
                <%= Html.TextBox("clientId") %>
                <%= Html.ValidationMessage("clientId", "*") %>
            </p>
            <p>
                <label for="token">Token*:</label>
                <%= Html.TextBox("token") %>
                <%= Html.ValidationMessage("token", "*") %>
            </p>
            <p>
                <input type="submit" value="Create" />
            </p>
			<p> <%= ViewData["mercury"] %> </p></center>
        </fieldset>
<%= Html.Hidden("mercuryID", Model.ID)%>


  <% } %>
