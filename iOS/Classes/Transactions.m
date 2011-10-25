/**
 *  Transactions.m
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

#import "Transactions.h"


@implementation Transactions

- (void) initTransactions:(NSString *)urlTrans {
	
	//Url for the Transactions call
	NSURL *url = [NSURL URLWithString:urlTrans];
	//Parsing the xmlDoc
	CXMLDocument *doc = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	//Execution of Xpath
	NSArray *resNodeCode = [doc nodesForXPath:@"/response/@code" error:nil];
	NSArray *resNodeStatus = [doc nodesForXPath:@"/response/@status" error:nil];
	NSArray *resNodeMess = [doc nodesForXPath:@"/response/message" error:nil];
	NSArray *resNodeCampid = [doc nodesForXPath:@"//@id" error:nil];
	NSArray *resNodeCampName = [doc nodesForXPath:@"//@name" error:nil];
	NSArray *resNodeHash = [doc nodesForXPath:@"//@hash" error:nil];
	NSArray *resNodeMessid = [doc nodesForXPath:@"//@message_id" error:nil];
	NSArray *resNodeFromNum = [doc nodesForXPath:@"/response/campaign/transaction/from//@number" error:nil];
	NSArray *resNodeFromName = [doc nodesForXPath:@"/response//from" error:nil];
	NSArray *resNodeToNum = [doc nodesForXPath:@"/response/campaign/transaction/to//@number" error:nil];
	NSArray *resNodeToName = [doc nodesForXPath:@"/response//to" error:nil];
	
	CXMLElement *resElemCode = [resNodeCode objectAtIndex:0];
	CXMLElement *resElemStatus = [resNodeStatus objectAtIndex:0];
	CXMLElement *resElemMess = [resNodeMess objectAtIndex:0];
	NSMutableArray *myCampid = [[NSMutableArray alloc] init];
	NSMutableArray *myCampName = [[NSMutableArray alloc] init];
	NSMutableArray *myHash = [[NSMutableArray alloc] init];
	NSMutableArray *myMessid = [[NSMutableArray alloc] init];
	NSMutableArray *myFromNum = [[NSMutableArray alloc] init];
	NSMutableArray *myFromName = [[NSMutableArray alloc] init];
	NSMutableArray *myToNum = [[NSMutableArray alloc] init];
	NSMutableArray *myToName = [[NSMutableArray alloc] init];

	int length = [resNodeCampid count];
	for (int i=0; i < length ; i++) {
		CXMLElement *resElemCampid = [resNodeCampid objectAtIndex:i];
		CXMLElement *resElemCampName = [resNodeCampName objectAtIndex:i];
		CXMLElement *resElemHash = [resNodeHash objectAtIndex:i];
		CXMLElement *resElemMessid = [resNodeMessid objectAtIndex:i];
		CXMLElement *resElemFromNum = [resNodeFromNum objectAtIndex:i];
		CXMLElement *resElemFromName = [resNodeFromName objectAtIndex:i];
		CXMLElement *resElemToName = [resNodeToName objectAtIndex:i];
		CXMLElement *resElemToNum = [resNodeToNum objectAtIndex:i];
		[myCampid insertObject:[resElemCampid stringValue] atIndex:i];
		[myCampName insertObject:[resElemCampName stringValue] atIndex:i];
		[myHash insertObject:[resElemHash stringValue] atIndex:i];
		[myMessid insertObject:[resElemMessid stringValue] atIndex:i];
		[myFromNum insertObject:[resElemFromNum stringValue] atIndex:i];
		[myFromName insertObject:[resElemFromName stringValue] atIndex:i];
		[myToNum insertObject:[resElemToNum stringValue] atIndex:i];
		[myToName insertObject:[resElemToName stringValue] atIndex:i];
	}
	
	NSString *mess = [resElemMess stringValue];
	NSString *status = [resElemStatus stringValue];
	NSString *code = [resElemCode stringValue];
	
	self->message = mess;
	self->responseCode = [code intValue];
	self->responseStatus = status;
	self->campaignIDs = myCampid;
	self->campaignNames = myCampName;
	self->hashs = myHash;
	self->messageIDs = myMessid;
	self->fromNames = myFromName;
	self->fromNumbers = myFromNum;
	self->toNames = myToName;
	self->toNumbers = myToNum;
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

- (NSMutableArray*) getCampaignNames {
	return self->campaignNames;
}

- (NSMutableArray*) getCampaignIDs {
	return self->campaignIDs;
}

- (NSMutableArray*) getHashs {
	return self->hashs;
}

- (NSMutableArray*) getMessageIDs {
	return self->messageIDs;
}

- (NSMutableArray*) getFromNumbers {
	return self->fromNumbers;
}

- (NSMutableArray*) getFromNames {
	return self->fromNames;
}

- (NSMutableArray*) getToNumbers {
	return self->toNumbers;
}

- (NSMutableArray*) getToNames { 
	return self->toNames;
}
- (NSString*) getFromName:(NSString*)messageID {
	int range;
	
	range = [messageIDs indexOfObject:messageID];
	
	return [fromNames objectAtIndex:range];
}

- (NSString*) getFromNumber:(NSString*)messageID {
	int range;
	
	range = [messageIDs indexOfObject:messageID];
	
	return [fromNumbers objectAtIndex:range];	
}

- (NSString*) getToName:(NSString*)messageID {
	int range;
	
	range = [messageIDs indexOfObject:messageID];
	
	return [toNames objectAtIndex:range];
	
}

- (NSString*) getToNumber:(NSString*)messageID {
	int range;
	
	range = [messageIDs indexOfObject:messageID];
	
	return [toNumbers objectAtIndex:range];
}


@end
