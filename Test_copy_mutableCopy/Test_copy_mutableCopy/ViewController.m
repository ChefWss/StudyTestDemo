//
//  ViewController.m
//  Test_copy_mutableCopy
//
//  Created by 王少帅 on 2020/12/11.
//

#import "ViewController.h"
#import "A.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *strongString;
@property (nonatomic, copy) NSString *copyedString;

@property (nonatomic, strong) NSString *strongString2;
@property (nonatomic, copy) NSString *copyedString2;

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    [self run];
//}
//
//- (void)run {
//    for (int i = 0; i < 10; i++) {
//        __autoreleasing A *a = [A new];
//        a.aaa = i;
//        NSLog(@"run %d %@", i, a);
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    NSMutableString *muStr = [NSMutableString stringWithString:@"muStr"];

    self.strongString = muStr;
    self.copyedString = muStr;

    muStr = [NSMutableString stringWithString:@"gogogo"];

    NSLog(@"1. %@ %p  %p", muStr, muStr, &muStr);
    NSLog(@"2. %@ %p  %p", _strongString, _strongString, &_strongString);
    NSLog(@"3. %@ %p  %p \n.", _copyedString, _copyedString, &_copyedString);

    // 1和2: 对象地址相同,指针地址不相同.  结论: strong->就是多了一根指针指向当前对象地址.

    [muStr appendString:@"111111"];

    NSLog(@"1. %@ %p  %p", muStr, muStr, &muStr);
    NSLog(@"2. %@ %p  %p", _strongString, _strongString, &_strongString);
    NSLog(@"3. %@ %p  %p \n.", _copyedString, _copyedString, &_copyedString);




    NSString *str = [NSString stringWithFormat:@"str"];
    self.strongString2 = str;
    self.copyedString2 = str;
    NSLog(@"1. %@ %p  %p", str, str, &muStr);
    NSLog(@"2. %@ %p  %p", _strongString2, _strongString2, &_strongString2);
    NSLog(@"3. %@ %p  %p \n.", _copyedString2, _copyedString2, &_copyedString2);



    NSString *string1 = @"wangshao";
    NSString *string2 = @"wangshao";
    NSString *string3 = [NSString stringWithFormat:@"wangshao"];
    NSString *string4 = [NSString stringWithFormat:@"wangshao"];
    NSLog(@"\n%p\n%p\n%p\n%p", string1, string2, string3, string4);
    NSLog(@"\n%p\n%p\n%p\n%p", &string1, &string2, &string3, &string4);
    // 结论: string1 和 string2 是常量区字符串, 地址相同, 指针不同
    // 结论: string3 和 string4 是堆区字符串, 地址相同, 指针不同

}


@end
