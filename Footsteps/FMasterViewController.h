//
//  FMasterViewController.h
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//

#import <UIKit/UIKit.h>
#import "FLocationManagerDelegate.h"

@interface FMasterViewController : UIViewController {
  IBOutlet UIButton *_startStopButton;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) FLocationManagerDelegate *locManager;
@property (nonatomic, assign) BOOL isGathering;

- (IBAction)gatherDataOnClick:(id)sender;

- (void)startGatheringLocationData;
- (void)stopGatheringLocationData;

@end
