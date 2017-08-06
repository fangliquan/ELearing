//
//  NetworkStatus.m
//  CMAD_iOS
//
//  Created by William Fan on 8/12/11.
//  Copyright 2011 PCTC. All rights reserved.
//

#import "NetworkStatusMonitor.h"
#import <pthread.h>

static NetworkStatusMonitor* gNetworkStatusMonitor = nil;

@implementation NetworkStatusMonitor

-(void)updateNetworkStatus
{
    curNetworkStatus = [reachability currentReachabilityStatus];
    
    for (id<NetworkStatusObserver> observer in observers) {
        [observer updateNetworkStatus:curNetworkStatus];
    }
}

- (void)reachabilityChanged:(NSNotification*)notification
{
    reachability = [notification object];
    [self updateNetworkStatus];
}

#pragma mark - public methods

-(id)init
{
    self = [super init];
    if (self) {
        observers = [[NSMutableArray alloc] init];
        reachability = [RPMReachability reachabilityForInternetConnection];
        [self updateNetworkStatus];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        [reachability startNotifier];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [observers removeAllObjects];
    [reachability stopNotifier];
}

+(NetworkStatusMonitor*)getInstance
{
    if (gNetworkStatusMonitor == nil) {
        @synchronized(self) {
            if (gNetworkStatusMonitor == nil) {
                gNetworkStatusMonitor = [[NetworkStatusMonitor alloc] init];
            }
        }
    }
    
    return gNetworkStatusMonitor;
}

-(NetworkStatus)getNetworkStatus
{
    return curNetworkStatus;
}

-(NSUInteger)findNetworkStatusObserver:(id<NetworkStatusObserver>)obj
{
    NSUInteger pos = 0;
    for (id<NetworkStatusObserver> observer in observers) {
        if (observer == obj) {
            return pos;
        }
        
        ++pos;
    }
    
    return NSUIntegerMax;
}

-(void)addNetworkStatusObserver:(id<NetworkStatusObserver>)obj
{
    if ([self findNetworkStatusObserver:obj] == NSUIntegerMax) {
        [observers addObject:obj];
    }
}

-(void)removeNetworkStatusObserver:(id<NetworkStatusObserver>)obj
{
    NSUInteger index = [self findNetworkStatusObserver:obj];
    if (index != NSUIntegerMax) {
        [observers removeObjectAtIndex:index];
    }
}

@end
