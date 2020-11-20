//
//  CTMediator+PushActions.m
//  Test_CTMediator
//
//  Created by 王少帅 on 2020/11/19.
//

#import "CTMediator+PushActions.h"

NSString *const kCTMediatorTarget_Push = @"Push";
NSString *const kCTMediatorActionNativeTo_SecondViewController = @"NativeToSecondViewController";

@implementation CTMediator (PushActions)

- (UIViewController *)dtp_mediator_ctmdiatorPushViewControllerWithParams:(NSDictionary *)params {
    UIViewController *vc = [self performTarget:kCTMediatorTarget_Push
                                        action:kCTMediatorActionNativeTo_SecondViewController
                                        params:params
                             shouldCacheTarget:NO];
    if ([vc isKindOfClass:[UIViewController class]]) {
        NSLog(@"%@ 实例化vc成功", NSStringFromSelector(_cmd));
        return vc;
    }
    else {
        NSLog(@"%@ 实例化vc失败", NSStringFromSelector(_cmd));
        return [UIViewController new];
    }
}

@end
