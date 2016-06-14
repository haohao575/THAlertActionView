//
//  THAlertActionView.h
//  tishikuang
//
//  Created by on 16/6/14.
//  Copyright © 2016年 童小浩. All rights reserved.
//

#import <UIKit/UIKit.h>
//AlertTypes样式的白色view的宽度
#define k_alerViewWitch self.frame.size.width - 60
//AlertTypes样式的白色view的高度
#define k_alerViewHeight 140
//ActionSheetType样式的每个button的高度
#define k_actionSheetButtonHeight 40
//AlertTypeNotButton样式的显示时间
#define k_AlertTypeNotButtonTime 1.8
typedef NS_ENUM(NSInteger,AlertViewType) {
    AlertTypes, //提示框带按钮
    ActionSheetType, //上拉框必带按钮
    AlertTypeNotButton //提示文字
};
@interface THAlertActionView : UIView
#pragma 样式需要设置
//AlertType,AlertTypeNotButton样式必须实现 ActionSheetType如果需要title,title需要优先设置
@property (nonatomic,strong)NSString *title;
//ActionSheetType,AlertTypeNotButton没有message
@property (nonatomic,strong)NSString *message;
/*
    建议AlertType的buttonTitleArray不要多余3个
    如果多于3个请使用带title的ActionSheetType样式
 */
//AlertType样式至少有一个buttonTitle, AlertTypeNotButton不用实现
- (void)setButtonTitleArray:(NSArray *)buttonTitleArray andBlock:(void (^)(NSInteger index))block;
//初始化设置样式
- (instancetype)initWithViewType:(AlertViewType)type;
//显示
- (void)show;

@end
