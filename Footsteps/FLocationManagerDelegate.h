//
//  FLocationManagerDelegate.h
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FLocationManagerDelegate : NSObject <CLLocationManagerDelegate> {
  CLLocationManager *_locationManager;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (id)init;

- (void)startStandardUpdates;
- (void)stopStandardUpdates;

- (void)startSignificantChangeUpdates;
- (void)stopSignificantChangeUpdates;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@end
