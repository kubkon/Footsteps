//
//  FMapViewController.m
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import "FMapViewController.h"
#import "FConstants.h"
#import "FAppDelegate.h"
#import "FLocationRecord.h"

@interface FMapViewController ()

@end

@implementation FMapViewController

@synthesize mapView = _mapView;
@synthesize portraitFrameSize = _portraitFrameSize;
@synthesize landscapeFrameSize = _landscapeFrameSize;
@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Calculate portrait mode screen size
  _portraitFrameSize.x = [[UIScreen mainScreen] applicationFrame].size.width;
  _portraitFrameSize.y = [[UIScreen mainScreen] applicationFrame].size.height;
  
  // Calculate landscape mode screen size
  _landscapeFrameSize.x = [[UIScreen mainScreen] bounds].size.height;
  CGFloat barHeight = [[UIScreen mainScreen] bounds].size.height - [[UIScreen mainScreen] applicationFrame].size.height;
  _landscapeFrameSize.y = _portraitFrameSize.x - barHeight;

  // Set up MapView and delegate to self
  if (nil == _mapView)
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, _portraitFrameSize.x, _portraitFrameSize.y)];
  [_mapView setMapType:MKMapTypeStandard];
  [_mapView setDelegate:self];
  [_mapView setZoomEnabled:YES];
  [_mapView setScrollEnabled:YES];
  [self.view addSubview:_mapView];
  
  // Get an instance of ManagedObjectContext
  if (!_managedObjectContext)
  {
    FAppDelegate *appDelegate = (FAppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = appDelegate.managedObjectContext;
  }
}

- (void)viewDidUnload
{
  _mapView = nil;
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // Fetch location records and place them on the map
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:LOCATION_RECORD inManagedObjectContext:_managedObjectContext];
  [fetchRequest setEntity:entity];
  NSError *error;
  NSArray *locations = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
  [_mapView addAnnotations:locations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
  
  BOOL rotatePortrait180D = (self.interfaceOrientation == UIInterfaceOrientationPortrait && toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) || (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown && toInterfaceOrientation == UIInterfaceOrientationPortrait);
  
  BOOL rotatePortrait90D = (self.interfaceOrientation == UIInterfaceOrientationPortrait && (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)) || (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown && (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight));
  
  BOOL rotateLandscape180D = (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft && toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) || (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight && toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
  
  BOOL rotateLandscape90D = (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft && (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)) || (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight && (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
  
  if (rotatePortrait90D || rotateLandscape180D)
    [_mapView setFrame:CGRectMake(0, 0, _landscapeFrameSize.x, _landscapeFrameSize.y)];
  
  if (rotatePortrait180D || rotateLandscape90D)
    [_mapView setFrame:CGRectMake(0, 0, _portraitFrameSize.x, _portraitFrameSize.y)];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
  // If it's the user location, just return nil
  if ([annotation isKindOfClass:[MKUserLocation class]])
    return nil;
  
  // Handle any custom annotations
  MKAnnotationView *anntView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:DEFAULT_ANNOTATION_VIEW];
  
  if (!anntView)
  {
    anntView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:DEFAULT_ANNOTATION_VIEW];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:MARKER_FILENAME ofType:MARKER_EXT];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    anntView.image = image;
    anntView.canShowCallout = YES;
  }
  else
    anntView.annotation = annotation;
  
  return anntView;
}

@end