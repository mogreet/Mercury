/**
 *  Setopt.m
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

#import "Setopt.h"

@implementation Setopt

- (void) initSetopt:(NSString *)urlSetopt {
	
	//Url for the Setopt call
	NSURL *url = [NSURL URLWithString:urlSetopt];
	//Parsing the xmlDoc
	CXMLDocument *doc = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	//Execution of Xpath
	NSArray *resNodeCode = [doc nodesForXPath:@"/response/@code" error:nil];
	NSArray *resNodeStatus = [doc nodesForXPath:@"/response/@status" error:nil];
	NSArray *resNodeMess = [doc nodesForXPath:@"/response/message" error:nil];
	NSArray *resNodeCampid = [doc nodesForXPath:@"/response/campaign/@id" error:nil];
	NSArray *resNodeCampStatus = [doc nodesForXPath:@"/response/campaign/status" error:nil];
	NSArray *resNodeCampStatCode = [doc nodesForXPath:@"/response/campaign/status/@code" error:nil];
	
	CXMLElement *resElemCode = [resNodeCode objectAtIndex:0];
	CXMLElement *resElemStatus = [resNodeStatus objectAtIndex:0];
	CXMLElement *resElemMess = [resNodeMess objectAtIndex:0];
	CXMLElement *resElemCampid = [resNodeCampid objectAtIndex:0];
	CXMLElement *resElemCampStatus = [resNodeCampStatus objectAtIndex:0];
	CXMLElement *resElemCampStatCode = [resNodeCampStatCode objectAtIndex:0];
	
	NSString *mess = [resElemMess stringValue];
	NSString *status = [resElemStatus stringValue];
	NSString *code = [resElemCode stringValue];
	NSString *campid = [resElemCampid stringValue];
	NSString *campstatus = [resElemCampStatus stringValue];
	NSString *campstcode = [resElemCampStatCode stringValue];
	
	self->message = mess;
	self->responseCode = [code intValue];
	self->responseStatus = status;
	self->campaignId = [campid intValue];	
	self->campaignStatus = campstatus;
	self->campaignStatusCode = [campstcode intValue];
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

- (int) getCampaignId {
	return self->campaignId;
}

- (int) getCampaignStatusCode {
	return self->campaignStatusCode;
}

- (NSString*) getCampaignStatus {
	return self->campaignStatus;
}

@end
