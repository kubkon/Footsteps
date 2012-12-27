//
//  FLocationManagerDelegate.m
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are
//  met:
//   
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  
//  2. Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer in the
//     documentation and/or other materials provided with the distribution.
//   
//  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
//  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
//  AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
//  JAKUB KONKA BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "FLocationManagerDelegate.h"
#import "FConstants.h"

#define DISTANCE_FILTER 50
#define MIN_AGE_LOCATION_UPDATE 60.0

@implementation FLocationManagerDelegate

@synthesize locationManager = _locationManager;
@synthesize managedObjectContext = _managedObjectContext;

- (id)init
{
  self = [super init];
  if (self)
  {
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    // Require location updates which are best for navigation
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    // Set distance filter
    _locationManager.distanceFilter = DISTANCE_FILTER;
  }
  return self;
}

- (void)startStandardUpdates
{
  // Handle error here
  NSAssert(_locationManager, @"FLocationManagerDelegate object not properly initialized");
  [_locationManager startUpdatingLocation];
}

- (void)stopStandardUpdates
{
  if (_locationManager)
    [_locationManager stopUpdatingLocation];
}

- (void)startSignificantChangeUpdates
{
  // Handle error here
  NSAssert(_locationManager, @"FLocationManagerDelegate object not properly initialized");
  [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopSignificantChangeUpdates
{
  if (_locationManager)
    [_locationManager stopMonitoringSignificantLocationChanges];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  NSLog(@"Location update received");
  CLLocation *newLocation = [locations lastObject];
  NSDate *eventDate = newLocation.timestamp;
  NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
  if (abs(howRecent) < MIN_AGE_LOCATION_UPDATE)
  {
    if (_managedObjectContext)
    {
      NSManagedObject *location = [NSEntityDescription insertNewObjectForEntityForName:LOCATION_RECORD inManagedObjectContext:_managedObjectContext];
      [location setValue:eventDate forKey:TIMESTAMP];
      [location setValue:[NSNumber numberWithDouble:newLocation.coordinate.latitude] forKey:LATITUDE];
      [location setValue:[NSNumber numberWithDouble:newLocation.coordinate.longitude] forKey:LONGITUDE];
      [location setValue:[NSNumber numberWithDouble:newLocation.horizontalAccuracy] forKey:ACCURACY];
      NSError *error;
      if (![_managedObjectContext save:&error])
        NSLog(@"Could not save location update: %@", [error localizedDescription]);
    }
  }
}

@end
