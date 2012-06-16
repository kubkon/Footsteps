//
//  FLocationAnnotation.h
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FLocationAnnotation : NSObject <MKAnnotation>
{
  CLLocationCoordinate2D _coordinate;
  NSString *_title;
  NSString *_subtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle;

@end
