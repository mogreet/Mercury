/**
 *  Setopt.h
 *  Mercury_iOS
 *
 * Created by Julien Salvi on 9/12/11.
 * Copyright 2011 Mogreet Inc. All rights reserved.
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
 * The Setopt object contains the response from a {@link Mercury#setopt} request to the MoMS API.
 */
@interface Setopt : NSObject {
	
@private int campaignId;
@private int campaignStatusCode;
@private NSString *campaignStatus;
@private NSString *message;
@private NSString *responseStatus;
@private int responseCode;

}

/**
 * Initializes a new Setopt response object.
 * @param urlSetopt URL for calling requests from Mogreet API.
 */
- (void) initSetopt:(NSString*)urlSetopt;

/**
 * Checks if the response code is 1.
 * @return YES if the response code is 1, NO if it is not
 */
- (BOOL) responseIsValid;

/**
 * @return The campaign ID.
 */
- (int) getCampaignId;

/**
 * @return The campaign status code.
 */
- (int) getCampaignStatusCode;

/**
 * @return The campaign status.
 */
- (NSString*) getCampaignStatus;

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

@end
