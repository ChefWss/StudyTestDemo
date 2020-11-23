//
//  SdkViewController.m
//  Test_socket
//
//  Created by 王少帅 on 2020/11/23.
//

#import "SdkViewController.h"
#import "GCDAsyncSocket.h" // for TCP
#import "GCDAsyncUdpSocket.h" // for UDP

@interface SdkViewController ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *clentSocket;

@end

@implementation SdkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.clentSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSString *host = @"127.0.0.1";
    uint16_t port = htons(9999);
    
    
    NSError *err = nil;
    if (![self.clentSocket connectToHost:host onPort:port error:&err])
    {
        //  如果有错误，很可能是"已经连接"或"没有委托集"
        NSLog(@"连接错误: %@", err);
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
