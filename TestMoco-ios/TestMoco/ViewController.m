//
//  ViewController.m
//  TestMoco
//
//  Created by JianF.Sun on 2017/12/5.
//  Copyright © 2017年 sjf. All rights reserved.
//

#import "ViewController.h"

NSString *const kBaseUrl = @"http://10.1.1.39:8080/";
NSString *const kLoginUrl = @"login";
#define CombineStr(str1,str2) [str1 stringByAppendingString:str2]
#define AppUrl(baseUrl,funcUrl) CombineStr(baseUrl,funcUrl)
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextView *dataTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    self.dataTextView.text = @"";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *urlStr = AppUrl(kBaseUrl, kLoginUrl);
    NSURL *url = [NSURL URLWithString:urlStr];
    //    2.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDictionary *param = @{@"name":self.usernameTextField.text,
                            @"password":self.pwdTextField.text,
                            };
    NSError *error;
    NSData *body = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:&error];
    request.HTTPBody =  body;
    NSURLRequest *req = [request copy];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"--block回调数据--length:%lu",(unsigned long)data.length);
        NSString *dataStr = @"";
        if (connectionError) {
            switch (connectionError.code) {
                case -1009:
                    dataStr = @"当前无网络连接";
                    break;
                case -1001:
                    dataStr = @"请求超时";
                    break;
                case -1004:
                    dataStr = @"无法连接服务器";
                    break;
                default:
                    break;
            }
        }else{
            if(data){
//                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//                NSLog(@"%@",dict);
                    dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataTextView.text = dataStr;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
