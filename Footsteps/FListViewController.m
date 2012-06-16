//
//  FListViewController.m
//  Footsteps
//
//  Created by Jakub Konka on 15/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import "FListViewController.h"
#import "FConstants.h"
#import "FAppDelegate.h"

@interface FListViewController ()

@end

@implementation FListViewController

@synthesize locations = _locations;
@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
      // Custom initialization
  }
  return self;
}

- (void)dealloc
{
  _locations = nil;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.title = LIST_VIEW_TITLE;
  // Get instance of ManagedObjectContext
  if (!_managedObjectContext)
  {
    FAppDelegate *appDelegate = (FAppDelegate *)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = appDelegate.managedObjectContext;
  }
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if (_managedObjectContext)
  {
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:LOCATION_RECORD inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    _locations = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [_locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  // Configure the cell...
  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  
  NSManagedObject *location = [_locations objectAtIndex:indexPath.row];
  NSDateFormatter *format = [[NSDateFormatter alloc] init];
  [format setTimeStyle:NSDateFormatterMediumStyle];
  [format setDateStyle:NSDateFormatterLongStyle];
  NSString *timestamp = [format stringFromDate:(NSDate *)[location valueForKey:TIMESTAMP]];
  cell.textLabel.text = [NSString stringWithFormat:@"%@", timestamp];
  NSNumber *latitudeObj = [location valueForKey:LATITUDE];
  NSNumber *longitudeObj = [location valueForKey:LONGITUDE];
  NSNumber *accuracyObj = [location valueForKey:ACCURACY];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"Latitude: %g\nLongitude: %g\nAccuracy: %gm", latitudeObj.doubleValue, longitudeObj.doubleValue, accuracyObj.doubleValue];
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
