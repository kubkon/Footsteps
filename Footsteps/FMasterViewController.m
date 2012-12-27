//
//  FMasterViewController.m
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//

#import "FMasterViewController.h"
#import "FConstants.h"

@interface FMasterViewController ()

@end

@implementation FMasterViewController

static NSString *START_BUTTON_LABEL = @"Start";
static NSString *STOP_BUTTON_LABEL = @"Stop";

@synthesize managedObjectContext = _managedObjectContext;
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
  NSLog(@"Already gathering location: %i", self.isGathering);
  if (self.isGathering == YES) {
    [_startStopButton setTitle:START_BUTTON_LABEL forState:UIControlStateNormal];
    [self stopGatheringLocationData];
  } else {
    [_startStopButton setTitle:STOP_BUTTON_LABEL forState:UIControlStateNormal];
    [self startGatheringLocationData];
  }

}

- (void)startGatheringLocationData
{
  if (!self.locManager) {
    self.locManager = [[FLocationManagerDelegate alloc] init];
    self.locManager.managedObjectContext = self.managedObjectContext;
  }
  // Check which type of location updates we should gather
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  BOOL isLowPowerOn = [defaults boolForKey:BOOL_LOW_POWER];
  if (isLowPowerOn)
    [self.locManager startSignificantChangeUpdates];
  else
    [self.locManager startStandardUpdates];
  self.isGathering = YES;
}

- (void)stopGatheringLocationData
{
  if (self.locManager) {
    // Check which type of location updates are being gathered
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLowPowerOn = [defaults boolForKey:BOOL_LOW_POWER];
    if (isLowPowerOn)
      [self.locManager stopSignificantChangeUpdates];
    else
      [self.locManager stopStandardUpdates];
  }
  self.isGathering = NO;
}

@end
