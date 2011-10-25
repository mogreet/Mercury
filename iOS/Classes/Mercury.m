/**
 *  Mercury.m
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

#import "Mercury.h"


@implementation Mercury

- (id) initMercury:(int)clientID withToken:(NSString *)tokenM {
	self->clientId = clientID;
	self->token = tokenM;
	return self;
}

- (NSString*) setParams:(NSMutableDictionary *)hash {
	NSString *params = [NSString stringWithFormat:@"client_id=%i&token=%@", clientId, token];
	if (hash != nil) {
		for (NSString* key in hash) {
			params = [params stringByAppendingFormat:@"&%@=%@", key, [[hash objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		}
	}
	return params;
}

- (BOOL) checkInputParams:(NSMutableArray *)paramsList andHash:(NSMutableDictionary *)hash {
	int i=0;
	for (NSString *key in hash) {
		if (key !=  [paramsList objectAtIndex:i]) {
			return NO;
		}
		i++;
	}
	return YES;
}

- (Ping*) ping {
	NSString *urlPing = [NSString stringWithFormat:@"https://api.mogreet.com/moms/system.ping?"];
	NSString *param = [self setParams:nil];
	
	urlPing = [urlPing stringByAppendingFormat:@"%@", param];
	Ping *myPing = [[Ping alloc] init];
	[myPing initPing:urlPing];
	
	return myPing;
}

- (Lookup*) lookup:(NSMutableDictionary *)paramLook {
	NSString *urlLookup = [NSString stringWithFormat:@"https://api.mogreet.com/moms/transaction.lookup?"];
	NSString *topLook = [self setParams:paramLook];
	
	urlLookup = [urlLookup stringByAppendingFormat:@"%@", topLook];
	Lookup *myLook = [[Lookup alloc]init];
	[myLook initLookup:urlLookup];
	
	return myLook;
}

- (Send*) send:(NSMutableDictionary *)paramSend {
	NSString *urlSend = [NSString stringWithFormat:@"https://api.mogreet.com/moms/transaction.send?"];
	NSString *topSend = [self setParams:paramSend];
	
	urlSend = [urlSend stringByAppendingFormat:@"%@", topSend];
	Send *mySend = [[Send alloc] init];
	[mySend initSend:urlSend];
	
	return mySend;
}	

- (Getopt*) getopt:(NSMutableDictionary *)paramGet {
	NSString *urlGetopt = [NSString stringWithFormat:@"https://api.mogreet.com/moms/user.getopt?"];
	NSString *topGet = [self setParams:paramGet];
	
	urlGetopt = [urlGetopt stringByAppendingFormat:@"%@", topGet];
	Getopt *myGetopt = [[Getopt alloc] init];
	[myGetopt initGetopt:urlGetopt];
	
	return myGetopt;
}

- (Info*) info:(NSMutableDictionary *)paramInfo {
	NSString *urlInfo = [NSString stringWithFormat:@"https://api.mogreet.com/moms/user.info?"];
	NSString *topInfo = [self setParams:paramInfo];
	
	urlInfo = [urlInfo stringByAppendingFormat:@"%@", topInfo];
	Info *myInfo = [[Info alloc] init];
	[myInfo initInfo:urlInfo];
	
	return myInfo;
}

- (Setopt*) setopt:(NSMutableDictionary *)paramSet {
	NSString *urlSetopt = [NSString stringWithFormat:@"https://api.mogreet.com/moms/user.setopt?"];
	NSString *topSetopt = [self setParams:paramSet];
	
	urlSetopt = [urlSetopt stringByAppendingFormat:@"%@", topSetopt];
	Setopt *mySetopt = [[Setopt alloc] init];
	[mySetopt initSetopt:urlSetopt];
	
	return mySetopt;
}

- (Transactions*) transactions:(NSMutableDictionary *)paramTrans {
	NSString *urlTrans = [NSString stringWithFormat:@"https://api.mogreet.com/moms/user.transactions?"];
	NSString *topTrans = [self setParams:paramTrans];
	
	urlTrans = [urlTrans stringByAppendingFormat:@"%@", topTrans];
	Transactions *myTrans = [[Transactions alloc] init];
	[myTrans initTransactions:urlTrans];
	
	return myTrans;
}

- (Uncache*) uncache:(NSMutableDictionary *)paramUn {
	NSString *urlUncache = [NSString stringWithFormat:@"https://api.mogreet.com/moms/user.uncache?"];
	NSString *topUn = [self setParams:paramUn];
	
	urlUncache = [urlUncache stringByAppendingFormat:topUn];
	Uncache *myUncache = [[Uncache alloc] init];
	[myUncache initUncache:urlUncache];
	
	return myUncache;
}

@end
