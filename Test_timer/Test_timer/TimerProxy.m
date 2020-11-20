//
//  TimerProxy.m
//  Test_timer
//
//  Created by 王少帅 on 2020/11/19.
//

#import "TimerProxy.h"

@implementation TimerProxy

+ (instancetype)timerProxyWithTarget:(id)target {
    TimerProxy *proxy = [TimerProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
