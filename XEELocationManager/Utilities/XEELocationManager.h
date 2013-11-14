//
//  LocationManager.h
//  Unii
//
//  Created by Ante Baus on 24.10.2013..
//  Copyright (c) 2013. Andrija Cajic. All rights reserved.
//


//#define kLocationManagerFoundLocation @"locationFound"

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^XEELocationFound) (CLLocation* location);

/**
 Singleton class designed to provide all the necessary location related services.
 */
@interface XEELocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* clLocationManager;

+(id) sharedManager;

/**
 Starts locating current position. When location is retrieved, it is cached.
 */
-(void) startLocatingCurrentPosition;

/**
 @param resultBlock block that delivers result in form of CLLocation object
 @param refresh If NO, cached location will be returned immediately via resultBlock. If YES, locating procedure will commence.
 */
-(void) fetchCurrentLocation:(XEELocationFound)resultBlock refresh:(BOOL)refresh;

@end
