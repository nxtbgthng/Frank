//
//  TypeOperationCommand.m
//  Frank
//
//  Created by Tobias Kräntzer on 31.10.11.
//  Copyright (c) 2011 nxtbgthng. All rights reserved.
//

#import "KIFTestStep.h"
#import "JSON.h"

#import "TypeOperationCommand.h"

@implementation TypeOperationCommand

- (NSString *)handleCommandWithRequestBody:(NSString *)requestBody {
    
    NSDictionary *requestCommand = [requestBody JSONValue];
	NSString *label = [requestCommand objectForKey:@"accessibilityLabel"];
	NSString *text = [requestCommand objectForKey:@"text"];
    
    
    KIFTestStep *step = [KIFTestStep stepToEnterText:text intoViewWithAccessibilityLabel:label];
    
    NSError *error = nil;
    switch ([step executeAndReturnError:&error]) {
        case KIFTestStepResultFailure:
            return [[NSDictionary dictionaryWithObjectsAndKeys: 
                     @"ERROR", @"outcome",
                     [error localizedDescription], @"reason",
                     nil] JSONRepresentation];
            
        default:
            return [[NSDictionary dictionaryWithObjectsAndKeys: 
                     @"SUCCESS", @"outcome",
                     nil] JSONRepresentation];
    };
}

@end
