//
//  GcdSafeTimer.m
//  Test_timer
//
//  Created by 王少帅 on 2020/11/24.
//

#import "GcdSafeTimer.h"

@interface GcdSafeTimer ()

@property (nonatomic, strong) dispatch_source_t gcdTimer;

@end

@implementation GcdSafeTimer

- (void)gogogoGcdTimer
{
    NSLog(@"gogogoGcdTimer");

    __block NSInteger count = 10;
    // 获取队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 创建一个定时器 (dispatch_source_t的本质还是个OC对象)
    self.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置定时器的属性
    // GCD的时间参数 (纳秒 1秒=10的9次方纳秒)
    // 何时开始执行第一个任务(WALLTIME是按照真实时间, DISPATCH_TIME_NOW是按照系统时钟,系统休眠时钟不走)
    dispatch_time_t start = DISPATCH_TIME_NOW;
    // 设置时间间隔, 延时
    uint64_t interval = (1.0 * NSEC_PER_SEC);
    uint64_t leeway = 0;
    // 设置定时器
    dispatch_source_set_timer(self.gcdTimer, start, interval, leeway);
    // 设置回调
    NSLog(@"1当前线程 %@ ", [NSThread currentThread]);
    NSLog(@"%@ -- ", self.gcdTimer);
    dispatch_source_set_event_handler(self.gcdTimer, ^{

        if (count <= 0) {
            // 取消定时器
            dispatch_source_cancel(self.gcdTimer);
            self.gcdTimer = nil;
            NSLog(@"取消定时器");
        }
        else {
            NSLog(@"当前线程 %@ ------- %ld", [NSThread currentThread], (long)count);
            count--;
        }

    });
    
    //启动定时器
    dispatch_resume(self.gcdTimer);
    
    
}

@end
