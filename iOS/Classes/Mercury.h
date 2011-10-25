/**
 *  Mercury.h
 *  Mercury_iOS
 *
 *  Created by Julien Salvi on 9/12/11.
 *  Copyright 2011 Mogreet Inc. All rights reserved.
 *
 *  This file is part of Mercury.
 *
 *  Mercury is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Mercury is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Mercury. If not, see <http://www.gnu.org/licenses/>. 
 */

#import <Foundation/Foundation.h>
#import "TouchXML.h"

#import "Ping.h"
#import "Lookup.h"
#import "Send.h"
#import "Getopt.h"
#import "Info.h"
#import "Setopt.h"
#import "Transactions.h"
#import "Uncache.h"

/**
 * The Mercury is an object that allows to execute three types of requests (system, user and transaction) to the MoMS API.
 */
@interface Mercury : NSObject {
	
@private int clientId;
@private NSString *token;

}

/**
 * Constructs a new Mercury with two parameters.
 * @param clientID The Client ID
 * @param tokenM The Token
 */
- (id) initMercury:(int)clientID withToken:(NSString*)tokenM;

/**
 * Returns a URL format string created with NSMutableDictionary key-value pairs.
 * @param hash List of parameters value-key pairs.
 * @return URL format string: param1=value1&param2=value2&param3=value3&...
 */
- (NSString*) setParams:(NSMutableDictionary*)hash;

/**
 * Checks if the parameters in paramsList are the keys in hash.
 * @param hash List of parameters value-key pairs
 * @param paramsList Array of parameters names
 * @return True if all parameters in the list are the keys in hash, else false
 */
- (BOOL) checkInputParams:(NSMutableArray*)paramsList andHash:(NSMutableDictionary*)hash;

/**
 * Tests connectivity to the MoMS API servers.<br />
 * <pre>
 * <b>Code sample:</b>
 * Ping *newPing = [[Ping alloc] init];
 * newPing = [mercury ping];
 * </pre>
 * @return A new Ping response object
 */
- (Ping*) ping;

/**
 * Returns the info, status and history of the requested transaction.
 * <pre>
 * <b>Code sample:</b>
 * NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
 * [hash setObject:@"xxxxxxxx" forKey:@"message_id"];
 * [hash setObject:@"xxxxxxxx" forKey:@"hash"];
 * Lookup *newLook = [[Lookup alloc] init];
 * newLook = [mercuryLook lookup:hash];
 * </pre>
 * @param hash A NSMutableDictionary object that must contains the following keys with their corresponding value:
 * <ul>
 * <li> "message_id" &rarr; "...": <i>An ID returned from a {@link #send} or from {@link #transactions} method.</i>
 * <li> "hash" &rarr; "...": <i>A hash returned from a {@link #send} or from a {@link #transactions} method.</i>
 * </ul>
 * @return A new Lookup response object
 */
- (Lookup*) lookup:(NSMutableDictionary*)paramLook;

/**
 * Initiates a transaction and delivery of an SMS or MMS.
 * <pre>
 * <b>Code sample:</b>
 * Send *mySend = [[Send alloc] init];
 * NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
 * [hash setObject:@"xxxx" forKey:@"campaign_id"];
 * [hash setObject:@"xxxxxxxxxx" forKey:@"from"];
 * [hash setObject:@"xxxxxxxxxx" forKey:@"to"];
 * [hash setObject:@"Hello there!" forKey:@"message"];
 * [hash setObject:@"xxxx" forKey:@"content_id"];
 * mySend = [mercury send:hash]; 
 * </pre>
 * @param hash A NSMutableDictionary object that must contain the following keys with their corresponding value:
 * <ul>
 * <li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
 * <li> "to" &rarr; "...": <i>A 10-digit mobile phone number.</i>
 * <li> "from" &rarr; "...": <i>A 10-digit mobile phone number.</i>
 * <li> "message" &rarr; "...": <i>Depending on your campaign set up, the message presented to the "to" user.</i>
 * <li> "content_id" &rarr; "...": <i>An ID associated to the content being sent (optional - depending on your campaign set up, this parameter may be required).</i>
 * <li> OR "content_url" &rarr; "...": <i>An URL content for users who host their own content</i>
 * </ul>
 * The NSMutableDictionary can also contain the following optionnal key-value pairs:
 * <ul>
 * <li> "to_name" &rarr; "...": <i>A name associated to the "to" mobile number (if not included will be set to "to" mobile number).</i>
 * <li> "from_name" &rarr; "...": <i>A name associated to the "from" mobile number (if not included will be set to "from" mobile number).</i>
 * <li> "udp_*" &rarr; "...": <i>User Defined Parameter. Clients can pass in any number of udp_* parameters for message flow customization.</i>
 * </ul>
 * @return A new Send response object
 */
- (Send*) send:(NSMutableDictionary*)paramSend;

/**
 * Returns the opt in status of any mobile number.
 * <pre>
 * <b>Code sample:</b>
 * Getopt *newGet = [[Getopt alloc] init];
 * NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
 * [hash setObject:@"xxxxxxxxxx" forKey:@"number"];
 * [hash setObject:@"xxxxx" forKey:@"campaign_id"];
 * newGet = [mercuryGet getopt:hash];
 * </pre>
 * @param hash A NSMutableDictionary object that must contains the following keys with their corresponding value:
 * <ul>
 * <li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
 * </ul>
 * The NSMutableDictionary can also contain the following optionnal key-value pairs:
 * <ul>
 * <li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all opt in statuses for the client's campaigns.</i>
 * </ul>
 * @return A new Getopt response object
 */
- (Getopt*) getopt:(NSMutableDictionary*)paramGet;

/**
 * Returns the user carrier and handset info if available.
 * <pre>
 * <b>Code sample:</b>
 * Info *newInfo = [[Info alloc] init];
 * NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
 * [hash setObject:@"xxxxxxxxxx" forKey:@"number"];
 * newInfo = [mercuryInfo info:hash]; 
 * </pre>
 * @param hash A NSMutableDictionary object that must contains the following key with its corresponding value:
 * <ul>
 * <li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
 * </ul>
 * @return A new Info response object
 */
- (Info*) info:(NSMutableDictionary*)paramInfo;

/**
 * Sets the opt in status of any mobile number.
 * <pre>
 * <b>Code sample:</b>
 * Setopt *newSet = [[Setopt alloc] init];
 * NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
 * [hash setObject:@"xxxxxxxxxx" forKey:@"number"];
 * [hash setObject:@"xxxxx" forKey:@"campaign_id"];
 * [hash setObject:@"xx" forKey:@"status_code"];
 * newSet = [mercurySet setopt:hash]; 
 * </pre>
 * @param hash A NSMutableDictionary object that must contains the following keys with their corresponding value:
 * <ul>
 * <li> "number" &rarr; "...": <i>A 10-digit mobile phone number.</i>
 * <li> "campaign_id" &rarr; "...": <i>An ID connected to a specific campaign setup in the Campaign Manager or provided by your account representative.</i>
 * <li> "status_code" &rarr; "...": <i>See the bellow table for available codes to use here.</i>
 * </ul>
 *
 * <table border="1">
 * <tr>
 * <td>Status</td>
 * <td>Status code</td>
 * <td>Description</td>
 * </tr>
 * <tr>
 * <td>OPTEDIN</td>
 * <td>1</td>
 * <td>User is opted into the campaign</td>
 * </tr>
 * <tr>
 * <td>OPTEDOUT</td>
 * <td>-2</td>
 * <td>User is opted out of the campaign</td>
 * </tr>
 * </table>
 * <br />
 * @return A new Setopt response object
 */
- (Setopt*) setopt:(NSMutableDictionary*)paramSet;

/**
 * Returns the user's transactions (open and closed).
 * <pre>
 * <b>Code sample:</b>
 * Transactions *newTrans = [[Transactions alloc] init];
 * NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
 * [hash setObject:@"xxxxxxxxxx" forKey:@"number"];
 * newTrans = [mercuryTrans transactions:hash];
 * </pre>
 * @param hash A NSMutableDictionary object that must contains the following key with its corresponding value:
 * <ul>
 * <li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
 * </ul>
 * The NSMutableDictionary can also contain the following optionnal key-value pairs:
 * <ul>
 * <li> "campaign_id" &rarr; "...": <i>A campaign id to search on, if excluded, returns all transactions for the client's campaigns.</i>
 * <li> "start_date" &rarr; "...": <i>Narrow search by adding a date to start searching on (YYYY-MM-DD).</i>
 * <li> "end_date" &rarr; "...": <i>Narrow search by adding a date to stop searching on (YYYY-MM-DD).</i>
 * </ul>
 * @return A new Transactions response object
 */
- (Transactions*) transactions:(NSMutableDictionary*)paramTrans;

/**
 * Clears the user carrier and handset info from the Mogreet cache.
 * <pre>
 * <b>Code sample:</b>
 * Uncache *newUncache = [[Uncache alloc] init];
 * NSMutableDictionary *hash = [[NSMutableDictionary alloc] init];
 * [hash setObject:@"xxxxxxxxxx" forKey:@"number"];
 * newUncache = [mercuryUn uncache:hash];
 * </pre>
 * @param hash A NSMutableDictionary object that must contains the following key with its corresponding value:
 * <ul>
 * <li> "number" &rarr; "...": <i>A 10-digit phone number.</i>
 * </ul>
 * @return A new Uncache response object
 */
- (Uncache*) uncache:(NSMutableDictionary*)paramUn;

@end
