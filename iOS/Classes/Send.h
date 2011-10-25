/**
 *  Send.h
 *  Mercury_iOS
 *
 *  Created by Julien Salvi on 9/12/11.
 *  Copyright 2011 Mogreet, Inc. All rights reserved.
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
 * The Send object contains the response from a {@link Mercury#send} request to the Moms API.
 */
@interface Send : NSObject {

@private int responseCode;
@private NSString *responseStatus;
@private NSString *message;
@private int messageId;
@private NSString *hash;
	
}

/**
 * Initializes a new Send response object.
 * @param urlSend URL for calling requests from Mogreet API.
 */
- (void) initSend:(NSString*)urlSend;

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
 * @return The message ID.
 */
- (int) getMessageId;

/**
 * @return The hash.
 */
- (NSString*) getHash;

@end
