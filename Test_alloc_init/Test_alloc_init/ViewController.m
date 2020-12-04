//
//  ViewController.m
//  Test_alloc_init
//
//  Created by 王少帅 on 2020/11/26.
//

#import "ViewController.h"
#import "Person.h"

// 自定义Log日志(1)
#if DEBUG
#define NSLog(FORMAT, ...)  fprintf(stderr, "[%s: %d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...)  nil
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"alloc init 探索");
    
    Person *p1 = [Person alloc];
    Person *p2 = [p1 init];
    Person *p3 = [p1 init];
    
    NSLog(@"%@ - %p", p1, &p1);
    NSLog(@"%@ - %p", p2, &p2);
    NSLog(@"%@ - %p", p3, &p3);
    
    /*
     [ViewController.m: 34行] <Person: 0x6000025cc290> - 0x7ffeed1ca098
     [ViewController.m: 35行] <Person: 0x6000025cc290> - 0x7ffeed1ca090
     [ViewController.m: 36行] <Person: 0x6000025cc290> - 0x7ffeed1ca088
     */

    // 3种断点方式(包括符号断点)查看alloc内部实现(汇编和C++)
    // 详见 视频课第一天001 , 和boundle里面的大师班第一天.png
    
    NSInteger width = 100;
    NSInteger height = 80;
    NSInteger all = width * height;
    
    NSLog(@"%ld --- %ld", (long)all, [self aaaa]);
}


- (NSInteger)aaaa {
    int a = 100;
    int b = 200;
    return (a + b);
}

@end
