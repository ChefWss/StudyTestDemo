//
//  TimerTarget.h
//  Test_timer
//
//  Created by 王少帅 on 2020/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerTarget : NSObject

+ (instancetype)timerWithTarget:(id)target;
@property (nonatomic, weak) id target;

@end

NS_ASSUME_NONNULL_END
