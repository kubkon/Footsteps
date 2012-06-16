//
//  FMasterViewController.h
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLocationManagerDelegate.h"

@interface FMasterViewController : UIViewController
{
  IBOutlet UIButton *_startStopButton;
  FLocationManagerDelegate *_locManager;
}

@property (nonatomic, retain) UIButton *startStopButton;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) FLocationManagerDelegate *locManager;
@property (nonatomic, assign) BOOL isGathering;

- (IBAction)gatherDataOnClick:(id)sender;

- (void)startGatheringLocationData;
- (void)stopGatheringLocationData;

- (void)saveToUserDefaults:(BOOL)gathering;
- (BOOL)retrieveFromUserDefaults;

@end
