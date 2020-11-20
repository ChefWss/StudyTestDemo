//
//  TimerMiddle.m
//  Test_timer
//
//  Created by 王少帅 on 2020/11/19.
//

#import "TimerMiddle.h"

@implementation TimerMiddle

+ (instancetype)timerMiddleWithTarget:(id)target {
    TimerMiddle *middle = [[TimerMiddle alloc] init];
    middle.target = target;
    return middle;
}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return self.target;
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}


@end
