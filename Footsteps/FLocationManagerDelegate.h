//
//  FLocationManagerDelegate.h
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FLocationManagerDelegate : NSObject <CLLocationManagerDelegate>
{
  CLLocationManager *_locationManager;
  NSManagedObjectContext *_managedObjectContext;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (id)init;

- (void)startStandardUpdates;
- (void)stopStandardUpdates;

- (void)startSignificantChangeUpdates;
- (void)stopSignificantChangeUpdates;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

@end
