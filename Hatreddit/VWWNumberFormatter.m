//
//  VWWNumberFormatter.m
//  Hatreddit
//
//  Created by Zakk Hoyt on 4/23/13.
//  Copyright (c) 2013 Zakk Hoyt. All rights reserved.
//

#import "VWWNumberFormatter.h"

@implementation VWWNumberFormatter

- (BOOL)isPartialStringValid:(NSString **)partialStringPtr
       proposedSelectedRange:(NSRangePointer)proposedSelRangePtr
              originalString:(NSString *)origString
       originalSelectedRange:(NSRange)origSelRange
            errorDescription:(NSString **)error{
 
    NSCharacterSet *allowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
	NSRange inRange = [*partialStringPtr rangeOfCharacterFromSet:allowedChars];
	if(inRange.location != NSNotFound){
		return NO;
	}
    else {
		return YES;
	}
    
}
@end
