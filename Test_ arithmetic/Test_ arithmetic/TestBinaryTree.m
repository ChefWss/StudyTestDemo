//
//  TestBinaryTree.m
//  Test_ arithmetic
//
//  Created by 王少帅 on 2020/12/19.
//

#import "TestBinaryTree.h"
#import "BinaryTreeNode.h"

@implementation TestBinaryTree

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *arr = @[@16,@1,@10];
        
        [BinaryTreeNode createBinaryTreeNodeWithValues:arr];

    }
    return self;
}

@end
