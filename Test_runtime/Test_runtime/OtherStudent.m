//
//  OtherStudent.m
//  mudleDemo
//
//  Created by 王少帅 on 2020/11/6.
//

#import "OtherStudent.h"

@implementation OtherStudent

- (void)studentGoGoGo:(NSString *)go {
    NSLog(@"%@", [NSString stringWithFormat:@"method: %s , go=%@", __FUNCTION__, go]);
//    self.sName = @"0";
}

- (void)heihei {
    NSLog(@"%@", [NSString stringWithFormat:@"method: %s", __FUNCTION__]);
}

- (void)studentRead {
    NSLog(@"studentRead222");
}
//
//- (void)studentRead999 {
//    NSLog(@"studentRead999");
//}

-(void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"----OtherStudent没有实现方法----- ");
//    [super doesNotRecognizeSelector:aSelector];
}



@end
