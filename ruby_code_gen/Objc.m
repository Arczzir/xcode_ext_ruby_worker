//
//  Objc.m
//  XcodeExt
//
//  Created by Z on 2/19/17.
//  Copyright © 2017 Z. All rights reserved.
//

// http://stackoverflow.com/questions/32758811/catching-nsexception-in-swift

#import "Objc.h"

@implementation Objc
+ (BOOL)catchException:(void(^)())tryBlock error:(__autoreleasing NSError **)error {
    @try {
        tryBlock();
        return YES;
    }
    @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
    }
}
@end
