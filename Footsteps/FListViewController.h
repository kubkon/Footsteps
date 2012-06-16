//
//  FListViewController.h
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FListViewController : UITableViewController
{
  NSArray *_locations;
  NSManagedObjectContext *_managedObjectContext;
}

@property (nonatomic, retain) NSArray *locations;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
