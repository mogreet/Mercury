<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Do a Transaction request</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="numberTrans">Number*:</label>
                <%= Html.TextBox("numberTrans") %>
                <%= Html.ValidationMessage("numberTrans", "*") %>
            </p>
            <p>
                <label for="campaignIdTrans">Campaign ID:</label>
                <%= Html.TextBox("campaignIdTrans") %>
            </p>
			 <p>
                <label for="startDateTrans">Start Date:</label>
                <%= Html.TextBox("startDateTrans") %>
            </p>
			 <p>
                <label for="endDateTrans">End Date:</label>
                <%= Html.TextBox("endDateTrans") %>
            </p>
            <p>
                <input type="submit" value="Get Transactions" />
            </p></center>
			<p> <%= ViewData["codeTrans"] %> </p>
			<p> <%= ViewData["statusTrans"] %> </p>
			<p> <%= ViewData["messageTrans"] %> </p>
			<ul><% if(ViewData["transactions"] != null) %>
				<% foreach (var item in (List<string>)ViewData["transactions"]){ %>
				<li>
					<%= item %>
				</li>
			<% } %>
			</ul>
        </fieldset>
<%= Html.Hidden("transactionsID", Model.ID) %>

  <% } %>