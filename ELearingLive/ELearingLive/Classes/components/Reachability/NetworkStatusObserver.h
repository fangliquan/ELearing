//
//  NetworkStatusObserver.h
//  CMAD_iOS
//
//  Created by William Fan on 8/12/11.
//  Copyright 2011 PCTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@protocol NetworkStatusObserver <NSObject>

-(void)updateNetworkStatus:(NetworkStatus)curStatus;

@end
