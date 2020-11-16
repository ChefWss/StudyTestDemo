//
//  OtherStudent+Category3.m
//  mudleDemo
//
//  Created by 王少帅 on 2020/11/10.
//

#import "OtherStudent+Category3.h"
#import <objc/runtime.h>

@implementation OtherStudent (Category3)

- (void)heihei {
    NSLog(@"%@", [NSString stringWithFormat:@"method: %s", __FUNCTION__]);
}

+ (void)load {
    
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"分类的+load , className: %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                
        SEL oldSelector = @selector(studentGoGoGo:);
        SEL newSelector = @selector(studentGoGoGoC3:);
        
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

- (void)studentGoGoGoC3:(NSString *)go {
    NSLog(@"%@", [NSString stringWithFormat:@"method: %s , go=%@", __FUNCTION__, go]);
    self.sName = @"3";
}

@end
