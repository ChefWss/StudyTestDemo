//
//  ViewController.m
//  Test_CTMediator
//
//  Created by 王少帅 on 2020/11/19.
//

#import "ViewController.h"
#import "CTMediator+PushActions.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"首页";
    
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setBackgroundColor:UIColor.orangeColor];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn addTarget:self action:@selector(push2) forControlEvents:UIControlEventTouchUpInside];
}


- (void)push2 {
    NSDictionary *pa = @{@"name": @"wss", @"age": @2};
    UIViewController *pVc = [[CTMediator sharedInstance] dtp_mediator_ctmdiatorPushViewControllerWithParams:pa];
    [self.navigationController pushViewController:pVc animated:YES];
}


@end
