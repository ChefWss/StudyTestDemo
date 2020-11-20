//
//  Target_Push.h
//  Test_CTMediator
//
//  Created by 王少帅 on 2020/11/19.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Target_Push : NSObject

- (UIViewController *)Action_NativeToSecondViewController:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
