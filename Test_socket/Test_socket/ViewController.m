//
//  ViewController.m
//  Test_socket
//
//  Created by 王少帅 on 2020/11/23.
//

#import "ViewController.h"
#import "SdkViewController.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

// 本地启服务,命令行   nc -lk 9999

@interface ViewController ()

@property (nonatomic, assign) int clientId;
@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _count = 0;
}


/* 创建连接 */
- (IBAction)createClick:(id)sender
{
    in_addr_t ip = inet_addr("127.0.0.1");
    in_port_t port = htons(9999);
    
    /* 创建socket */
    _clientId = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);
    NSLog(@"_clinenId = %d", _clientId);
    
    if (_clientId == -1) {
        NSLog(@"创建失败"); return;
    }
    
    /* 创建socketAddr */
    struct in_addr socketIn_address;
    socketIn_address.s_addr = ip;
    
    struct sockaddr_in socketAddress;
    socketAddress.sin_family = AF_INET;
    socketAddress.sin_port = port;
    socketAddress.sin_addr = socketIn_address;
    
    /* 连接 */
    int result = connect(_clientId, (const struct sockaddr *)&socketAddress, sizeof(socketAddress));
    if (result != 0) {
        NSLog(@"连接socket 失败"); return;
    }
    NSLog(@"连接socket 成功");
    
    _count ++;
}


/* 发送消息 */
- (IBAction)sendClick:(id)sender
{
    _count ++;
    const char *msg = [NSString stringWithFormat:@"send message %ld", _count].UTF8String;
    ssize_t sendLen = send(_clientId, msg, strlen(msg), 0);
    NSLog(@"发送了消息 [%s], %ld字节", msg, sendLen);
}


/* 接收消息 */
- (IBAction)reciveClick:(id)sender
{
    _count ++;
    uint8_t buffer[1024];
    ssize_t recvLen = recv(_clientId, buffer, sizeof(buffer), 0);
    NSLog(@"接收了消息 [%s] - receive message %ld, %ld字节", buffer, _count, recvLen);
    
    if (recvLen == 0)
    {
        NSLog(@"此次接收长度为0 如果下次还为0 请检查连接");
    }
    else
    {
        // 接收的数据转换
        NSData *data = [NSData dataWithBytes:buffer length:recvLen];
        NSString *recvString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"接收到的string: %@", recvString);
    }
}


/* 使用sdk的界面 */
- (IBAction)pushClick:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    SdkViewController *vc = [[SdkViewController alloc] init];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
}


@end
