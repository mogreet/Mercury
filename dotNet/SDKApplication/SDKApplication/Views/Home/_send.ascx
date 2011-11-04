<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<SDKApplication.Models.tabViewModel>" %>

<h3>Send a SMS or a MMS</h3>

<% using (Html.BeginForm("Index","Home"))%>
 <% { %>
        <fieldset>
            <center><p>
                <label for="campaignId">Campaign Id*:</label>
                <%= Html.TextBox("campaignId") %>
                <%= Html.ValidationMessage("campaignId", "*") %>
            </p>
            <p>
                <label for="from">From Number*:</label>
                <%= Html.TextBox("from") %>
                <%= Html.ValidationMessage("from", "*") %>
            </p>
			<p>
                <label for="messageSend">Message*:</label>
                <%= Html.TextBox("messageSend") %>
                <%= Html.ValidationMessage("messageSend", "*") %>
            </p>
			<p>
                <label for="to">To Number*:</label>
                <%= Html.TextBox("to") %>
                <%= Html.ValidationMessage("to", "*") %>
            </p>
			<p>
                <label for="contentId">Content Id (If you would like to send a MMS):</label>
                <%= Html.TextBox("contentId") %>
            </p>
			<p>
                <label for="toName">To Name:</label>
                <%= Html.TextBox("toName") %>
            </p>
			<p>
                <label for="fromName">From Name:</label>
                <%= Html.TextBox("fromName") %>
            </p>
			<p>
                <label for="udp">User Defined Parameter:</label>
                <%= Html.TextBox("udp") %>
            </p>
            <p>
                <input type="submit" value="Send" />
            </p></center>
			<p> <%= ViewData["codeSend"] %> </p>
			<p> <%= ViewData["statusSend"] %> </p>
			<p> <%= ViewData["messageRSend"] %> </p>
			<p> <%= ViewData["hashSend"] %> </p>
			<p> <%= ViewData["messageIdSend"] %> </p>
        </fieldset>
<%= Html.Hidden("sendID", Model.ID) %>

  <% } %>
