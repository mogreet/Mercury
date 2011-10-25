/**
 *  Lookup.h
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
 * The Lookup object contains the response from a {@link Mercury#lookup} request to the MoMS API.
 */
@interface Lookup : NSObject {
	
@private int responseCode;
@private NSString *responseStatus;
@private NSString *message;
@private int campaignId;
@private NSString *fromNumber;
@private NSString *fromName;
@private NSString *toName;
@private NSString *toNumber;
@private int contentId;
@private NSString *status;
@private NSMutableDictionary *history;

}

/**
 * Initializes a new Lookup response object.
 * @param urlLookup URL for calling requests from Mogreet API.
 */
- (void) initLookup:(NSString*)urlLookup;

/**
 * Set the history NSDictionary with a timestamp as a key and a list of events corresponding to the timestamp.
 * @param key A timestamp.
 * @param value An event.
 */
- (void) setHistory: (NSArray*)key withValue:(NSArray*)value;

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
 * @return The Campaign ID of the requested transaction.
 */
- (int) getCampaignId;

/**
 * @return The sender number of the requested transaction.
 */
- (NSString*) getFromNumber;

/**
 * @return The sender name of the requested transaction.
 */
- (NSString*) getFromName;

/**
 * @return The receiver number of the requested transaction.
 */
- (NSString*) getToName;

/**
 * @return The receiver name of the requested transaction.
 */
- (NSString*) getToNumber;

/**
 * @return The content ID of the requested transaction.
 */
- (int) getContentId;

/**
 * @return The Status label of the requested transaction.
 */
- (NSString*) getStatus;

/**
 * @return The history of the requested transaction.
 */
- (NSMutableDictionary*) getHistory;

/**
 * @return The list of all the timestamps events of the requested transaction.
 */
- (NSMutableArray*) getTimestampList;

/**
 * @return The list of all the events of the requested transaction.
 */
- (NSMutableArray*) getEventsList;

/**
 * @param timestamp Time of the event.
 * @return The list of the events that occured at the occurred at the specified timestamp pf the requested transaction.
 * Nil if the the timestamp does not exist.
 */
- (NSMutableArray*) getEventList:(NSString*)timestamp;

@end
