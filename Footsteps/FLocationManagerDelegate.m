//
//  FLocationManagerDelegate.m
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//

#import "FLocationManagerDelegate.h"
#import "FConstants.h"

#define DISTANCE_FILTER 100
#define MIN_AGE_LOCATION_UPDATE 60.0

@implementation FLocationManagerDelegate

@synthesize managedObjectContext = _managedObjectContext;

- (id)init
{
  if (self = [super init]) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    // Require location updates of medium accuracy
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
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
  if (abs(howRecent) < MIN_AGE_LOCATION_UPDATE) {
    if (self.managedObjectContext) {
      NSManagedObject *location = [NSEntityDescription insertNewObjectForEntityForName:LOCATION_RECORD inManagedObjectContext:self.managedObjectContext];
      [location setValue:eventDate forKey:TIMESTAMP];
      [location setValue:[NSNumber numberWithDouble:newLocation.coordinate.latitude] forKey:LATITUDE];
      [location setValue:[NSNumber numberWithDouble:newLocation.coordinate.longitude] forKey:LONGITUDE];
      [location setValue:[NSNumber numberWithDouble:newLocation.horizontalAccuracy] forKey:ACCURACY];
      NSError *error;
      if (![self.managedObjectContext save:&error])
        NSLog(@"Could not save location update: %@", [error localizedDescription]);
    }
  }
}

@end
