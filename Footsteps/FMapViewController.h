  //
//  FMapViewController.h
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FMapViewController : UIViewController <MKMapViewDelegate>
{
  MKMapView *_mapView;
  CGPoint _portraitFrameSize;
  CGPoint _landscapeFrameSize;
  NSManagedObjectContext *_managedObjectContext;
}

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, readonly) CGPoint portraitFrameSize;
@property (nonatomic, readonly) CGPoint landscapeFrameSize;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
