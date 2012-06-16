//
//  FConstants.h
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
//  Copyright (c) 2012 Jakub Konka. All rights reserved.
//

#ifndef Footsteps_FConstants_h
#define Footsteps_FConstants_h

#pragma mark - NSIntegers
#define DISTANCE_FILTER 50

#pragma mark - Floats/Doubles
#define MIN_AGE_LOCATION_UPDATE 60.0

#pragma mark - Strings
#pragma mark LocationRecord
#define LOCATION_RECORD @"LocationRecord"
#define TIMESTAMP @"timeStamp"
#define LATITUDE @"latitude"
#define LONGITUDE @"longitude"
#define ACCURACY @"accuracy"
#pragma mark FMasterViewController
#define START_BUTTON_LABEL @"Start"
#define STOP_BUTTON_LABEL @"Stop"
#define BOOL_GATHERING @"isGathering"
#pragma mark FListViewController
#define LIST_VIEW_TITLE @"Locations"
#pragma mark FMapViewController
#define DEFAULT_ANNOTATION_VIEW @"FAnnotationView"
#define MARKER_FILENAME @"marker"
#define MARKER_EXT @"png"

#endif