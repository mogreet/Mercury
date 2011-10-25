/**
 *  Transactions.h
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

/**
 * The Transactions object contains the response from a {@link Mercury#transactions} request to the MoMS API.
 */
@interface Transactions : NSObject {
	
@private NSString *message;
@private NSString *responseStatus;
@private int responseCode;
@private NSMutableArray *campaignNames;
@private NSMutableArray *campaignIDs;
@private NSMutableArray *hashs;
@private NSMutableArray *messageIDs;
@private NSMutableArray *fromNumbers;
@private NSMutableArray *toNumbers;
@private NSMutableArray *fromNames;
@private NSMutableArray *toNames;

}

/**
 * initializes a new Transactions response object.
 * @param urlTrans URL for calling requests from Mogreet API.
 */
- (void) initTransactions:(NSString*)urlTrans;

/**
 * Checks if the response code is 1.
 * @return YES if the response code is 1, NO if it is not
 */
- (BOOL) responseIsValid;

/**
 * @return The response Code.
 */
- (int) getResponseCode;

/**
 * @return The response Status.
 */
- (NSString*) getResponseStatus;

/**
 * @return The message.
 */
- (NSString*) getMessage;

/**
 * @return An NSMutableArray of all the campaign Names.
 */
- (NSMutableArray*) getCampaignNames;

/**
 * @return An NSMutableArray of all the campaign IDs.
 */
- (NSMutableArray*) getCampaignIDs;

/**
 * @return An NSMutableArray of all the message IDs.
 */
- (NSMutableArray*) getMessageIDs;

/**
 * @return An NSMutableArray of all the hashes.
 */
- (NSMutableArray*) getHashs;

/**
 * @return An NSMutableArray of all the sender numbers.
 */
- (NSMutableArray*) getFromNumbers;

/**
 * @return An NSMutableArray of all the sender names.
 */
- (NSMutableArray*) getFromNames;

/**
 * @return An NSMutableArray of all the receiver numbers.
 */
- (NSMutableArray*) getToNumbers;

/**
 * @return An NSMutableArray of all the receiver names.
 */
- (NSMutableArray*) getToNames;

/**
 * Gets a sender name.
 * @param messageID A message ID.
 * @return The sender name of the specified message ID.
 */
- (NSString*) getFromName:(NSString*)messageID;

/**
 * Gets a sender number.
 * @param messageID A message ID.
 * @return The sender number of the specified message ID.
 */
- (NSString*) getFromNumber:(NSString*)messageID;

/**
 * Gets a receiver name.
 * @param messageID A message ID.
 * @return The receiver name of the specified message ID.
 */
- (NSString*) getToName:(NSString*)messageID;

/**
 * Gets a receiver number.
 * @param messageID A message ID.
 * @return The receiver number of the specified message ID.
 */
- (NSString*) getToNumber:(NSString*)messageID;

@end
