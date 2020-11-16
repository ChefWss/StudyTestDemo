//
//  ViewController.m
//  Test_ViewAndLayer
//
//  Created by 王少帅 on 2020/11/16.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.lightGrayColor;
    
//    [self outScreenTese1];
//    [self outScreenTese2];
//    [self outScreenTese3];
    [self viewAndLayer];

}


- (void)viewAndLayer {
    
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
//    v0.layer.shadowColor = [UIColor blackColor].CGColor;
//    v0.layer.shadowOffset = CGSizeMake(4, 4);
//    v0.layer.shadowOpacity = 0.8;
//    v0.layer.shadowRadius = 10;
    
//    NSLog(@"%@ ==", v0.backgroundColor);
//    NSLog(@"%@ ==", v0.layer.backgroundColor);
//    v0.frame = CGRectMake(100 , 100, 200, 200);
//    NSLog(@"%f ==", v0.frame.origin.y );
//    NSLog(@"%f ==", v0.layer.frame.origin.y);
    
    

//    UIView *v00 = [[UIView alloc] initWithFrame:CGRectMake(90, 90, 20, 20)];
//    [v0 addSubview:v00];
//    v00.backgroundColor = UIColor.purpleColor;
//    v00.layer.cornerRadius = 8;
//    v00.clipsToBounds = YES;

//    v00.alpha = 0.01;
//    v00.layer.shadowColor = [UIColor blackColor].CGColor;
//    v00.layer.shadowOffset = CGSizeMake(4, 4);
//    v00.layer.shadowOpacity = 0.8;
//    v00.layer.shadowRadius = 10;
}


@end
