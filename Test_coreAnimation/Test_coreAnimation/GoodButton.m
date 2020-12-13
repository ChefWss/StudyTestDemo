//
//  GoodButton.m
//  Test_coreAnimation
//
//  Created by 王少帅 on 2020/12/13.
//

#import "GoodButton.h"

@implementation GoodButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.greenColor;
        [self createUI];
    }
    return self;
}


- (void)createUI
{
    // 粒子
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosionCell";
    explosionCell.birthRate = 2000;
    // 透明值变化速度
    explosionCell.alphaSpeed = -1;
    explosionCell.scaleSpeed = -0.02;
    // 透明值范围
    explosionCell.alphaRange = .1;
    // 生命周期
    explosionCell.lifetime = 2;
    // 生命周期范围
    explosionCell.lifetimeRange = .1;
    // 粒子速度
    explosionCell.velocity = 30;
    // 粒子速度范围
    explosionCell.velocityRange = 5;
    // 缩放比例
    explosionCell.scale = 0.05;
    // 缩放比例范围
    explosionCell.scaleRange = .01;
    // 粒子图片
    explosionCell.contents = (id)[UIImage imageNamed:@"red"].CGImage;
    
    
    // 发射源
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer = emitterLayer;
    // 发射源尺寸
    emitterLayer.emitterSize = self.bounds.size;
    emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    emitterLayer.birthRate = 0;
    // 粒子从什么形状发射出来
    emitterLayer.emitterShape = kCAEmitterLayerCircle;
    // 粒子发射模型
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    // 渲染模式
    emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    
    // 粒子添加到发射器
    emitterLayer.emitterCells = @[explosionCell];
    [self.layer addSublayer:emitterLayer];
}


//// 设置发射源的位置
//- (void)layoutSubviews
//{
//    self.emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, 10);
//
//
//    [super layoutSubviews];
//}


// 动画效果
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    //通过关键帧动画实现缩放
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //设置动画路径
    animation.keyPath = @"transform.scale";
    
    if (selected)
    {
        //从没有点击到点击状态，会有爆炸的动画效果
        animation.values = @[@1.5,@2.0,@0.8,@1.0];
        animation.duration = 0.5;
        //计算关键帧方式
        animation.calculationMode = kCAAnimationCubic;
        //为图层添加动画
        [self.layer addAnimation:animation forKey:nil];
        //让放大动画先执行完毕再执行爆炸动画
        [self performSelector:@selector(startCell) withObject:nil afterDelay:0.25];
        
        self.backgroundColor = UIColor.redColor;
    }
    else
    {
        [self endCell];
        self.backgroundColor = UIColor.greenColor;
    }
}

// 开始粒子动画
- (void)startCell
{
    // 用kvc设置粒子数
//    [self.emitterLayer setValue:@1000 forKey:@"emitterCells.explosionCell.birthRate"];
    // 开始动画
    self.emitterLayer.beginTime = CACurrentMediaTime();
    // 延时关闭动画
//    [self performSelector:@selector(endCell) withObject:nil afterDelay:0.15];
}


// 结束粒子动画
- (void)endCell
{
    // 设定粒子数为0
//    [self.emitterLayer setValue:@0 forKey:@"emitterCells.explosionCell.birthRate"];
    // 关闭动画
    [self.emitterLayer removeAllAnimations];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
