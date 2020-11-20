//
//  CTMediator+PushActions.h
//  Test_CTMediator
//
//  Created by 王少帅 on 2020/11/19.
//

#import "CTMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (PushActions)

- (UIViewController *)dtp_mediator_ctmdiatorPushViewControllerWithParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
