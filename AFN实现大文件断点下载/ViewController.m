//
//  ViewController.m
//  AFN实现大文件断点下载
//
//  Created by 李洞洞 on 2/9/16.
//  Copyright © 2016年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

{//下载管理句柄 由其负责所有的网络操作请求
    NSURLSessionDownloadTask * _downLoadTask;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *label;
//@property(nonatomic,strong)AFURLSessionManager * manager;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

 #pragma mark --- NSURLSessionTask的三种任务类型
 /*
 1.NSURLSessionDataTask : 普通的GET\POST请求
 2.NSURLSessionDownloadTask : 文件下载
 3.NSURLSessionUploadTask : 文件上传（很少用，一般服务器不支持）
 */

@implementation ViewController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        //// manager 不能释放
        // _downloadManager = manager;
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.requestSerializer.timeoutInterval = 60.0;
        _manager = manager;
        

    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
   
}

#pragma mark---利用AFN实现文件下载操作细节　

- (void)downFileFromServer{
    __block int y = 0;
    for (int i = 0; i < 100; i++) {
    
        NSURL *URL2 = [NSURL URLWithString:@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg"];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL2];
        //下载Task操作
#if 1
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        //// manager 不能释放
        // _downloadManager = manager;
        
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.requestSerializer.timeoutInterval = 60.0;

        
#endif
#warning 82行用self.manager 67行改为 if 0 可以解决debug区的牛逼打印
        _downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString * str = [NSString stringWithFormat:@"%d",i];
            NSString * path = [cachesPath stringByAppendingPathComponent:str];
            NSString *path1 = [path stringByAppendingPathComponent:@"index.jpg"];
            NSFileManager * fileManager = [NSFileManager defaultManager];
            
            if (![fileManager fileExistsAtPath:path]) {
                [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            }
            NSLog(@"%@",path);
            return [NSURL fileURLWithPath:path1];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            NSString *imgFilePath = [filePath path];// 将NSURL转成NSString
            UIImage *img = [UIImage imageWithContentsOfFile:imgFilePath];
            self.imageView.image = img;
            
            y++;
            if (error) {
                NSLog(@"%@",error);
            }
            NSLog(@"第%d个文件下载完成",y);
            
        }];
        
       
        
        [_downLoadTask resume];

    }
}
- (IBAction)start:(UIButton *)sender {
    [self downFileFromServer];

    }

- (IBAction)stop:(UIButton *)sender {
       [_downLoadTask suspend];
    
}


@end
