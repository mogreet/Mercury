<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Do a Getopt request</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="numberGetopt">Number*:</label>
                <%= Html.TextBox("numberGetopt") %>
                <%= Html.ValidationMessage("numberGetopt", "*") %>
            </p>
            <p>
                <label for="campaignIdGetopt">Campaign ID:</label>
                <%= Html.TextBox("campaignIdGetopt") %>
            </p>
            <p>
                <input type="submit" value="Getopt" />
            </p></center>
			<p> <%= ViewData["codeGetopt"] %> </p>
			<p> <%= ViewData["statusGetopt"] %> </p>
			<p> <%= ViewData["messageGetopt"] %> </p>
			<ul><% if(ViewData["campaignsGetopt"] != null) %>
				<% foreach (var item in (List<string>)ViewData["campaignsGetopt"]){ %>
				<li>
					<%= item %>
				</li>
			<% } %>
			</ul>
        </fieldset>
<%= Html.Hidden("getoptID", Model.ID) %>

  <% } %>