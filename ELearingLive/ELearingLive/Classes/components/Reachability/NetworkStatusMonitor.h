//
//  NetworkStatus.h
//  CMAD_iOS
//
//  Created by William Fan on 8/12/11.
//  Copyright 2011 PCTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "NetworkStatusObserver.h"

@interface NetworkStatusMonitor : NSObject {
    NetworkStatus curNetworkStatus;
    RPMReachability* reachability;
    NSMutableArray* observers;
}

+(NetworkStatusMonitor*)getInstance;
-(NetworkStatus)getNetworkStatus;
-(void)addNetworkStatusObserver:(id<NetworkStatusObserver>)obj;
-(void)removeNetworkStatusObserver:(id<NetworkStatusObserver>)obj;

@end
