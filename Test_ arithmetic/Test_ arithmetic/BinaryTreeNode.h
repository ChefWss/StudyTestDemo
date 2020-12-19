//
//  BinaryTreeNode.h
//  Test_ arithmetic
//
//  Created by 王少帅 on 2020/12/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) BinaryTreeNode *leftNode;
@property (nonatomic, strong) BinaryTreeNode *rightNode;


/**
 *  创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *  @param values 数组
 *  @return 二叉树根节点
 */
+ (BinaryTreeNode *)createBinaryTreeNodeWithValues:(NSArray *)values;

@end

NS_ASSUME_NONNULL_END
