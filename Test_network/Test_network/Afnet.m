//
//  Afnet.m
//  Test_network
//
//  Created by 王少帅 on 2020/11/25.
//

#import "Afnet.h"
#import <AFNetworking/AFNetworking.h>

@implementation Afnet

- (void)afnetRequest
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager copy];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@""];
    
    NSString *urlGetString = @"https://www.fastmock.site/mock/c0c505701a38bfcf63cf122e94dbc1d4/shaoshuai/LBT/Up";
    NSString *urlPostString = @"https://www.fastmock.site/mock/c0c505701a38bfcf63cf122e94dbc1d4/shaoshuai/postTest";
    
    [manager GET:urlGetString parameters:nil headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"+++ %@",dict);
        NSLog(@"+++ %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"--- %@", error.localizedDescription);
        
    }];
    
    
    [manager POST:urlPostString parameters:@{} headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"$$$ %@",dict);
        NSLog(@"$$$ %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"### %@", error.localizedDescription);
        
    }];
}

@end
