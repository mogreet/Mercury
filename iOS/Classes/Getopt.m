/**
 *  Getopt.m
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

#import "Getopt.h"


@implementation Getopt

- (void) initGetopt:(NSString *)urlGetopt {
	
	//Url for the Getopt call
	NSURL *url = [NSURL URLWithString:urlGetopt];
	//Parsing the xmlDoc
	CXMLDocument *doc = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	//Execution of Xpath
	NSArray *resNodeCode = [doc nodesForXPath:@"/response/@code" error:nil];
	NSArray *resNodeStatus = [doc nodesForXPath:@"/response/@status" error:nil];
	NSArray *resNodeMess = [doc nodesForXPath:@"/response/message" error:nil];
	NSArray *resNodeCampaignID = [doc nodesForXPath:@"//@id" error:nil];
	NSArray *resNodeStatCode = [doc nodesForXPath:@"//@code" error:nil];
	NSArray *resNodeCampStatus = [doc nodesForXPath:@"/response//status" error:nil];
	
	CXMLElement *resElemCode = [resNodeCode objectAtIndex:0];
	CXMLElement *resElemStatus = [resNodeStatus objectAtIndex:0];
	CXMLElement *resElemMess = [resNodeMess objectAtIndex:0];
	NSMutableArray *myCampID = [[NSMutableArray alloc] init];
	NSMutableArray *myCampStatus = [[NSMutableArray alloc] init];
	NSMutableArray *myCampStatusCode = [[NSMutableArray alloc] init];
	int length = [resNodeCampStatus count];
	for (int i=0; i < length ; i++) {
		CXMLElement *resElemID = [resNodeCampaignID objectAtIndex:i];
		CXMLElement *resElemCode = [resNodeStatCode objectAtIndex:i];
		CXMLElement *resElemCampStat = [resNodeCampStatus objectAtIndex:i];
		[myCampID insertObject:[resElemID stringValue] atIndex:i];
		[myCampStatus insertObject:[resElemCampStat stringValue] atIndex:i];
		[myCampStatusCode insertObject:[resElemCode stringValue] atIndex:i];
	}
	
	NSString *mess = [resElemMess stringValue];
	NSString *status = [resElemStatus stringValue];
	NSString *code = [resElemCode stringValue];
	
	self->message = mess;
	self->responseCode = [code intValue];
	self->responseStatus = status;
	self->campaignID = myCampID;
	self->campaignStatus = myCampStatus;
	self->campaignStatusCode = myCampStatusCode;
}

- (BOOL) responseIsValid {
	if (responseCode == 1) {
		return YES;
	} else {
		return NO;
	}
}

- (int) getResponseCode {
	return self->responseCode;
}

- (NSString*) getResponseStatus {
	return self->responseStatus;
}

- (NSString*) getMessage {
	return self->message;
}

- (NSMutableArray*) getCampaignsIdList {
	return self->campaignID;
}

- (NSMutableArray*) getCampaignStatusList {
	return self->campaignStatus;
}

- (NSMutableArray*) getCampaignStatusCodeList {
	return self->campaignStatusCode;
}

- (int) getCampaignStatusCode:(NSString*)campaignId {
	NSString *campID = [[NSString alloc] init];
	int range;
	
	campID = campaignId;
	range = [campaignID indexOfObject:campID];
	
	return [[campaignStatusCode objectAtIndex:range] intValue];
}

- (NSString*) getCampaignStatus:(NSString*)campaignId {
	NSString *campID = [[NSString alloc] init];
	int range;
	
	campID = campaignId;
	range = [campaignID indexOfObject:campID];

	return [campaignStatus objectAtIndex:range];
}

@end
