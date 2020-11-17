//
//  TestView.m
//  Test_ViewAndLayer
//
//  Created by 王少帅 on 2020/11/16.
//

#import "TestView.h"

@interface TestView ()

@end

@implementation TestView

- (void)setNeedsLayout {
    [super setNeedsLayout];
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 两点连线
    [UIColor.blueColor set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 3;
    [path moveToPoint:CGPointMake(10, 10)]; // 设置起始点
    [path addLineToPoint:CGPointMake(50, 100)];
    [path addLineToPoint:CGPointMake(200, 200)];
    [path addLineToPoint:CGPointMake(100, 300)];
    [path closePath];//当构建子路径数>=2条时,可以调用`closePath`方法来闭合路径.
    [path stroke];// 根据坐标点连线
    
    
    // 矩形
    [UIColor.redColor set];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:CGRectMake(200, 200, 50, 50)];
//    [path2 fill];
    [path2 fillWithBlendMode:kCGBlendModeScreen alpha:0.5];
    [path2 stroke];
    
    
    // 圆形 椭圆
    [UIColor.greenColor set];
    UIBezierPath *path3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(300, 300, 40, 20)];
    [path3 stroke];
    
    
    // 圆弧
    [UIColor.purpleColor set];
    UIBezierPath *path4 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:100 startAngle:3.14*1.5 endAngle:3.14*3.4 clockwise:YES];
    [path4 stroke];
    
    
    // 虚线
    [UIColor.blackColor set];
    UIBezierPath *path5 = [UIBezierPath bezierPath];
    CGFloat dash[] = {4};
    path5.lineWidth = 3;
    [path5 setLineDash:dash count:1 phase:0];
    [path5 moveToPoint:CGPointMake(15, 110)]; // 设置起始点
    [path5 addLineToPoint:CGPointMake(200, 300)];
    [path5 stroke];
    [path5 fill];
    
    
    // 贝塞尔曲线
    [UIColor.systemPinkColor set];
    UIBezierPath *path6 = [UIBezierPath bezierPath];
    [path6 moveToPoint:CGPointMake(20, 20)];
    [path6 addCurveToPoint:CGPointMake(100, 100) controlPoint1:CGPointMake(100, 400) controlPoint2:CGPointMake(300, 200)];
    [path6 stroke];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.lightGrayColor;
    }
    return self;
}

@end
