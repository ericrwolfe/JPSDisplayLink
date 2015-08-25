//
//  JPSDisplayLink.h
//  JPSDisplayLink
//
//  Created by JP Simard on 1/12/2014.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JPSDisplayLinkBlock)(CGFloat progress);
typedef void (^JPSDisplayLinkCompletionBlock)(void);

@interface JPSDisplayLink : NSObject

/**
 This block is called multiple times.
 The CGFloat progress is between 0.0 and 1.0 based on the percentage
 of the total duration that has elapsed since the begininning of execution.
*/

+ (void)runDisplayLinkWithDuration:(CFTimeInterval)duration block:(JPSDisplayLinkBlock)block;

+ (void)runDisplayLinkWithDuration:(CFTimeInterval)duration block:(JPSDisplayLinkBlock)block completion:(JPSDisplayLinkCompletionBlock)completion;

@end
