//
//  Objc.h
//  XcodeExt
//
//  Created by Z on 2/19/17.
//  Copyright © 2017 Z. All rights reserved.
//

// http://stackoverflow.com/questions/32758811/catching-nsexception-in-swift

#import <Foundation/Foundation.h>

@interface Objc : NSObject
+ (BOOL)catchException:(void(^)())tryBlock error:(__autoreleasing NSError **)error;
@end
