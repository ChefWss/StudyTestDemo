//
//  ViewController.m
//  Test_coreAnimation
//
//  Created by 王少帅 on 2020/12/13.
//

#import "ViewController.h"
#import "GoodButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.lightGrayColor;
    
//    [self rain];
    [self good];
}


#pragma mark - 红包雨---(粒子束)
- (void)rain
{
    // 配置粒子
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.contents = (id)[UIImage imageNamed:@"redBag"].CGImage;
    cell.birthRate = 1.0;
    cell.lifetime = 100.0;
    cell.speed = 3.0;
    cell.velocity = 90.0;
    cell.velocityRange = 90.0;
    cell.yAcceleration = 100;
    cell.xAcceleration = 0;
    cell.scale = 0.05;
    
    
    // 配置发射源
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    // 在背景图上添加粒子图层
    [self.view.layer addSublayer:emitterLayer];
    // 发射形状-线性
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    emitterLayer.emitterMode = kCAEmitterLayerSurface;
    emitterLayer.emitterSize = self.view.frame.size;
    emitterLayer.emitterPosition = CGPointMake(self.view.frame.size.width * 0.5, 10);
    
    
    // 粒子添加到发射源
    emitterLayer.emitterCells = @[cell];
}


#pragma mark - 点赞动效 (有问题!待解决)
// TODO: !
- (void)good
{
    GoodButton *button = [[GoodButton alloc] initWithFrame:CGRectMake(200, 200, 40, 40)];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)click:(GoodButton *)sender
{
    sender.selected = !sender.selected;
}

@end
