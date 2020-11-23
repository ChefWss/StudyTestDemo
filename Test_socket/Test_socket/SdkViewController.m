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

@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

@implementation SdkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)sdkCreateClick:(id)sender
{
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSString *host = @"127.0.0.1";
    uint16_t port = htons(9998);
    
    
    NSError *err = nil;
    if (![self.clientSocket connectToHost:host onPort:port error:&err])
    {
        //  如果有错误，很可能是"已经连接"或"没有委托集"
        NSLog(@"sdk连接错误: %@", err);
    }
    else
    {
        NSLog(@"sdk连接成功: %@", self.clientSocket);
    }
}



- (IBAction)sdkSendClick:(id)sender
{
    [self.clientSocket writeData:[@"i m sdk from" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
}


#pragma mark - delegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"delegate sdk连接成功");
    [sock readDataWithTimeout:-1 tag:0];
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *recvString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"delegate 服务器包返回了--回包内容: %@ ---长度%ld", recvString, data.length);
    [sock readDataWithTimeout:-1 tag:0];
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
