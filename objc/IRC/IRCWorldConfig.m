// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the Ruby's license or the GPL2.

#import "IRCWorldConfig.h"
#import "IRCClientConfig.h"
#import "NSDictionaryHelper.h"


@implementation IRCWorldConfig

@synthesize clients;
@synthesize autoOp;

- (id)initWithDictionary:(NSDictionary*)dic
{
	if (self = [super init]) {
		clients = [NSMutableArray new];
		autoOp = [NSMutableArray new];
		
		for (NSDictionary* e in [dic arrayForKey:@"clients"]) {
			IRCClientConfig* c = [[[IRCClientConfig alloc] initWithDictionary:e] autorelease];
			[clients addObject:c];
		}
		
		[autoOp addObjectsFromArray:[dic arrayForKey:@"autoop"]];
	}
	return self;
}

- (void)dealloc
{
	[clients release];
	[autoOp release];
	[super dealloc];
}

- (NSDictionary*)dictionaryValue
{
	NSMutableDictionary* dic = [NSMutableDictionary dictionary];
	
	NSMutableArray* clientAry = [NSMutableArray array];
	for (IRCClientConfig* e in clients) {
		[clientAry addObject:[e dictionaryValue]];
	}
	[dic setObject:clientAry forKey:@"clients"];
	
	[dic setObject:autoOp forKey:@"autoop"];
	
	return dic;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
	return [[IRCWorldConfig allocWithZone:zone] initWithDictionary:[self dictionaryValue]];
}

@end