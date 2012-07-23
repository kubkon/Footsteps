//
//  FConstants.m
//  Footsteps
//
//  Created by Jakub Konka on 16/06/2012.
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

#import "FConstants.h"

#pragma mark - Strings

#pragma mark LocationRecord
NSString * const LOCATION_RECORD = @"LocationRecord";
NSString * const TIMESTAMP = @"timeStamp";
NSString * const LATITUDE = @"latitude";
NSString * const LONGITUDE = @"longitude";
NSString * const ACCURACY = @"accuracy";

#pragma mark User Defaults
NSString * const BOOL_GATHERING = @"isGathering";
NSString * const BOOL_LOW_POWER = @"low_power_toggle_switch";

#pragma mark Files
NSString * const MARKER_FILENAME = @"marker";
NSString * const MARKER_EXT = @"png";