//
//  ViewController.m
//  Test_ViewAndLayer
//
//  Created by 王少帅 on 2020/11/16.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()

@property (nonatomic, strong) TestView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
//    [self outScreenTese1];
//    [self outScreenTese2];
//    [self outScreenTese3];
    
//    [self viewAndLayer];
//    [self layerImage];
    
    [self createBezir];

}


- (void)createBezir {
    self.testView = [[TestView alloc] initWithFrame:CGRectMake(20, 100, 350, 350)];
    [self.view addSubview:self.testView];
}


- (void)layerImage {
    
    
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = UIColor.greenColor.CGColor;
    layer.frame = CGRectMake(100, 100, 300, 100);
    UIImage *img = [UIImage imageNamed:@"my_bg"];
//    layer.contents = (id)img.CGImage;
    [self.view.layer addSublayer:layer];
    layer.backgroundColor = UIColor.redColor.CGColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:2];
        
        
        CATransition *transition = [CATransition animation];
            transition.type = @"moveIn";
            transition.subtype = @"fromRight";
        layer.actions = @{@"backgroundColor":transition};
        layer.backgroundColor = UIColor.blueColor.CGColor;
        [CATransaction commit];
        
    });
    
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = UIColor.redColor;
    v.frame = CGRectMake(100, 200, 300, 100);
    [self.view addSubview:v];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        v.backgroundColor = UIColor.blueColor;
    });

    
//    UIImageView *iamgeV = [[UIImageView alloc] initWithImage:img];
//    iamgeV.frame = CGRectMake(100, 200, 100, 100);
//    [self.view addSubview:iamgeV];
//
//    NSLog(@"%@ + %@", NSStringFromCGPoint(iamgeV.center), NSStringFromCGPoint(iamgeV.layer.anchorPoint));
//
//
//    [UIView animateWithDuration:3 animations:^{
//        NSLog(@"%@ - %@", NSStringFromCGRect(iamgeV.frame), NSStringFromCGRect(iamgeV.layer.frame));
//        iamgeV.frame = CGRectMake(200, 300, 100, 100);
//        NSLog(@"%@ = %@", NSStringFromCGRect(iamgeV.frame), NSStringFromCGRect(iamgeV.layer.frame));
//    }];
//
//
//
//    NSLog(@"%@ + %@", NSStringFromCGPoint(iamgeV.center), NSStringFromCGPoint(iamgeV.layer.anchorPoint));

    
}



- (void)viewAndLayer {
    
    self.testView = [[TestView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.testView.frame = CGRectMake(0, 0, 100, 100);
//    [self.view addSubview:self.testView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.backgroundColor = UIColor.orangeColor;
    });
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)buttonPressed
{
    self.view.backgroundColor = [UIColor purpleColor];
}




- (void)outScreenTese1 {
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 200, 200)];
    [self.view addSubview:imgV];
    imgV.image = [UIImage imageNamed:@"my_bg"];
    imgV.layer.cornerRadius = 80;
    imgV.clipsToBounds = YES;
    imgV.backgroundColor = UIColor.redColor;
//    imgV.layer.allowsGroupOpacity = YES;
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 200, 200)];
    [self.view addSubview:button];
    [button setBackgroundImage:[UIImage imageNamed:@"my_bg"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 80;
    button.clipsToBounds = YES;
//    button.backgroundColor = UIColor.greenColor;

}


- (void)outScreenTese2 {
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 200, 200)];
    [self.view addSubview:v1];
//    v1.layer.cornerRadius = 80;
    v1.clipsToBounds = YES;
//    v1.backgroundColor = UIColor.redColor;
//    v1.layer.allowsGroupOpacity = YES;
    
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [v1 addSubview:v2];
//    v2.alpha = 0.5;
    v2.layer.cornerRadius = 50;
    v2.clipsToBounds = YES;
    v2.backgroundColor = UIColor.greenColor;
}


- (void)outScreenTese3 {
    UIView *v0 = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 200, 200)];
    [self.view addSubview:v0];
    v0.backgroundColor = UIColor.redColor;
    v0.clipsToBounds = YES;
    v0.layer.cornerRadius = 80;
    
//    v0.alpha = 0.5;
//    v0.opaque = NO;
    v0.layer.shadowColor = [UIColor blueColor].CGColor;
    v0.layer.shadowOffset = CGSizeMake(14, 14);
    v0.layer.shadowOpacity = 0.99;
    v0.layer.shadowRadius = 10;
    
//    NSLog(@"%@ ==", v0.backgroundColor);
//    NSLog(@"%@ ==", v0.layer.backgroundColor);
//    v0.frame = CGRectMake(100 , 100, 200, 200);
//    NSLog(@"%f ==", v0.frame.origin.y );
//    NSLog(@"%f ==", v0.layer.frame.origin.y);
    
    

    UIView *v00 = [[UIView alloc] initWithFrame:CGRectMake(90, 90, 20, 290)];
    [v0 addSubview:v00];
    v00.backgroundColor = UIColor.purpleColor;
    v00.layer.cornerRadius = 8;
    v00.clipsToBounds = YES;

//    v00.alpha = 0.01;
//    v00.layer.shadowColor = [UIColor blackColor].CGColor;
//    v00.layer.shadowOffset = CGSizeMake(4, 4);
//    v00.layer.shadowOpacity = 0.8;
//    v00.layer.shadowRadius = 10;
}


@end
