//
//  FLocationAnnotation.m
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#import "FLocationAnnotation.h"

@implementation FLocationAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle
{
  self = [super init];
  
  if (self)
  {
    _coordinate = coordinate;
    _title = title;
    _subtitle = subtitle;
  }
  
  return self;
}

@end
