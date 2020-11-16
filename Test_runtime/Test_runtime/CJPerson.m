//
//  CJPerson.m
//  mudleDemo
//
//  Created by 王少帅 on 2020/11/5.
//

#import "CJPerson.h"
#import "CJStudent.h"
#include <objc/message.h>
#import "ViewController.h"
#import "CJDoctor.h"
#import "OtherStudent.h"

@implementation CJPerson

//+ (void)buy
//{
//    NSLog(@"bug------------");
//}

//- (void)buy
//{
//    NSLog(@"buy");
//}

#pragma mark - 动态方法解析(实例)
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(read)) {
        SEL carSel = @selector(buyCar);
        Method carMethod = class_getInstanceMethod(self, carSel);
        IMP carIMP = class_getMethodImplementation(self, carSel);
        const char *type = method_getTypeEncoding(carMethod);
        return class_addMethod(self, sel, carIMP, type);
    }
    return [super resolveInstanceMethod:sel];
}

- (void)buyCar {
    NSLog(@"buyCar --");
}

#pragma mark - 动态方法解析(类)
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(write)) {
        SEL houseSel = @selector(buyHouse);
        Method houseMethod = class_getInstanceMethod(self, houseSel);
        IMP houseIMP = class_getMethodImplementation(self, houseSel);
        const char *type = method_getTypeEncoding(houseMethod);
        return class_addMethod(object_getClass(self), sel, houseIMP, type);
    }
    return NO;
}

- (void)buyHouse {
    NSLog(@"buyHouse --");
}

#pragma mark - 备用接收者
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(studentRead000)) {
        NSLog(@"asd");
        return [OtherStudent new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];//手动生成方法签名
    }
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s, %@ ", anInvocation.methodSignature.methodReturnType, [NSString stringWithUTF8String:@encode(CGFloat)]);
    OtherStudent *o = [OtherStudent alloc];
    if ([o respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:o];
    }
    else [super forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"----Person没有实现anInvocation.selector方法----- ");
//    [super doesNotRecognizeSelector:aSelector];
}

- (void)personRead {
    NSLog(@"personRead");
}


@end
