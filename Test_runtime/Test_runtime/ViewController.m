//
//  ViewController.m
//  Test_runtime
//
//  Created by 王少帅 on 2020/11/16.
//

#import "ViewController.h"
#include <objc/message.h> // 使用runtime需要配置: Preprocessing -> Enable Strict Checking of objc_msgSend Calls => NO
#import "CJPerson.h"
#import "CJStudent.h"
#import "OtherStudent.h"
#import "OtherStudent+Category1.h"
#import "OtherStudent+Category2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self categoryOtherStudentRunOldFunc];
}


- (void)categoryOtherStudentRunOldFunc {
    
    //胡哥,我总结了一下你听下我想的对不对哈
    //category给类添方法分2种
    //(1)如果使用黑魔法的方式加了 function1 , 想用原来的 function0 的话需要用 performSelector:function1
    //(2)如果是在category的.h加了声明 function2, 然后.m实现了function2, 想用原来的 function0 的话需要遍历 methods 找到 lastSEL 用 objcSend 实现

    
    /* 根据 Compile Source 中的入栈顺序
            method          IMP          IMP          IMP          IMP
            原类             原            C1           C2           C3
            C1              C1    ==>     原    ==>    原    ==>     原
                                          C2           C1           C1
                                                       C3           C2
     */
    
    
    OtherStudent *s = [[OtherStudent alloc] init];
    [s studentGoGoGo:@"直接调用"];
    [s performSelector:@selector(studentGoGoGo:) withObject:@"-C0"];
    [s performSelector:@selector(studentGoGoGoC1:) withObject:@"-C1"];
    [s performSelector:@selector(studentGoGoGoC2:) withObject:@"-C2"];
    [s performSelector:@selector(studentGoGoGoC3:) withObject:@"-C3"];
    [s performSelector:@selector(heihei)];
    
    NSLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  我是分割线  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    
    Class studentClass = [OtherStudent class];
    
    if (studentClass) {
        unsigned int methodsCount;
        Method *methodList = class_copyMethodList(studentClass, &methodsCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        
        for (int i=0; i < methodsCount; i++) {
            Method method = methodList[i];
            NSString *methodNameString = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
            
            NSLog(@"方法列表 -------------  %@", methodNameString);
            
            if ([methodNameString isEqualToString:@"studentGoGoGo:"]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
//                break;
            }
        }
        
        free(methodList);
        
        OtherStudent *st = [[OtherStudent alloc] init];
        
        typedef void (*imp)(id, SEL);
        
        if (lastImp != NULL) {
            imp i = (imp)lastImp;
            i(st, lastSel);
        }
        
    }
    
}


- (void)testRuntime {
    CJPerson *p = [[CJPerson alloc] init];
    CJStudent *s = objc_msgSend(objc_getClass("CJStudent"), sel_registerName("alloc"));
//        objc_msgSend(s, NSSelectorFromString(@"buy"));
    objc_msgSend(p, sel_registerName("read"));
    objc_msgSend(objc_getClass("CJPerson"), sel_registerName("write"));
    objc_msgSend(p, sel_registerName("studentRead999"));

//    objc_msgSend([OtherStudent alloc], sel_registerName("student111"));


    NSMutableString *ss = @"sdf";
//    NSAssert(ss.length != 3 , @"错了");
//        [ss appendFormat:@"dsf"];
    NSLog(@"我还活着 %@", ss);

//    [p buy];
//    [CJPerson buy];
}

@end
