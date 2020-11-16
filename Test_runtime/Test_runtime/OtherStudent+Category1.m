//
//  OtherStudent+Category1.m
//  mudleDemo
//
//  Created by 王少帅 on 2020/11/10.
//

#import "OtherStudent+Category1.h"
#import <objc/runtime.h>

@implementation OtherStudent (Category1)

- (void)heihei {
    NSLog(@"%@", [NSString stringWithFormat:@"method: %s", __FUNCTION__]);
}

+ (void)load {
    
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"分类的+load ==> className: %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                
        SEL oldSelector = @selector(studentGoGoGo:);
        SEL newSelector = @selector(studentGoGoGoC1:);
        
        Method oldM = class_getInstanceMethod(self, oldSelector);
        Method newM = class_getInstanceMethod(self, newSelector);
        
        BOOL add = class_addMethod(self, oldSelector, method_getImplementation(newM), method_getTypeEncoding(newM));

        if (add) {
            class_replaceMethod(self, newSelector, method_getImplementation(oldM), method_getTypeEncoding(oldM));
        }
        else {
            method_exchangeImplementations(oldM, newM);
        }
        
    });
    
}

- (void)studentGoGoGoC1:(NSString *)go {
    NSLog(@"%@", [NSString stringWithFormat:@"method: %s , go=%@", __FUNCTION__, go]);
    self.sName = @"1";
}



@end
