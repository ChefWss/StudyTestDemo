//
//  ViewController.m
//  Test_timer
//
//  Created by 王少帅 on 2020/11/18.
//

#import "ViewController.h"
#import <objc/message.h>
#import "TimerMiddle.h"
#import "TimerProxy.h"
#import "GcdSafeTimer.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) id target;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"123");
//    [self threadTimer];
//    [self targetTimer];
    
    
    [[[GcdSafeTimer alloc] init] gogogoGcdTimer];
    
    
}


- (void)threadTimer {
    
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.thread1 = [NSThread currentThread];
        [strongSelf.thread1 setName:@"线程1"];
        strongSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:strongSelf selector:@selector(gogogo) userInfo:nil repeats:YES];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:strongSelf.timer forMode:NSDefaultRunLoopMode];
        [runloop run];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.timer && self.thread1) {
//            [self performSelector:@selector(cancelTimer) onThread:self.thread1 withObject:nil waitUntilDone:YES];
            
            dispatch_queue_t q = dispatch_get_global_queue(0, 0);
            dispatch_async(q, ^{
                [self cancelTimer];
            });
        }
    });
}





- (void)gogogo {
    NSLog(@"gogogo %@", [NSThread currentThread]);
}


- (void)cancelTimer {
    if (self.thread1) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (void)targetTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[TimerMiddle timerMiddleWithTarget:self] selector:@selector(gogogo) userInfo:nil repeats:YES];
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:[TimerProxy timerProxyWithTarget:self] selector:@selector(gogogo) userInfo:nil repeats:YES];
}





@end
