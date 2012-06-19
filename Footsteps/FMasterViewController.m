//
//  FMasterViewController.m
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import "FMasterViewController.h"

@interface FMasterViewController ()

@end

@implementation FMasterViewController

static NSString *START_BUTTON_LABEL = @"Start";
static NSString *STOP_BUTTON_LABEL = @"Stop";

@synthesize startStopButton = _startStopButton;
@synthesize managedObjectContext;
@synthesize locManager = _locManager;
@synthesize isGathering = _isGathering;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)gatherDataOnClick:(id)sender
{
  NSLog(@"Gathering data action...");
  NSLog(@"Already gathering location: %i", _isGathering);
  if (_isGathering == YES)
  {
    [_startStopButton setTitle:START_BUTTON_LABEL forState:UIControlStateNormal];
    [self stopGatheringLocationData];
  }
  else
  {
    [_startStopButton setTitle:STOP_BUTTON_LABEL forState:UIControlStateNormal];
    [self startGatheringLocationData];
  }

}

- (void)startGatheringLocationData
{
  if (!_locManager)
  {
    _locManager = [[FLocationManagerDelegate alloc] init];
    _locManager.managedObjectContext = self.managedObjectContext;
  }
  [_locManager startStandardUpdates];
  _isGathering = YES;
}

- (void)stopGatheringLocationData
{
  if (nil != _locManager)
    [_locManager stopStandardUpdates];
  _isGathering = NO;
}

@end
