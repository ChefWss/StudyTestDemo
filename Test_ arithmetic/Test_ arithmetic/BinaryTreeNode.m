//
//  BinaryTreeNode.m
//  Test_ arithmetic
//
//  Created by 王少帅 on 2020/12/19.
//

#import "BinaryTreeNode.h"

#define NSLog(FORMAT, ...)  fprintf(stderr, "[%s: %d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation BinaryTreeNode

/**
 *  创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *  @param values 数组
 *  @return 二叉树根节点
 */
+ (BinaryTreeNode *)createBinaryTreeNodeWithValues:(NSArray *)values
{
    BinaryTreeNode *rootNode = nil;
    for (int i = 0; i < values.count; i++) {
        NSInteger value = [values[i] integerValue];
        rootNode = [BinaryTreeNode addBinaryTreeNode:rootNode addValue:value];
    }
    NSLog(@"root:%ld   left:%ld   right:%ld   临时:%ld   深度:%ld   总节点数:%ld",
          rootNode.value,
          rootNode.leftNode.value,
          rootNode.rightNode.value,
          rootNode.leftNode.rightNode.value,
          [BinaryTreeNode deepOfTreeNode:rootNode],
          [BinaryTreeNode numberOfTreesWithRootNode:rootNode]);
    
    return rootNode;
}


/**
 *  向二叉排序树节点添加一个节点
 *  @param treeNode 根节点
 *  @param value    值
 *  @return 根节点
 */
+ (BinaryTreeNode *)addBinaryTreeNode:(BinaryTreeNode *)treeNode addValue:(NSInteger)value
{
    if (!treeNode) {
        // 如果节点不存在就创建新节点
        treeNode = [[BinaryTreeNode alloc] init];
        treeNode.value = value;
    }
    else if (value < treeNode.value) {
        // 生成左子树
        treeNode.leftNode = [BinaryTreeNode addBinaryTreeNode:treeNode.leftNode addValue:value];
    }
    else {
        // 生成右子树
        treeNode.rightNode = [BinaryTreeNode addBinaryTreeNode:treeNode.rightNode addValue:value];
    }
    return treeNode;
}


/**
 *  二叉树的深度
 *  @param rootNode 二叉树根节点
 *  @return 二叉树的深度
 */
+ (NSInteger)deepOfTreeNode:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return 0;
    }
    else if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    // 二叉树深度 = MAX(左子树深度, 右子树深度) + 1
    NSInteger leftDeep = [BinaryTreeNode deepOfTreeNode:rootNode.leftNode];
    NSInteger rightDeep = [BinaryTreeNode deepOfTreeNode:rootNode.rightNode];
    
    NSInteger deep = MAX(leftDeep, rightDeep) + 1;
    NSLog(@"deep:%ld", deep);
    return deep;
}


/**
 *  二叉树的所有节点数
 *  @param rootNode 根节点
 *  @return 所有节点数
 */
+ (NSInteger)numberOfTreesWithRootNode:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return 0;
    }
    
    // 节点总数 = 左子树节点总数 + 柚子树节点总数 + 根节点1
    NSInteger leftAll = (NSInteger)[BinaryTreeNode numberOfTreesWithRootNode:rootNode.leftNode];
    NSInteger rightAll = (NSInteger)[BinaryTreeNode numberOfTreesWithRootNode:rootNode.rightNode];
    
    NSInteger all = leftAll + rightAll + 1;
    NSLog(@"all:%ld", all);
    return all;
}


/**
 *  翻转二叉树（又叫：二叉树的镜像）
 *  @param rootNode 根节点
 *  @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return nil;
    }
    else if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [BinaryTreeNode invertBinaryTree:rootNode.leftNode];
    [BinaryTreeNode invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    
    return rootNode;
}

@end
