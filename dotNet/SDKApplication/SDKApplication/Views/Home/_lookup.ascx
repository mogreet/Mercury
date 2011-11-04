<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Do a Lookup request</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="messageIdL">Message Id*:</label>
                <%= Html.TextBox("messageIdL") %>
                <%= Html.ValidationMessage("messageIdL", "*") %>
            </p>
            <p>
                <label for="hashL">Hash*:</label>
                <%= Html.TextBox("hashL") %>
                <%= Html.ValidationMessage("hashL", "*") %>
            </p>
            <p>
                <input type="submit" value="Lookup" />
            </p></center>
			<p> <%= ViewData["codeL"] %> </p>
			<p> <%= ViewData["statusRL"] %> </p>
			<p> <%= ViewData["messageL"] %> </p>
			<p> <%= ViewData["campaignIdL"] %> </p>
			<p> <%= ViewData["fromL"] %> </p>
			<p> <%= ViewData["fromNameL"] %> </p>
			<p> <%= ViewData["toL"] %> </p>
			<p> <%= ViewData["toNameL"] %> </p>
			<p> <%= ViewData["contentIdL"] %> </p>
			<p> <%= ViewData["statusL"] %> </p>
			<p> <%= ViewData["eventsL"] %> </p>
			<ul><% if(ViewData["events"] != null) %>
				<% foreach (var item in (List<string>)ViewData["events"]){ %>
				<li>
					<%= item %>
				</li>
			<% } %>
			</ul>
        </fieldset>
<%= Html.Hidden("lookupID", Model.ID) %>

  <% } %>