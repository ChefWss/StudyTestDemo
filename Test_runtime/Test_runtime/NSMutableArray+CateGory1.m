//
//  NSMutableArray+CateGory1.m
//  mudleDemo
//
//  Created by 王少帅 on 2020/11/10.
//

#import "NSMutableArray+CateGory1.h"
#import <objc/runtime.h>

@implementation NSMutableArray (CateGory1)

+ (void)load {
    
    NSString *className = NSStringFromClass([self class]);
//    NSLog(@"分类的+load ==> className: %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                
        Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
        Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(ss_objectAtIndex:));
        method_exchangeImplementations(fromMethod, toMethod);
        
    });
    
}

- (id)ss_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
           // 这里做一下异常处理，不然都不知道出错了。
           @try {
               return [self ss_objectAtIndex:index];
           }
           @catch (NSException *exception) {
               // 在崩溃后会打印崩溃信息，方便我们调试。
               NSLog(@"---------- %s 崩溃原因 Method %s  ----------\n", class_getName(self.class), __func__);
               NSLog(@"%@", [exception callStackSymbols]);
               return nil;
       }
           @finally {}
       } else {
           return [self ss_objectAtIndex:index];
       }
}



- (void)ss_addObject:(id)anObject {
    NSLog(@"%@", @"ss_addObject");
//    [self ss_addObject:anObject];
}



static const char *hahahaKey = "hahaha";

- (void)setHahaha:(NSString *)hahaha {
    objc_setAssociatedObject(self, hahahaKey, hahaha, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)hahaha {
    return objc_getAssociatedObject(self, hahahaKey);
}


@end
