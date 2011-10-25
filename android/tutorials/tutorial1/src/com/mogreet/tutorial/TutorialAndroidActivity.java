/**
* Copyright 2011 Julien SALVI
*
* Tutorial to learn how to the Mogreet SDK: Mercury.
*/

package com.mogreet.tutorial;

import android.app.Activity;
import android.mercury.Mercury;
import android.mercury.system.Ping;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class TutorialAndroidActivity extends Activity {
	
	private int clientid;
	private String token;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        //Creation of the texfields and textView
        final EditText textClientID = (EditText) findViewById(R.id.clientID);
        final EditText textToken = (EditText) findViewById(R.id.token);
        final TextView text00 = (TextView) findViewById(R.id.repcode);
		final TextView text01 = (TextView) findViewById(R.id.repstatus);
		final TextView text02 = (TextView) findViewById(R.id.repmess);
		
        ((Button)findViewById(R.id.valid)).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				
				//Collecting the token and client ID for creating a Mercury Object.
				token = textToken.getText().toString();
				clientid = Integer.parseInt(textClientID.getText().toString());
				
				//Creation of a new Mercury for the whole application.
				Mercury newMercury = new Mercury(clientid, token);
				//Creation of a new PING call.
		        Ping myping = newMercury.ping();
		        
		        //Collecting the data from the API call.
		        text00.setText("Response Code:     "+myping.getResponseCode());
		        text01.setText("Response Status:   "+myping.getResponseStatus().toUpperCase());
		        text02.setText("Message:                 "+myping.getMessage().toUpperCase()+"\n...connection established...");
			}
        });
    }
}