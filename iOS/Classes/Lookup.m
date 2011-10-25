/**
 *  Lookup.m
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

#import "Lookup.h"

@implementation Lookup

- (void) initLookup:(NSString *)urlLookup {
	//Url for the Lookup call
	NSURL *url = [NSURL URLWithString:urlLookup];
	//Parsing the xmlDoc
	CXMLDocument *doc = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	//Execution of Xpath
	NSArray *resNodeCode = [doc nodesForXPath:@"/response/@code" error:nil];
	NSArray *resNodeStatus = [doc nodesForXPath:@"/response/@status" error:nil];
	NSArray *resNodeMess = [doc nodesForXPath:@"/response/message" error:nil];
	NSArray *resNodeCampid = [doc nodesForXPath:@"/response/campaign_id" error:nil];
	NSArray *resNodeFromNum = [doc nodesForXPath:@"/response/from" error:nil];
	NSArray *resNodeToNum = [doc nodesForXPath:@"/response/to" error:nil];
	NSArray *resNodeFromName = [doc nodesForXPath:@"/response/from_name" error:nil];
	NSArray *resNodeToName = [doc nodesForXPath:@"/response/to_name" error:nil];
	NSArray *resNodeContent = [doc nodesForXPath:@"/response/content_id" error:nil];
	NSArray *resNodeStat = [doc nodesForXPath:@"/response/status" error:nil];
	NSArray *resNodeEvent = [doc nodesForXPath:@"/response/history//event" error:nil];
	NSArray *resNodeTime = [doc nodesForXPath:@"//@timestamp" error:nil];
	
	CXMLElement *resElemCode = [resNodeCode objectAtIndex:0];
	CXMLElement *resElemStatus = [resNodeStatus objectAtIndex:0];
	CXMLElement *resElemMess = [resNodeMess objectAtIndex:0];
	CXMLElement *resElemCampid = [resNodeCampid objectAtIndex:0];
	CXMLElement *resElemFrom = [resNodeFromNum objectAtIndex:0];
	CXMLElement *resElemTo = [resNodeToNum objectAtIndex:0];
	CXMLElement *resElemfromname = [resNodeFromName objectAtIndex:0];
	CXMLElement *resElemtoname = [resNodeToName objectAtIndex:0];
	CXMLElement *resElemContent = [resNodeContent objectAtIndex:0];
	CXMLElement *resElemStat = [resNodeStat objectAtIndex:0];
	NSMutableDictionary *myHistory = [[NSMutableDictionary alloc] init];
	int length = [resNodeEvent count];
	for (int i=0; i < length ; i++) {
		CXMLElement *resElemEvent = [resNodeEvent objectAtIndex:i];
		CXMLElement *resElemTime = [resNodeTime objectAtIndex:i];
		[myHistory setObject:[resElemEvent stringValue] forKey:[resElemTime stringValue]];
	}
	
	NSString *mess = [resElemMess stringValue];
	NSString *statusLook = [resElemStatus stringValue];
	NSString *code = [resElemCode stringValue];
	NSString *campid = [resElemCampid stringValue];
	NSString *from = [resElemFrom stringValue];
	NSString *to = [resElemTo stringValue];
	NSString *toname = [resElemtoname stringValue];
	NSString *fromname = [resElemfromname stringValue];
	NSString *content = [resElemContent stringValue];
	NSString *stat = [resElemStat stringValue];
	
	self->message = mess;
	self->responseCode = [code intValue];
	self->responseStatus = statusLook;
	self->campaignId = [campid intValue];
	self->fromNumber = from;
	self->toNumber = to;
	self->toName = toname;
	self->fromName = fromname;
	self->contentId = [content intValue];
	self->status = stat;
	self->history = myHistory;
}
	

- (void) setHistory:(NSArray *)key withValue:(NSArray *)value {
	[history initWithObjects:value forKeys:key];
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

- (NSString*) getFromNumber {
	return self->fromNumber;
}

- (NSString*) getFromName {
	return self->fromName;
}

- (NSString*) getToName {
	return self->toName;
}

- (NSString*) getToNumber {
	return self->toNumber;
}

- (int) getContentId {
	return self->contentId;
}

- (NSString*) getStatus {
	return self->status;
}

- (NSMutableDictionary*) getHistory {
	return self->history;
}

- (NSMutableArray*) getTimestampList {
	NSMutableArray *time = [[NSMutableArray alloc] init];
	for (NSString *key in history) {
		[time addObject:key];
	}
	return time;
}

- (NSMutableArray*) getEventsList {
	NSMutableArray *events = [[NSMutableArray alloc] init];
	for (NSString *key in history) {
		[events addObject:[history objectForKey:key]];
	}
	return events;
}

- (NSArray*) getEventList:(NSString *)timestamp {
	NSMutableArray *event = [[NSMutableArray alloc] init];
	[event addObject:[history objectForKey:timestamp]];
	return event;
}

@end
