//
//  LocationManager.m
//  Unii
//
//  Created by Ante Baus on 24.10.2013..
//  Copyright (c) 2013. Andrija Cajic. All rights reserved.
//

#define kLocationManagerMaxUpdateCount 10

#import "XEELocationManager.h"

@implementation XEELocationManager {
    NSMutableArray* _blocksWaitingForLocation;
    
    BOOL _started;
    int _gpsCounter;
    BOOL _isNotifying;
}


static XEELocationManager* locationManager;

+(id)sharedManager
{
    @synchronized(self) {
        if (!locationManager) {
            locationManager = [[XEELocationManager alloc] init];
        }
        return locationManager;
    }
}

-(id)init
{
    if (self = [super init]) {
        _clLocationManager = [[CLLocationManager alloc] init];
        _clLocationManager.delegate = self;
        _clLocationManager.distanceFilter = 20.f;
        _clLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _started = NO;
        _isNotifying = NO;
        _blocksWaitingForLocation = [NSMutableArray array];
    }
    return self;
}

-(void)startLocatingCurrentPosition
{
    if ([CLLocationManager locationServicesEnabled] && !_started){
        _started = YES;
        [_clLocationManager startUpdatingLocation];
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            [self performSelector:@selector(processLocation:) withObject:_clLocationManager afterDelay:2.f];
        } else {
            [_clLocationManager stopUpdatingLocation];
            _started = NO;
        }
    }
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"LOCATION MANAGER: %@", error);
    for (XEELocationFound block in _blocksWaitingForLocation) {
        block(nil);
    }
    [_blocksWaitingForLocation removeAllObjects];
    _isNotifying = NO;
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self processLocation:manager];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _gpsCounter++;
    if (_gpsCounter > 5) {
        [self processLocation:manager];
    }
    
}

-(void)processLocation:(CLLocationManager *)manager
{
    manager.distanceFilter = kCLDistanceFilterNone;
    if (!_isNotifying) {
        _isNotifying = YES;
        [self notifyInterestedParties];
        _started = NO;
    }
    
}

-(void) notifyInterestedParties
{
    [_clLocationManager stopUpdatingLocation];
    
    for (XEELocationFound block in _blocksWaitingForLocation) {
        block(_clLocationManager.location);
    }
    [_blocksWaitingForLocation removeAllObjects];
    _clLocationManager.distanceFilter = 20.0f;
    _isNotifying = NO;
}

-(void) fetchCurrentLocation:(XEELocationFound)resultBlock refresh:(BOOL)refresh
{
    if (_clLocationManager.location && !refresh) {
        return resultBlock(_clLocationManager.location);
    } else {
        if (_blocksWaitingForLocation.count == kLocationManagerMaxUpdateCount) {
            [_blocksWaitingForLocation removeObjectAtIndex:0];
        }
        [_blocksWaitingForLocation addObject:resultBlock];
        [self startLocatingCurrentPosition];
    }
}

#pragma mark - CLLocationManager delegate

-(void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    [self startLocatingCurrentPosition];
}

@end
