//
//  TimerMiddle.h
//  Test_timer
//
//  Created by 王少帅 on 2020/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerMiddle : NSObject

+ (instancetype)timerMiddleWithTarget:(id)target;
@property (nonatomic, weak) id target;

@end

NS_ASSUME_NONNULL_END
