//
//  JPSDisplayLink.m
//  JPSDisplayLink
//
//  Created by JP Simard on 1/12/2014.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSDisplayLink.h"

@interface JPSDisplayLink ()

@property (nonatomic, copy) JPSDisplayLinkBlock block;
@property (nonatomic, copy) JPSDisplayLinkCompletionBlock completion;
@property (nonatomic, strong) CADisplayLink *caDisplayLink;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval startTime;

@end

@implementation JPSDisplayLink

+ (void)runDisplayLinkWithDuration:(CFTimeInterval)duration block:(JPSDisplayLinkBlock)block completion:(JPSDisplayLinkCompletionBlock)completion {
    JPSDisplayLink *displayLink = [[JPSDisplayLink alloc] init];
    displayLink.block = block;
    displayLink.completion = completion;
    displayLink.duration = duration;
    
    displayLink.caDisplayLink = [CADisplayLink displayLinkWithTarget:displayLink selector:@selector(runBlock)];
    [displayLink.caDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

+ (void)runDisplayLinkWithDuration:(CFTimeInterval)duration block:(JPSDisplayLinkBlock)block {
    [self runDisplayLinkWithDuration:duration block:block completion:nil];
}

- (void)runBlock {
    if (self.startTime == 0) self.startTime = self.caDisplayLink.timestamp;
    
    CFTimeInterval elapsed = self.caDisplayLink.timestamp - self.startTime;
    
    if (elapsed > self.duration) {
        [self.caDisplayLink invalidate];
        if (self.completion) {
            self.completion();
        }
    } else {
        self.block(elapsed / self.duration);
    }
}

@end
