//
//  ViewController.m
//  tishikuang
//
//  Created by 童浩 on 16/6/14.
//  Copyright © 2016年 童小浩. All rights reserved.
//

#import "ViewController.h"
#import "THAlertActionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)buttonAction:(UIButton *)sender {
    THAlertActionView *aler = [[THAlertActionView alloc]initWithViewType:ActionSheetType];
    aler.title = @"选择照片";
    [aler setButtonTitleArray:@[@"选择",@"取消"] andBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    }];
    [aler show];
}
- (IBAction)xitongAction:(id)sender {
    THAlertActionView *aler = [[THAlertActionView alloc]initWithViewType:AlertTypes];
    aler.title = @"提示";
    aler.message = @"是否退出登陆";
    [aler setButtonTitleArray:@[@"确定",@"取消"] andBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    }];
    [aler show];
}
- (IBAction)buttonxitongAction:(id)sender {
    THAlertActionView *aler = [[THAlertActionView alloc]initWithViewType:AlertTypeNotButton];
    aler.title = @"错误！！";
    [aler show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
