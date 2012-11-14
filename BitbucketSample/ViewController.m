//
//  ViewController.m
//  BitbucketSample
//
//  Created by abe on 2012/11/14.
//  Copyright (c) 2012年 abe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIDatePicker *dp;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"わたしだ！");
    NSLog(@"ブラブラ");
    
    dp = [[[UIDatePicker alloc] init] autorelease];
    dp.center = self.view.center;
//    dp.minuteInterval = 30;
    dp.datePickerMode = UIDatePickerModeDateAndTime;
    
    // 値が変更された時にhogeメソッドを呼び出す
//    [dp addTarget:self action:@selector(hoge:)
// forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:dp];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = CGPointMake( 160, 100 );
    [btn addTarget:self action:@selector(setNotifi:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)setNotifi:(UIButton*)sender
{
    NSLog(@"%@", [[dp date] description]);
    
    // 時刻を00秒に設定
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *pickerStr = [fmt stringFromDate:[dp date]];
    NSString *str = [pickerStr substringToIndex:17];
    str = [str stringByAppendingString:@"00"];
    NSDate *pickerDate = [fmt dateFromString:str];
    NSLog(@"%@", pickerDate);
    
    // 3個登録
    for ( int i=0; i<3; i++ ) {
        // 5秒間隔
        NSDate *setDate = [NSDate dateWithTimeInterval:i * 5
                                             sinceDate:pickerDate];
        // 1日間隔
//        NSDate *setDate = [NSDate dateWithTimeInterval:i * 60 * 60 * 24
//                                             sinceDate:pickerDate];
        
        UILocalNotification *no = [[[UILocalNotification alloc] init] autorelease];
        no.fireDate = setDate;//[dp date];
        no.alertBody = [NSString stringWithFormat:@"BODY %d", i];
        no.alertAction = @"ACTION";
        [[UIApplication sharedApplication] scheduleLocalNotification:no];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
