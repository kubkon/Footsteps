//
//  FLocationRecord.h
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>


@interface FLocationRecord : NSManagedObject <MKAnnotation>

@property (nonatomic, retain) NSDate *timeStamp;
@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *accuracy;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

@end
