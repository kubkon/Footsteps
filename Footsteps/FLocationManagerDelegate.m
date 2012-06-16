//
//  FLocationManagerDelegate.m
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

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
    _locationManager = [[CLLocationManager alloc] init];
  return self;
}

- (void)startStandardUpdates
{
  if (!_locationManager)
    _locationManager = [[CLLocationManager alloc] init];
  
  [_locationManager setDelegate:self];
  // Require location updates which are best for navigation
  _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
  // Set distance filter
  _locationManager.distanceFilter = DISTANCE_FILTER;
  [_locationManager startUpdatingLocation];
}

- (void)stopStandardUpdates
{
  if (_locationManager)
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
  NSLog(@"Location update received");
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
