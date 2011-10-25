/**
* Copyright 2011 Jonathan Perichon <jonathan.perichon@gmail.com>
*
* This file is part of Mercury.
*
* Mercury is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Mercury is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury.  If not, see <http://www.gnu.org/licenses/>.
*/

// tabs' names and fields declaration
var tabs = new Array();
tabs['ping'] = [ ];
tabs['transactions'] = [ 'number', 'campaign_id', 'start_date', 'end_date' ];
tabs['info'] = [ 'number' ];
tabs['uncache'] = [ 'number' ];
tabs['setopt'] = [ 'number', 'campaign_id', 'status_code' ];
tabs['getopt'] = [ 'number', 'campaign_id' ];
tabs['lookup'] = [ 'message_id', 'hash' ];
tabs['send'] = [ 'campaign_id', 'to', 'from', 'message', 'content_id', 'content_url', 'callback', 'udp' ];

$(function() {
    // forms declaration
    $('body').append("<div id='tabs'>");
    $('#tabs').append("<ul id='listTabs'>");
    for (var tab in tabs) {
        $('#listTabs').append("<li><a href='#tab-" + tab + "' >" + tab.toUpperCase() + "</a></li>");    
    }
    $('#tabs').append("</ul>");
    for (var tab in tabs) {
        $('#tabs').append("<div id='tab-" + tab + "'>");

        for (var i=0; i<tabs[tab].length; i++) {
            field = tabs[tab][i];
            $('#tab-'+tab).append("<input id='"+tab+"-"+field+"' name='"+field+"' "+
            "class='status text ui-widget-content ui-corner-all' value='"+field+"' type='text'/><br/><br/>");
        }

        $('#tab-'+tab).append("<input id='"+tab+"-submit' value='Call "+tab+"' type='submit'/>");
        $('#tab-'+tab).append("<div id='"+tab+"-results' class='results'></div></div>");
    }

    // tabs creation
    $("#tabs").tabs();

    // setting up button ui
    $("input:submit", "#tabs").button();
    $("input:submit", "#form").button();

    // input highlighted
    $('input[type="text"]').addClass("idleField");
    $('input[type="text"]').focus(function() {
        $(this).removeClass("idleField").addClass("focusField");
        if (this.value == this.defaultValue){
            this.value = '';
        }
        if(this.value != this.defaultValue){
            this.select();
        }
    });

    // input back to normal
    $('input[type="text"]').blur(function() {
        $(this).removeClass('focusField').addClass('idleField');
        if ($.trim(this.value) == ''){
            this.value = (this.defaultValue ? this.defaultValue : '');
        }
    });

    // click on submit buttons invoke the AJAX request 
    $('#ping-submit').click(function() { process('ping'); });
    $('#send-submit').click(function() { process('send'); });
    $('#lookup-submit').click(function() { process('lookup'); });
    $('#getopt-submit').click(function() { process('getopt'); });
    $('#setopt-submit').click(function() { process('setopt'); });
    $('#uncache-submit').click(function() { process('uncache'); });
    $('#info-submit').click(function() { process('info'); });
    $('#transactions-submit').click(function() { process('transactions'); });

    $('#tabs').hide();

    $('#form').dialog({
        autoOpen: false,
        height: 300,
        width: 350,
        title: 'Login - Mercury for PHP Example',
        modal: true,
        closeOnEscape: false,
        open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); },
        buttons: {
                "Log in": function() {
                    client_id = $('#client_id').val();
                    token = $('#token').val();
                    login(client_id, token);
                }
        },
    });

    $('#tabs').dialog({
        autoOpen: false,
        height: 650,
        width: 608,
        title: 'Mercury for PHP Example',
        modal: true,
        closeOnEscape: false,
        open: function(event, ui) { $(".ui-dialog-titlebar-close").hide(); },
        buttons: {
                "Clear results": function() { clear(getSelectedTabId()); },
                "Log out": function() { logout(); }
        },
    });
    isLoggedIn();
});

function getSelectedTabId() {
    selected = $('#tabs').tabs('option', 'selected');
    name = $($('#tabs').children()[selected + 1]).attr('id');
    name = name.substr(4);
    return name;
}

function getResultsDivId(tab) {
    return '#' + tab + '-' + 'results';
}


function clear(tab) {
    parentDiv = '#tab-' + tab + ' > input[type="text"]';
    $(parentDiv).each(function() {
        this.value = this.defaultValue;
    });
    $(getResultsDivId(tab)).empty();
}

// process the action by preparing params and doing the actual request
function process(action) {
    params = 'action=' + encodeURIComponent(action);
    for (var i=0; i<tabs[action].length; i++) {
        name = '#' + action + '-' + tabs[action][i];
        value = $(name).val();

        // adds the parameter only if the value is different of the default value
        if (value != $(name)[0].defaultValue) {
            params += '&' + encodeURIComponent(tabs[action][i]) + '=' + encodeURIComponent(value);
        }
    }
    request(params);
}

function request(params) {
    resultsDiv = getResultsDivId(getSelectedTabId()); 

    $(resultsDiv).css('text-align', 'center');
    $(resultsDiv).html("<img src='./ui/loader.gif' />");
    
    $.ajax({
        url: 'request.php',
        type: 'POST',
        data: params,
        cache: false,
        success: function (html) {
            $('#form').hide();
            $(resultsDiv).fadeIn('slow', function() {
                $(resultsDiv).css('text-align', 'left');
                $(resultsDiv).html(html);
            });
        }
    });
}

function login(login, token) {
    params = 'action=LOGIN&client_id=' + encodeURIComponent(login) + '&token=' + encodeURIComponent(token);
    $('#error').html("<img src='./ui/loader.gif' />");

    $.ajax({
        url: 'request.php',
        type: 'POST',
        data: params,
        cache: false,
        success: function (html) {
            $('#error').html('');
            $('#form').dialog("close");
            $('#tabs').dialog("open");
        },

        error: function() {
            $('#error').html("<div class='error'>Login failed</div>");
        }
    });
}

function logout() {
    // clear all results
    for (var tab in tabs) {
        clear(tab);
    }
    // select the first tab
    $('#tabs').tabs("select", 0);

    params = 'action=LOGOUT';
    $.ajax({
        url: 'request.php',
        type: 'POST',
        data: params,
        cache: false,
        success: function (html) {
            $('#tabs').dialog('close');
            $('#form').dialog("open");
        }
    });
}

function isLoggedIn() {
    params = 'action=TESTLOGIN';
    $.ajax({
        url: 'request.php',
        type: 'POST',
        data: params,
        cache: false,
        success: function (html) {
            $('#form').dialog("close");
            $('#tabs').dialog('open');
        },

        error: function() {
            $('#tabs').dialog('close');
            $('#form').dialog('open');
        }
    });
}

