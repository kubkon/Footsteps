//
//  FMapViewController.h
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FMapViewController : UIViewController <MKMapViewDelegate> {
  MKMapView *_mapView;
  CGPoint _portraitFrameSize;
  CGPoint _landscapeFrameSize;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
