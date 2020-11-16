//
//  ViewController.m
//  Test_block
//
//  Created by 王少帅 on 2020/11/16.
//

#import "ViewController.h"

static int a = 999;

@interface ViewController ()

@property (nonatomic, assign) int b;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testBlock];
}


- (void)testBlock {
    _b = 0;
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"&&"];
    __block int age = 18;
    static int height = 188;
    void (^blockWss)(void) = ^{
        [array addObject:@"--"];
        [array addObject:@"++"];
        NSLog(@"age=%d, height=%d, a=%d, b=%d, array=%@", age, height, a, self.b, array);
    };
    age = 20;
    height = 200;
    a = 777;
    _b = 8080;
    [array addObject:@"$$"];
    blockWss();
}


@end
