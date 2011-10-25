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
tabs['ping'] = [ 'client_id', 'token' ];
tabs['transactions'] = [ 'client_id', 'token', 'number', 'campaign_id', 'start_date', 'end_date' ];
tabs['info'] = [ 'client_id', 'token', 'number' ];
tabs['uncache'] = [ 'client_id', 'token', 'number' ];
tabs['setopt'] = [ 'client_id', 'token', 'number', 'campaign_id', 'status_code' ];
tabs['getopt'] = [ 'client_id', 'token', 'number', 'campaign_id' ];
tabs['lookup'] = [ 'client_id', 'token', 'message_id', 'hash' ];
tabs['send'] = [ 'client_id', 'token', 'campaign_id', 'to', 'from', 'message', 'content_id', 
                 'content_url', 'callback', 'udp' ];

$(function() {
    // forms declaration
    $('body').append("<div id='tabs'>");
    $('#tabs').append("<ul id='listTabs'>");
    for (var tab in tabs) {
        $('#listTabs').append("<li><a href='#tab-" + tab + "'>" + tab.toUpperCase() + "</a></li>");    
    }
    $('#tabs').append("</ul>");
    for (var tab in tabs) {
        $('#tabs').append("<div id='tab-" + tab + "'>");

        for (var i=0; i<tabs[tab].length; i++) {
            field = tabs[tab][i];
            $('#tab-'+tab).append("<input id='"+tab+"-"+field+"' name='"+field+"' "+
            "class='status text ui-widget-content ui-corner-all' value='"+field+"' type='text'/><br/><br/>");
        }

        $('#tab-'+tab).append("<input id='"+tab+"-submit' value='Submit' type='submit'/>");
        $('#tab-'+tab).append("<input id='"+tab+"-clear' name='clear' value='Clear' type='submit'/><br/><br/>");
        $('#tab-'+tab).append("<div id='"+tab+"-results' class='results'></div></div>");
    }
    // tabs creation
    $("#tabs").tabs();

    // setting up button ui
    $("input:submit", "#tabs").button();

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

    // click on clear buttons
    $('input:submit[name=clear]').click(function() {
        resultsDiv = getSelectedTabId();
        parentDiv = '#tab-' + resultsDiv + ' > input[type="text"]';
        $(parentDiv).each(function() {
            this.value = this.defaultValue;
        });
       $(getCurrentResultsDivId()).empty();
       $("input[name='client_id']").each(function() {
           this.value = this.defaultValue;
       });
       $("input[name='token']").each(function() {
           this.value = this.defaultValue;
      });
    });
});

// gets the Id of the selected tab
function getSelectedTabId() {
    selected = $('#tabs').tabs('option', 'selected');
    name = $($('#tabs').children()[selected + 1]).attr('id');
    name = name.substr(4);
    return name;
}

function getCurrentResultsDivId() {
    return '#' + getSelectedTabId() + '-' + 'results';
}

// build params encoded string from an array of params
function setParams(action, paramsList) {
    hash = new Array();
    for (var i=0; i<paramsList.length; i++) {
        name = '#' + action + '-' + paramsList[i];
        value = $(name).val();
        if (value != $(name)[0].defaultValue) {
            hash[paramsList[i]] = value;
        }
    }
    params = 'action=' + encodeURIComponent(action);
    for (var i in hash) {
        params += '&' + encodeURIComponent(i) + '=' + encodeURIComponent(hash[i]);
    }
    return params;
}

// process the action by preparing params and doing the actual request
function process(action) {
    params = setParams(action, tabs[action]);
    client_id = $('#'+action+'-client_id').val();
    token = $('#'+action+'-token').val();
    $("input[name='client_id']").each(function() {
            this.value = client_id;
    });
    $("input[name='token']").each(function() {
            this.value = token;
    });
    request(params);
}

// AJAX request
function request(params) {
    resultsDiv = getCurrentResultsDivId(); 
    $.ajax({
        url: 'request.php',
        type: 'POST',
        data: params,
        cache: false,
        
        success: function (html) {
                $(resultsDiv).fadeOut('slow', function() {
                    $(resultsDiv).html(html);
                    $(resultsDiv).fadeIn('slow');
                });
        },

        error: function () {
            alert('request failed');
        }
    });
}
