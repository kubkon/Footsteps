//
//  FListViewController.h
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
