//
//  ViewController.m
//  Test_network
//
//  Created by 王少帅 on 2020/11/25.
//

#import "ViewController.h"
#import "Afnet.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/*
     1. 最原始的网络下载 -- NSData+NSURL方式
 */
- (IBAction)click1:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);
    
    // 子线程下载请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@"https://upload-images.jianshu.io/upload_images/1877784-b4777f945878a0b9.jpg"];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgV.image = [UIImage imageWithData:data];
        });
        
        
    });
}


/*
    2. 过气的苹果原生网络框架 -- NSURLConnection
 */
- (IBAction)click2:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);
    
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606285845326&di=375d36c91a13304e5569b3f37f017b80&imgtype=0&src=http%3A%2F%2Fpic5.997788.com%2Fpic_search%2F00%2F16%2F02%2F08%2Fse16020808.jpg"];
    
    // NSURLConnection 发送异步GET请求, 该方法iOS9后废除了, 推荐NSURLSession
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        self.imgV.image = [UIImage imageWithData:data];
        
    }];

}


/*
  3. 现在的苹果原生网络框架 -- NSURLSession GET
    # 在iOS9.0之后，以前使用的NSURLConnection过期，苹果推荐使用NSURLSession来替换NSURLConnection完成网路请求相关操作。
    # NSURLSession的使用非常简单，先根据会话对象创建一个请求Task，然后执行该Task即可。
 */
- (IBAction)click3:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);

    NSURL *url = [NSURL URLWithString:@"https://www.fastmock.site/mock/c0c505701a38bfcf63cf122e94dbc1d4/shaoshuai/LBT/Up"];
    
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 创建task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@",dict);
        }
        
    }];
    
    // 执行任务
    [dataTask resume];
}


/*
   4. 现在的苹果原生网络框架 -- NSURLSession POST
 */
- (IBAction)click4:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);

    // 创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:@"https://www.fastmock.site/mock/c0c505701a38bfcf63cf122e94dbc1d4/shaoshuai/postTest"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod = @"POST";
//    request.HTTPBody = [@"id=1000" dataUsingEncoding:NSUTF8StringEncoding];
    
    // 创建task
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            //6.解析服务器返回的数据
            //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@",dict);
        }
        
    }];
    
    // 执行任务
    [dataTask resume];
    
}


- (IBAction)click5:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);

    [[Afnet new] afnetRequest];
}


@end
