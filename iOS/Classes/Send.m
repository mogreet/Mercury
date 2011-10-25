/**
 *  Send.m
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

#import "Send.h"

@implementation Send

- (void) initSend:(NSString *)urlSend {
	//Url for the Send call
	NSURL *url = [NSURL URLWithString:urlSend];
	//Parsing the xmlDoc
	CXMLDocument *doc = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	//Execution of Xpath
	NSArray *resNodeCode = [doc nodesForXPath:@"/response/@code" error:nil];
	NSArray *resNodeStatus = [doc nodesForXPath:@"/response/@status" error:nil];
	NSArray *resNodeMess = [doc nodesForXPath:@"/response/message" error:nil];
	NSArray *resNodeMessid = [doc nodesForXPath:@"/response/message_id" error:nil];
	NSArray *resNodeHash = [doc  nodesForXPath:@"/response/hash" error:nil];
	
	CXMLElement *resElemCode = [resNodeCode objectAtIndex:0];
	CXMLElement *resElemStatus = [resNodeStatus objectAtIndex:0];
	CXMLElement *resElemMess = [resNodeMess objectAtIndex:0];
	CXMLElement *resElemMessid = [resNodeMessid objectAtIndex:0];
	CXMLElement *resElemHash = [resNodeHash objectAtIndex:0];
	
	NSString *mess = [resElemMess stringValue];
	NSString *status = [resElemStatus stringValue];
	NSString *code = [resElemCode stringValue];
	NSString *messid = [resElemMessid stringValue];
	NSString *hashSend = [resElemHash stringValue];
	
	self->message = mess;
	self->responseCode = [code intValue];
	self->responseStatus = status;
	self->messageId = [messid intValue];
	self->hash = hashSend;
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

- (int) getMessageId {
	return self->messageId;
}

- (NSString*) getHash {
	return self->hash;
}

@end
