//
//  Target_Push.m
//  Test_CTMediator
//
//  Created by 王少帅 on 2020/11/19.
//

#import "Target_Push.h"
#import "SecondViewController.h"

@implementation Target_Push

- (UIViewController *)Action_NativeToSecondViewController:(NSDictionary *)params {
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    secondVc.params = params;
    return secondVc;
}

@end
