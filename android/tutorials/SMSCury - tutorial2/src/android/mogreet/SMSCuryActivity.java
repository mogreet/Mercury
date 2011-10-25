/**
* Copyright 2011 Julien SALVI
* 
* SMSCury version 1.1
*
* SMSCury is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with SMSCury. If not, see <http://www.gnu.org/licenses/>.
*/

package android.mogreet;

import java.util.HashMap;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.mercury.*;
import android.mercury.transaction.Send;

public class SMSCuryActivity extends Activity {
	
	private Mercury mercury;
	private int clientID;
	private String token;
	private String campaignID;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        LayoutInflater factory = LayoutInflater.from(this);
        final View alertDialogView = factory.inflate(R.layout.login_dialog, null);
 
        //Creation of the AlertDialog to collect the needed data.
        AlertDialog.Builder adb = new AlertDialog.Builder(this);
        adb.setView(alertDialogView);
        adb.setTitle("Log in");
        adb.setIcon(android.R.drawable.ic_dialog_info);
 
        //When you validate your status
        adb.setPositiveButton("Ok", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
            	EditText clientValue = (EditText)alertDialogView.findViewById(R.id.clientfield);
            	EditText tokenValue = (EditText)alertDialogView.findViewById(R.id.tokenfield);
            	EditText campidValue = (EditText)alertDialogView.findViewById(R.id.campidfield);
            	
            	//Getting the token, client ID and campaign ID from the AlertDialog
            	clientID = Integer.parseInt(clientValue.getText().toString());
            	token = tokenValue.getText().toString();
            	campaignID = campidValue.getText().toString();
            	
            	//Creation of a new Mercury object with your client ID and your token.
                mercury = new Mercury(clientID, token);  

          } });
 
        //Quit the application.
        adb.setNegativeButton("Quit", new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
            	SMSCuryActivity.this.finish();
          } });
        adb.show();
    }

    /**
     * Creates the menu.
     */
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		super.onCreateOptionsMenu(menu);
		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.menu, menu);
		return true;
	}
    
	/**
	 * Listener on the menu item.
	 */
    @Override
	public boolean onOptionsItemSelected(MenuItem item) {
		super.onOptionsItemSelected(item);
		switch (item.getItemId()) {
		case R.id.send_message:
			/////////////////////////////
			// Request for sending SMS //
			/////////////////////////////
			sendMessage(campaignID);
			return true;
		}
		return false;
	}

    /**
     * Send a SMS to a 10-digit number thanks to Mercury SDK.
     */
	private void sendMessage(String campaignID) {
		//Creation of the TextFields and TextView
		EditText toNumber = (EditText) findViewById(R.id.toNumField);
		EditText fromNumber = (EditText) findViewById(R.id.fromNumField);
		EditText messageSMS = (EditText) findViewById(R.id.messageField);
		TextView responseSMS = (TextView) findViewById(R.id.smsMessage);
		
		//Collecting data to make the SEND call.
		HashMap<String, String> hash = new HashMap<String, String>();
		hash.put("campaign_id", campaignID);
		hash.put("from", fromNumber.getText().toString());
		hash.put("to", toNumber.getText().toString());
		hash.put("message", messageSMS.getText().toString());
		
		if (fromNumber.getText().toString().matches(".*[0-9]{10}.*") == false || toNumber.getText().toString().matches(".*[0-9]{10}.*") == false) {
			setAlert("Warning!", "Numbers have to be a 10-digits number", false);
			fromNumber.requestFocus();
		} else {
			//Sending request to the Mogreet API: SMS sent.
			Send sendMess = mercury.send(hash);
			
			responseSMS.setText("\n\nMessage delivered: "+sendMess.getMessage().toString());
		}
	}
	
	/**
	 * Warning alert when the phone fields are empty.
	 */
	private void setAlert(String title, String msg, final boolean finishActivity) {
    	new AlertDialog.Builder(this)
		.setTitle(title)
		.setMessage(msg)
		.setNeutralButton("Ok", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int which) {
				// Finish the activity when "Ok" is pressed
				if (finishActivity) SMSCuryActivity.this.finish();
			}
		}).show();
    }
}