/**
* Copyright 2011 Julien Salvi
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
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with Mercury. If not, see <http://www.gnu.org/licenses/>.
*/

package android.mercury;

import java.util.HashMap;

import android.app.Activity;
import android.mercury.system.Ping;
import android.mercury.transaction.Lookup;
import android.mercury.transaction.Send;
import android.mercury.user.Getopt;
import android.mercury.user.Info;
import android.mercury.user.Setopt;
import android.mercury.user.Transactions;
import android.mercury.user.Uncache;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TabHost;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.TabHost.TabSpec;

public class MercuryActivity extends Activity {
	
	private TabHost myTabHost;
	private int clientid;
	private String tokenclient;
	private Mercury newMercury;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        myTabHost = (TabHost) findViewById(R.id.TabHost01);
        myTabHost.setup();
        
        TabSpec spec = myTabHost.newTabSpec("ping_call");
        spec.setIndicator("PING");
        spec.setContent(R.id.Ping);
        myTabHost.addTab(spec);
        final EditText textClientID = (EditText) findViewById(R.id.clientID);
        final EditText textToken = (EditText) findViewById(R.id.token);
        ((Button)findViewById(R.id.valid)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				TextView text00 = (TextView) findViewById(R.id.repcode);
				TextView text01 = (TextView) findViewById(R.id.repstatus);
				TextView text02 = (TextView) findViewById(R.id.repmess);
				
				//Collecting the token and client ID for creating a Mercury Object.
				tokenclient = textToken.getText().toString();
				clientid = Integer.parseInt(textClientID.getText().toString());
				
				//Creation of a new Mercury for the whole application.
				newMercury = new Mercury(clientid, tokenclient);
				//Creation of a new PING call.
		        Ping myping = newMercury.ping();
		        
		        //Collecting the data from the API call.
		        text00.setText("Response Code:     "+myping.getResponseCode());
		        text01.setText("Response Status:   "+myping.getResponseStatus().toUpperCase());
		        text02.setText("Message:                 "+myping.getMessage().toUpperCase());
			}
        });
        
        //Add of the new tabs
        TabSpec spec2 = myTabHost.newTabSpec("lookup_call");
        spec2.setIndicator("LOOKUP");
        spec2.setContent(R.id.Lookup);
        myTabHost.addTab(spec2);
        
        final EditText textMessIDlook = (EditText) findViewById(R.id.messidlookup);
        final EditText textHashlook = (EditText) findViewById(R.id.hashlook);
        ((Button)findViewById(R.id.valid2)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				TextView textLook00 = (TextView) findViewById(R.id.repcodelook);
				TextView textLook01 = (TextView) findViewById(R.id.repstatuslook);
				TextView textLook02 = (TextView) findViewById(R.id.repmesslook);
				TextView textLook03 = (TextView) findViewById(R.id.campidlook);
				TextView textLook04 = (TextView) findViewById(R.id.fromnumlook);
				TextView textLook05 = (TextView) findViewById(R.id.fromnamelook);
				TextView textLook06 = (TextView) findViewById(R.id.tonumlook);
				TextView textLook07 = (TextView) findViewById(R.id.tonamelook);
				TextView textLook08 = (TextView) findViewById(R.id.conidlook);
				TextView textLook09 = (TextView) findViewById(R.id.statuslook);
				
				//Initialization of the Key-values essential for doing the API call.
				HashMap<String, String> hash = new HashMap<String, String>();
				hash.put("message_id", textMessIDlook.getText().toString());
				hash.put("hash", textHashlook.getText().toString());
				
				//Creation of a new LOOKUP call.
		        Lookup mylookup = newMercury.lookup(hash);
		        
		        //Collecting the data from the API call.
		        textLook00.setText("Response Code:     "+mylookup.getResponseCode());
		        textLook01.setText("Response Status:   "+mylookup.getResponseStatus().toUpperCase());
		        textLook02.setText("Message:                 "+mylookup.getMessage().toUpperCase());
		        textLook03.setText("Campaign ID:        "+mylookup.getCampaignId());
		        textLook04.setText("From Number:         "+mylookup.getFromName().toUpperCase());
		        textLook05.setText("From Name:              "+mylookup.getFromName().toUpperCase());
		        textLook06.setText("To Number:               "+mylookup.getToNumber());
		        textLook07.setText("To Name:                  "+mylookup.getToName().toUpperCase());
		        textLook08.setText("Content ID:          "+mylookup.getContentId());
		        textLook09.setText("Status:                  "+mylookup.getStatus().toUpperCase());    
			}
        });
        
        TabSpec spec3 = myTabHost.newTabSpec("send_call");
        spec3.setIndicator("SEND");
        spec3.setContent(R.id.Send);
        myTabHost.addTab(spec3);

        final EditText textCampIDsend = (EditText) findViewById(R.id.campidsend);
        final EditText textTosend = (EditText) findViewById(R.id.tosend);
        final EditText textFromsend = (EditText) findViewById(R.id.fromsend);
        final EditText textMessagesend = (EditText) findViewById(R.id.messagesend);
        final EditText textContIDsend = (EditText) findViewById(R.id.conidsend);
        ((Button)findViewById(R.id.valid3)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				TextView textSend00 = (TextView) findViewById(R.id.repcodesend);
				TextView textSend01 = (TextView) findViewById(R.id.repstatussend);
				TextView textSend02 = (TextView) findViewById(R.id.repmesssend);
				TextView textSend03 = (TextView) findViewById(R.id.sendmessid);
				TextView textSend04 = (TextView) findViewById(R.id.sendhash);

				//Initialization of the Key-values essential for doing the API call.
				HashMap<String, String> hash = new HashMap<String, String>();
				hash.put("campaign_id", textCampIDsend.getText().toString());
				hash.put("to", textTosend.getText().toString());
				hash.put("from", textFromsend.getText().toString());
				hash.put("message", textMessagesend.getText().toString());
				hash.put("content_id", textContIDsend.getText().toString());
				
				//Creation of a new SEND call.
				Send mysend = newMercury.send(hash);
				
				//Collecting the data from the API call.
				textSend00.setText("Response Code:     "+mysend.getResponseCode());
		        textSend01.setText("Response Status:   "+mysend.getResponseStatus().toUpperCase());
		        textSend02.setText("Message:                 "+mysend.getMessage().toUpperCase());
		        textSend03.setText("Message ID:         "+mysend.getMessageId());
		        textSend04.setText("Hash:               "+mysend.getHash());
			}	
        });
        
        TabSpec spec4 = myTabHost.newTabSpec("getopt_call");
        spec4.setIndicator("GETOPT");
        spec4.setContent(R.id.Getopt);
        myTabHost.addTab(spec4);

        final EditText textNumGet = (EditText) findViewById(R.id.numget);
        final EditText textCampGet = (EditText) findViewById(R.id.campget);
        ((Button)findViewById(R.id.valid4)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				TextView textGet00 = (TextView) findViewById(R.id.repcodegetopt);
				TextView textGet01 = (TextView) findViewById(R.id.repstatusgetopt);
				TextView textGet02 = (TextView) findViewById(R.id.repmessgetopt);			
				TextView textGet03 = (TextView) findViewById(R.id.campstatuscodeget);
				TextView textGet04 = (TextView) findViewById(R.id.campstatusget);
				
				//Initialization of the Key-values essential for doing the API call.
				HashMap<String, String> hash = new HashMap<String, String>();
				hash.put("number", textNumGet.getText().toString());
				hash.put("campaign_id", textCampGet.getText().toString());
				
				//Creation of a new GETOPT call.
				Getopt mygetopt = newMercury.getopt(hash);
				
				//Collecting the data from the API call.
		        textGet00.setText("Response Code:     "+mygetopt.getResponseCode());
		        textGet01.setText("Response Status:   "+mygetopt.getResponseStatus().toUpperCase());
		        textGet02.setText("Message:                 "+mygetopt.getMessage().toUpperCase());
		        textGet03.setText("Campaign Status Code: "+mygetopt.getCampaignStatusCode(Integer.parseInt(textCampGet.getText().toString())));
		        textGet04.setText("Campaign Status:  "+mygetopt.getCampaignStatus(Integer.parseInt(textCampGet.getText().toString())));
			}
        });
        
        TabSpec spec5 = myTabHost.newTabSpec("info_call");
        spec5.setIndicator("INFO");
        spec5.setContent(R.id.Info);
        myTabHost.addTab(spec5);
        
        final EditText textNumInfo = (EditText) findViewById(R.id.numinfo);
        ((Button)findViewById(R.id.valid5)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				TextView textInfo00 = (TextView) findViewById(R.id.repcodeinfo);
				TextView textInfo01 = (TextView) findViewById(R.id.repstatusinfo);
				TextView textInfo02 = (TextView) findViewById(R.id.repmessinfo);
				TextView textInfo03 = (TextView) findViewById(R.id.infonum);
				TextView textInfo04 = (TextView) findViewById(R.id.infocar);
				TextView textInfo05 = (TextView) findViewById(R.id.infocarid);
				TextView textInfo06 = (TextView) findViewById(R.id.infohand);
				TextView textInfo07 = (TextView) findViewById(R.id.infohandid);

				//Initialization of the Key-values essential for doing the API call.
				HashMap<String, String> hash = new HashMap<String, String>();
				hash.put("number", textNumInfo.getText().toString());
				
				//Creation of a new INFO call.
				Info myinfo = newMercury.info(hash);
				
				//Collecting the data from the API call.
				textInfo00.setText("Response Code: "+myinfo.getResponseCode());
				textInfo01.setText("Response Status: "+myinfo.getResponseStatus().toUpperCase());
				textInfo02.setText("Message: "+myinfo.getMessage().toUpperCase());
				textInfo03.setText("Number: "+myinfo.getNumber());
				textInfo04.setText("Carrier: "+myinfo.getCarrier().toUpperCase());
				textInfo05.setText("Carrier ID: "+myinfo.getCarrierId());
				textInfo06.setText("Handset: "+myinfo.getHandset());
				textInfo07.setText("Handset ID: "+myinfo.getHandsetId());
				
			}	
        });
        
        TabSpec spec6 = myTabHost.newTabSpec("setopt_call");
        spec6.setIndicator("SETOPT");
        spec6.setContent(R.id.Setopt);
        myTabHost.addTab(spec6);

        final EditText textNumSet = (EditText) findViewById(R.id.numset);
        final EditText textCampSet = (EditText) findViewById(R.id.campset);
        final EditText textCodeSet = (EditText) findViewById(R.id.codeset);
        ((Button)findViewById(R.id.valid6)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				TextView textSet00 = (TextView) findViewById(R.id.repcodesetopt);
				TextView textSet01 = (TextView) findViewById(R.id.repstatussetopt);
				TextView textSet02 = (TextView) findViewById(R.id.repmesssetopt);			

				//Initialization of the Key-values essential for doing the API call.
				HashMap<String, String> hash = new HashMap<String, String>();
				hash.put("number", textNumSet.getText().toString());
				hash.put("campaign_id", textCampSet.getText().toString());
				hash.put("status_code", textCodeSet.getText().toString());
				
				//Creation of a new SETOPT call.
				Setopt mysetopt = newMercury.setopt(hash);
		        
				//Collecting the data from the API call.
		        textSet00.setText("Response Code:     "+mysetopt.getResponseCode());
		        textSet01.setText("Response Status:   "+mysetopt.getResponseStatus().toUpperCase());
		        textSet02.setText("Message:                 "+mysetopt.getMessage().toUpperCase());
			}
        });
        
        TabSpec spec7 = myTabHost.newTabSpec("transactions_call");
        spec7.setIndicator("TRANS.");
        spec7.setContent(R.id.Transactions);
        myTabHost.addTab(spec7);
        
        final EditText textNumTrans = (EditText) findViewById(R.id.transacnum);
        ((Button)findViewById(R.id.valid7)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				TextView textT00 = (TextView) findViewById(R.id.repcodetrans);
				TextView textT01 = (TextView) findViewById(R.id.repstatustrans);
				TextView textT02 = (TextView) findViewById(R.id.repmesstrans);

				//Initialization of the Key-values essential for doing the API call.
				HashMap<String, String> hash = new HashMap<String, String>();
				hash.put("number", textNumTrans.getText().toString());
				
				//Creation of a new TRANSACTIONS call.
				Transactions transac = newMercury.transactions(hash);
				
				//Collecting the data from the API call.
				textT00.setText("Response Code:    "+transac.getResponseCode());
				textT01.setText("Response Status:  "+transac.getResponseStatus().toUpperCase());
				textT02.setText("Message:             "+transac.getMessage().toUpperCase());
			}	
        });
        
        TabSpec spec8 = myTabHost.newTabSpec("uncache_call");
        spec8.setIndicator("UNCACHE");
        spec8.setContent(R.id.Uncache);
        myTabHost.addTab(spec8);
        
        final EditText textNumUncache = (EditText) findViewById(R.id.numuncache);
        ((Button)findViewById(R.id.valid8)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				TextView textUnc00 = (TextView) findViewById(R.id.repcodeunc);
				TextView textUnc01 = (TextView) findViewById(R.id.repstatusunc);
				TextView textUnc02 = (TextView) findViewById(R.id.repmessunc);
				TextView textUnc03 = (TextView) findViewById(R.id.uncachenum);
				
				//Initialization of the Key-values essential for doing the API call.
				HashMap<String, String> hash = new HashMap<String, String>();
				hash.put("number", textNumUncache.getText().toString());
				
				//Creation of a new UNCACHE call.
				Uncache uncache = newMercury.uncache(hash);
				
				//Collecting the data from the API call.
				textUnc00.setText("Response Code:    "+uncache.getResponseCode());
				textUnc01.setText("Response Status:  "+uncache.getResponseStatus().toUpperCase());
				textUnc02.setText("Message:             "+uncache.getMessage().toUpperCase());
				textUnc03.setText("Number:              "+uncache.getNumber());
			}	
        });
        
        //Listener to take back the change of tab
        myTabHost.setOnTabChangedListener( new TabHost.OnTabChangeListener() {
			@Override
			public void onTabChanged(String tabId) {
				Toast.makeText(MercuryActivity.this, "Tab: " + tabId + ".", Toast.LENGTH_SHORT).show();
			}
		});               
    }
}