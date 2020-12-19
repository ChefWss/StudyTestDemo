//
//  ViewController.m
//  Test_ arithmetic
//
//  Created by 王少帅 on 2020/12/9.
//

#import "ViewController.h"
#import "TestBinaryTree.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *array1;
@property (nonatomic, strong) NSMutableArray *array2;

@property (nonatomic, assign) NSInteger circle; // 循环次数


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.array1 = @[@16,@1,@2,@9,@7,@12,@5,@3,@8,@13,@10,@0,@3133,@21,@3,@33,@3,@345,@444,@1].mutableCopy;
    self.array2 = @[@16,@3,@999,@3,@0].mutableCopy;
    
    NSLog(@"算法");

    
//    [self maopao];
//    [self xuanze];
//    [self charu];
//    NSLog(@"数组个数: %ld, 循环: %ld\n%@", self.array1.count, self.circle, self.array1);
    
    
//    [self suanfati_2ArrayIntersection];
    
    
//    NSMutableArray *arr = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15].mutableCopy;
//    [self suanfati_2withArray:arr withK:6 add:@[].mutableCopy];
    
    
    
    TestBinaryTree *test = [[TestBinaryTree alloc] init];
}




- (void)maopao
{
    // 冒泡排序: 稳定 时间复杂度 O(n²)
    
    for (int i = 0; i < _array1.count-1; i++) {
        for (int j = i+1; j < _array1.count; j++) {
            _circle++;
            if ([_array1[i] intValue] > [_array1[j] intValue]) {
                id temp = _array1[i];
                _array1[i] = _array1[j];
                _array1[j] = temp;
            }
        }
    }
}


- (void)xuanze
{
    // 选择排序: 不稳定 时间复杂度O(n²)

    int minIndex = 0, arrCount = (int)_array1.count;
    for (int i = 0; i < arrCount-1; i++) {
        minIndex = i;
        for (int j = i+1; j < arrCount; j++) {
            _circle++;
            if ([_array1[minIndex] intValue] > [_array1[j] intValue]) {
                minIndex = j;
            }
        }
        if (minIndex != i) {
            [_array1 exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
        }
    }
}


- (void)charu
{
    // 插入排序: 稳定 时间复杂度O(n²)
    // TODO: 还不理解!!!
    
    for (int i = 0; i < _array1.count; i++) {
        id temp = _array1[i];
        int j = i-1;
        while (j >= 0 && [_array1[j] intValue] > [temp intValue]) {
            _array1[j+1] = _array1[j];
            j--;
            _circle++;
        }
        _array1[j+1] = temp;
    }
}


- (void)kuaisu
{
    // 快速排序:
}


- (void)xier
{
    // 希尔排序:
}


- (void)dui
{
    // 堆排序:
}


- (void)binggui
{
    // 归并排序:
}


- (void)suanfati_2ArrayIntersection
{
    // 算法题: 两个数组的交集

    // 方法1: 集合Set
    
    NSMutableSet *set = [NSMutableSet set];
    NSMutableSet *setResult = [NSMutableSet set];

    for (int i = 0; i < _array2.count; i++) {
        if (![set containsObject:_array2[i]])
        {
            [set addObject:_array2[i]];
        }
    }

    for (int i = 0; i < _array1.count; i++) {
        if ([set containsObject:_array1[i]]) {
            [setResult addObject:_array1[i]];
        }
    }
    
    NSLog(@"集合 Set 法: %@", setResult);

    
    return;
    
    /*
     (2个有序数组可以用->) 方法二：排序 + 双指针 (得到的是不重复的值)
     如果两个数组是有序的，则可以使用双指针的方法得到两个数组的交集。

     首先对两个数组进行排序，然后使用两个指针遍历两个数组。可以预见的是加入答案的数组的元素一定是递增的，为了保证加入元素的唯一性，我们需要额外记录变量pre 表示上一次加入答案数组的元素。

     初始时，两个指针分别指向两个数组的头部。每次比较两个指针指向的两个数组中的数字，如果两个数字不相等，则将指向较小数字的指针右移一位，如果两个数字相等，且该数字不等于 pre ，将该数字添加到答案并更新 pre 变量，同时将两个指针都右移一位。当至少有一个指针超出数组范围时，遍历结束。

     链接：https://leetcode-cn.com/problems/intersection-of-two-arrays/solution/liang-ge-shu-zu-de-jiao-ji-by-leetcode-solution/
     */

    self.array1 = @[@1,@2,@9,@12,@13,@313,@2244].mutableCopy;
    self.array2 = @[@6,@9,@9,@9,@13,@999,@3122].mutableCopy;
    
    int len1 = (int)_array1.count, len2 = (int)_array2.count;
    int p1 = 0, p2 = 0;
    
    NSMutableArray *xArr = [NSMutableArray array]; // 交叉的数组
    
    while (p1 < len1 && p2 < len2) {
        id p1Value = _array1[p1];
        id p2Value = _array2[p2];
        
        if ([p1Value intValue] == [p2Value intValue])
        {
            if ([p1Value intValue] != [xArr.lastObject intValue]) {
                [xArr addObject:p1Value];
            }
            p1++;
            p2++;
        }
        else if ([p1Value intValue] < [p2Value intValue])
        {
            p1++;
        }
        else if ([p1Value intValue] > [p2Value intValue])
        {
            p2++;
        }
    }
    
    NSLog(@"排序+双指针法: %@", xArr);
}



- (void)suanfati_2withArray:(NSMutableArray *)arr withK:(int)k add:(NSMutableArray *)addArr
{
    // 算法题: 单向链表每k个元素翻转一次（图解）
    // TODO: 没写完,还有末尾不整除的问题
    
    int len = (int)arr.count;
        for (int i = 0; i < len - (len % k); i++) {
            if (i % k == floor(k / 2.0)) {
                for (int j = 0; j < floor(k / 2.0) ; j++) {
                    [arr exchangeObjectAtIndex:i-j-1 withObjectAtIndex:i+j+(k%2)];
                }
            }
        }
    
    NSLog(@"%@", arr);
        
//    if (len % k != 0) {
//        NSMutableArray *lastArr = @[@13,@14,@15].mutableCopy;
//        [self suanfati_2withArray:lastArr withK:(int)lastArr.count add:arr];
//        [arr replaceObjectsInRange:NSMakeRange(len-(len % k), len % k) withObjectsFromArray:lastArr];
//        return nil;
//    }
//    else {
//        NSLog(@" 结果  %@", addArr);
//        return addArr;
//    }
}


@end
