//
//  FLocationRecord.m
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//

#import "FLocationRecord.h"


@implementation FLocationRecord

@dynamic timeStamp;
@dynamic latitude;
@dynamic longitude;
@dynamic accuracy;
@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (CLLocationCoordinate2D)coordinate
{
  return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

- (NSString *)title
{
  NSDateFormatter *format = [[NSDateFormatter alloc] init];
  [format setTimeStyle:NSDateFormatterMediumStyle];
  [format setDateStyle:NSDateFormatterLongStyle];
  NSString *timestamp = [format stringFromDate:self.timeStamp];
  return [NSString stringWithFormat:@"%@", timestamp];
}

- (NSString *)subtitle
{
  return [NSString stringWithFormat:@"Accuracy: %gm", self.accuracy.doubleValue];
}

@end
