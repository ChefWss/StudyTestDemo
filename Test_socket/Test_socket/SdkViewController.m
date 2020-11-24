//
//  SdkViewController.m
//  Test_socket
//
//  Created by 王少帅 on 2020/11/23.
//

#import "SdkViewController.h"
#import "GCDAsyncSocket.h" // for TCP

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
    NSString *host = @"127.0.0.1";
    int port = 9997;
    
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError *err = nil;
    [self.clientSocket connectToHost:host onPort:port error:&err];
    if (err) {
        NSLog(@"sdk连接失败: %@", err);
    }
}


/* 发送消息 */
- (IBAction)sdkSendClick:(id)sender
{
    [self.clientSocket writeData:[@"youareSB\n" dataUsingEncoding:NSUTF8StringEncoding] withTimeout:30 tag:0];
}


#pragma mark - delegate
/* 连接成功 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"delegate sdk连接成功 %@ : %d", host, port);
    [sock readDataWithTimeout:-1 tag:0];
}

/* 接受消息 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *recvString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"delegate 服务器包返回了-回包内容: %@ -长度%ld", recvString, data.length);
    [sock readDataWithTimeout:-1 tag:0];
}

/* 已经断开连接 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"delegate socket 断开连接");
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
