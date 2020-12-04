//
//  ViewController.m
//  Test_thread
//
//  Created by 王少帅 on 2020/12/4.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) NSInteger tickets; // 票

@property (nonatomic, strong) NSLock *mutexLock; // 互斥锁

@property (nonatomic, strong) NSRecursiveLock *reLock; // 递归锁

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tickets = 8; // 8张余票

    
//    [self lock_sunchronized];
//    [self lock_nslock];
//    [self digui];
//    [self lock_dispatch_semaphore];
    [self lock_barrier];
}


#pragma mark - @synchronized
- (void)lock_sunchronized
{
    // 10个柜台
    for (int i = 0; i< 10; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self sale_sunchronized];
        });
    }
}


- (void)sale_sunchronized
{
    @synchronized (self)
    {
        [NSThread sleepForTimeInterval:1];
        
        if (_tickets > 0)
        {
            _tickets--;
            NSLog(@"余票 = %ld, thread: %@", _tickets, [NSThread currentThread]);
        }
        else
        {
            NSLog(@"没票了了了, thread: %@", [NSThread currentThread]);
        }
    }
}


#pragma mark - NSlock
- (void)lock_nslock
{
    _mutexLock = [[NSLock alloc] init]; // 创建互斥锁
    
    // 10个柜台
    for (int i = 0; i< 10; i++)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self sale_nslock];
        });
    }
}


- (void)sale_nslock
{
    [_mutexLock lock];
        
    [NSThread sleepForTimeInterval:1];
    
    if (_tickets > 0)
    {
        _tickets--;
        NSLog(@"余票 = %ld, thread: %@", _tickets, [NSThread currentThread]);
    }
    else
    {
        NSLog(@"卖完了票哦, thread: %@", [NSThread currentThread]);
    }
    
    [_mutexLock unlock];
}


#pragma mark - 递归锁 NSRecursiveLock
- (void)digui
{
    _mutexLock = [[NSLock alloc] init];
    _reLock = [[NSRecursiveLock alloc] init];
    
    // 递归的方式加锁, 应该用 NSRecursiveLock 递归锁, 用 nslock 会死锁
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self sale:self.tickets lock:self.mutexLock]; //错
        [self sale:self.tickets lock:self.reLock]; //对
    });
}


- (void)sale:(NSInteger)value lock:(id)lock
{
    [lock lock];
    if (_tickets > 0)
    {
        [NSThread sleepForTimeInterval:1];
        NSLog(@"%ld", (long)_tickets);
        [self sale:(_tickets--) lock:lock];
    }
    [lock unlock];
}


#pragma mark - 信号量 dispatch_semaphore
- (void)lock_dispatch_semaphore
{
    // 创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    // 线程1
    NSLog(@"1 %@", semaphore);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
        NSLog(@"3");
        NSLog(@"任务1, thread: %@", [NSThread currentThread]);
        sleep(5);
        NSLog(@"4");
        dispatch_semaphore_signal(semaphore);
        sleep(3);
        NSLog(@"5");
    });
    
    NSLog(@"return");
//    return;
    
    NSLog(@"6");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"a");
        NSLog(@"b");
        NSLog(@"任务c, thread: %@", [NSThread currentThread]);
        sleep(3);
        NSLog(@"d");
        dispatch_semaphore_signal(semaphore);
        NSLog(@"e");
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"7");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"8");
    
}


#pragma mark - 栅栏函数 dispatch_barrier_async
- (void)lock_barrier
{
    dispatch_queue_t queue = dispatch_queue_create("栅栏aaa", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"A----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"B----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"C----%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"栅栏1----%@",[NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"D----%@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"栅栏2----%@",[NSThread currentThread]);
        sleep(3);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"E----%@",[NSThread currentThread]);
    });
}


@end
