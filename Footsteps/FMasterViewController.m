//
//  FMasterViewController.m
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are
//  met:
//   
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  
//  2. Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer in the
//     documentation and/or other materials provided with the distribution.
//   
//  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
//  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
//  AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
//  JAKUB KONKA BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "FMasterViewController.h"
#import "FConstants.h"

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
  // Check which type of location updates we should gather
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  BOOL isLowPowerOn = [defaults boolForKey:BOOL_LOW_POWER];
  if (isLowPowerOn)
    [_locManager startSignificantChangeUpdates];
  else
    [_locManager startStandardUpdates];
  _isGathering = YES;
}

- (void)stopGatheringLocationData
{
  if (_locManager)
  {
    // Check which type of location updates are being gathered
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLowPowerOn = [defaults boolForKey:BOOL_LOW_POWER];
    if (isLowPowerOn)
      [_locManager stopSignificantChangeUpdates];
    else
      [_locManager stopStandardUpdates];
  }
  _isGathering = NO;
}

@end
