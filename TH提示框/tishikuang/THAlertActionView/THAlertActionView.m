//
//  THAlertActionView.m
//  tishikuang
//
//  Created by on 16/6/14.
//  Copyright © 2016年 童小浩. All rights reserved.
//
#import "THAlertActionView.h"
@interface THAlertActionView ()
@property (nonatomic,assign)AlertViewType type;
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,strong)UIView *rootAlertView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *messageLabel;
@property (nonatomic,strong)void (^buttonblock)(NSInteger index);
@property (nonatomic,strong)UIView *rootSheetView;
@end

@implementation THAlertActionView
- (instancetype)initWithViewType:(AlertViewType)type {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        self.rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.rootView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.rootView];
        switch (type) {
            case AlertTypes:{
                self.rootAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_alerViewWitch, k_alerViewHeight)];
                self.rootAlertView.backgroundColor = [UIColor whiteColor];
                self.rootAlertView.center = self.rootView.center;
                self.rootAlertView.layer.masksToBounds = YES;
                self.rootAlertView.layer.cornerRadius = 15.0;
            }
                break;
            case ActionSheetType:{
                self.rootSheetView = [[UIView alloc]initWithFrame:CGRectMake(0, self.rootView.frame.size.height, self.rootView.frame.size.width, 0)];
                self.rootAlertView.backgroundColor = [UIColor clearColor];
                [self addSubview:_rootSheetView];
            }
                break;
            case AlertTypeNotButton:{
                self.rootAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
                self.rootAlertView.backgroundColor = [UIColor whiteColor];
                self.rootAlertView.center = self.rootView.center;
                self.rootAlertView.layer.masksToBounds = YES;
                self.rootAlertView.layer.cornerRadius = 15.0;
            }
                break;
            default:
                break;
        }
        self.type = type;
    }
    return self;
}
#pragma mark - event
- (void)event {
    switch (_type) {
        case AlertTypes:{
            [self showAlertViewAnimationIncrease:self.rootAlertView];
        }
            break;
        case ActionSheetType:{
            [self showdidSheetViewAction:nil];
        }
            break;
        default:
            break;
    }
}
#pragma mark - show
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self setTypesss:_type];
    [window addSubview:self];
}
#pragma mark - setTypesss
- (void)setTypesss:(AlertViewType)type {
    switch (type) {
        case AlertTypes:{
            [self showAlertViewAnimationReduce:self.rootAlertView];
            [self addSubview:self.rootAlertView];
        }
            break;
        case ActionSheetType:{
            [self showSheetViewAction:nil];
        }
            break;
        case AlertTypeNotButton:{
            [self showAlertViewAnimationReduce:self.rootAlertView];
            [self addSubview:self.rootAlertView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_AlertTypeNotButtonTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showAlertViewAnimationIncrease:self.rootAlertView];
            });
        }
            break;
        default:
            break;
    }
}
#pragma mark - setTitle
- (void)setTitle:(NSString *)title {
    _title = title;
    switch (_type) {
        case AlertTypes:{
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, self.rootAlertView.frame.size.width - 10, self.rootAlertView.frame.size.height / 5.0 * 1)];
            _titleLabel.text = title;
            _titleLabel.font = [UIFont systemFontOfSize:17];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.numberOfLines = NO;
            [self.rootAlertView addSubview:_titleLabel];
        }
            break;
        case ActionSheetType:{
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.rootSheetView.frame.size.width - 20, k_actionSheetButtonHeight)];
            _titleLabel.text = title;
            CGFloat red = 100.0 / 255.0;
            _titleLabel.textColor = [UIColor colorWithRed:red green:red blue:red alpha:1];
            _titleLabel.font = [UIFont systemFontOfSize:13];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case AlertTypeNotButton:{
            CGRect rect = [title boundingRectWithSize:CGSizeMake(5000.0f, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName] context:nil];
            CGFloat width = 100;
            if (rect.size.width + 30 >= 100) {
                width = rect.size.width + 30;
            }
            _rootAlertView.frame = CGRectMake(0, 0, width, 60);
            _rootAlertView.center = _rootView.center;
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.rootAlertView.frame.size.width - 10, 60)];
            _titleLabel.text = title;
            _titleLabel.font = [UIFont systemFontOfSize:17];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.rootAlertView addSubview:_titleLabel];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - TitleArray
- (void)setButtonTitleArray:(NSArray *)buttonTitleArray andBlock:(void (^)(NSInteger))block {
    _buttonblock = block;
    switch (_type) {
        case AlertTypes:{
            if (buttonTitleArray.count == 1) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _rootAlertView.frame.size.height / 5 * 3.4, _rootAlertView.frame.size.width, 1)];
                view.backgroundColor = [UIColor blackColor];
                view.alpha = 0.2;
                view.tag = 1230;
                [_rootAlertView addSubview:view];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                button.frame = CGRectMake(0, _rootAlertView.frame.size.height / 5 * 3.4 + 1, _rootAlertView.frame.size.width, _rootAlertView.frame.size.height / 5 * 1.6 - 1);
                button.tag = 1203;
                [button addTarget:self action:@selector(buttonActionAction:) forControlEvents:UIControlEventTouchDown];
                [button setTitle:buttonTitleArray.firstObject forState:UIControlStateNormal];
                [_rootAlertView addSubview:button];
                if (_messageLabel == nil) {
                    _rootAlertView.frame = CGRectMake(0, 0, _rootAlertView.frame.size.width, _rootAlertView.frame.size.height - k_alerViewHeight / 5.0 * 1.8);
                    _rootAlertView.center = _rootView.center;
                    UIView *v = [_rootAlertView viewWithTag:1230];
                    v.frame = CGRectMake(v.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 9, v.frame.size.width, v.frame.size.height);
                    UIButton *button = [_rootAlertView viewWithTag:1203];
                    button.frame = CGRectMake(0,_titleLabel.frame.origin.y + _titleLabel.frame.size.height + 11, button.frame.size.width, _rootAlertView.frame.size.height / 5 * 2);
                }
            }
            if (buttonTitleArray.count == 2) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _rootAlertView.frame.size.height / 5 * 3.4, _rootAlertView.frame.size.width, 1)];
                view.backgroundColor = [UIColor blackColor];
                view.alpha = 0.2;
                view.tag = 1230;
                [_rootAlertView addSubview:view];
                UIView *views = [[UIView alloc]initWithFrame:CGRectMake(_rootAlertView.frame.size.width / 2.0 - 0.5, _rootAlertView.frame.size.height / 5 * 3.4 + 1, 1, _rootAlertView.frame.size.height / 5 * 1.6 - 1)];
                views.backgroundColor = [UIColor blackColor];
                views.alpha = 0.2;
                views.tag = 1231;
                [_rootAlertView addSubview:views];
                for (int i = 0; i < 2; i++) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                    button.frame = CGRectMake(i * (_rootAlertView.frame.size.width / 2.0 + 1), _rootAlertView.frame.size.height / 5 * 3.4 + 1, _rootAlertView.frame.size.width / 2.0 - 0.5, _rootAlertView.frame.size.height / 5 * 1.6 - 1);
                    button.tag = 1203 + i;
                    [button addTarget:self action:@selector(buttonActionAction:) forControlEvents:UIControlEventTouchDown];
                    [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
                    if ([buttonTitleArray[i] isEqualToString:@"取消"]) {
                        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    }
                    [_rootAlertView addSubview:button];
                }
                if (_messageLabel == nil) {
                    _rootAlertView.frame = CGRectMake(0, 0, _rootAlertView.frame.size.width, _rootAlertView.frame.size.height - k_alerViewHeight / 5.0 * 1.8);
                    _rootAlertView.center = _rootView.center;
                    UIView *v = [_rootAlertView viewWithTag:1230];
                    UIView *w = [_rootAlertView viewWithTag:1231];
                    v.frame = CGRectMake(v.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 9, v.frame.size.width, v.frame.size.height);
                    w.frame = CGRectMake(w.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10, w.frame.size.width, w.frame.size.height);
                    for (int i = 0; i < buttonTitleArray.count; i++) {
                        UIButton *button = [_rootAlertView viewWithTag:1203 + i];
                        button.frame = CGRectMake(i * (_rootAlertView.frame.size.width / 2.0 + 1),_titleLabel.frame.origin.y + _titleLabel.frame.size.height + 11, _rootAlertView.frame.size.width / 2.0 - 0.5, _rootAlertView.frame.size.height / 5 * 2);
                    }
                }
            }
            if (buttonTitleArray.count > 2) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _rootAlertView.frame.size.height / 5 * 3.4, _rootAlertView.frame.size.width, 1)];
                view.tag = 1230;
                view.backgroundColor = [UIColor blackColor];
                view.alpha = 0.2;
                [_rootAlertView addSubview:view];
                for (int i = 0; i < buttonTitleArray.count; i++) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                    button.frame = CGRectMake(0, (_rootAlertView.frame.size.height / 5 * 3.4 + 1) + (_rootAlertView.frame.size.height / 5 * 1.6 + 2) * i, _rootAlertView.frame.size.width, _rootAlertView.frame.size.height / 5 * 1.6 - 1);
                    button.tag = 1203 + i;
                    [button addTarget:self action:@selector(buttonActionAction:) forControlEvents:UIControlEventTouchDown];
                    [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
                    [_rootAlertView addSubview:button];
                    if (i < buttonTitleArray.count - 1) {
                        UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, button.frame.origin.y + button.frame.size.height, _rootAlertView.frame.size.width, 1)];
                        views.backgroundColor = [UIColor blackColor];
                        views.alpha = 0.2;
                        views.tag = 1204 + i;
                        [_rootAlertView addSubview:views];
                    }
                }
                _rootAlertView.frame = CGRectMake(0, 0, _rootAlertView.frame.size.width, _rootAlertView.frame.size.height + (buttonTitleArray.count - 1) * _rootAlertView.frame.size.height / 5 * 1.6);
                _rootAlertView.center = _rootView.center;
                if (_messageLabel != nil) {
                    _messageLabel.frame = CGRectMake(_messageLabel.frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, _messageLabel.frame.size.width, _messageLabel.frame.size.height);
                }else {
                    _rootAlertView.frame = CGRectMake(0, 0, _rootAlertView.frame.size.width, _rootAlertView.frame.size.height - k_alerViewHeight / 5.0 * 1.8);
                    _rootAlertView.center = _rootView.center;
                    UIView * w = [_rootAlertView viewWithTag:1230];
                    w.frame = CGRectMake(0, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 9, w.frame.size.width, 1);
                    for (int i = 0; i < buttonTitleArray.count; i++) {
                        UIButton *button = [_rootAlertView viewWithTag:1203 + i];
                        button.frame = CGRectMake(0,(_titleLabel.frame.origin.y + _titleLabel.frame.size.height + 10)+ (button.frame.size.height) * i, button.frame.size.width, button.frame.size.height);
                        if (i < buttonTitleArray.count - 1) {
                            UIView *v = [_rootAlertView viewWithTag:1204 + i];
                            [v removeFromSuperview];
                        }
                        if (i < buttonTitleArray.count - 1) {
                            UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, button.frame.origin.y + button.frame.size.height, _rootAlertView.frame.size.width, 1)];
                            views.backgroundColor = [UIColor blackColor];
                            views.alpha = 0.2;
                            [_rootAlertView addSubview:views];
                        }
                    }
                }
            }
        }
            break;
        case ActionSheetType:{
            self.rootSheetView.frame = CGRectMake(0, _rootSheetView.frame.origin.y, _rootSheetView.frame.size.width, (buttonTitleArray.count + 1) * (k_actionSheetButtonHeight + 1) + 20);
            UIView *seView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, _rootSheetView.frame.size.width - 20, (buttonTitleArray.count) *(k_actionSheetButtonHeight + 1))];
            seView.backgroundColor = [UIColor whiteColor];
            seView.alpha = 0.98;
            seView.layer.masksToBounds = YES;
            seView.layer.cornerRadius = 5.0;
            [self.rootSheetView addSubview:seView];
            if (_titleLabel != nil) {
                [seView addSubview:_titleLabel];
            }
            UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, k_actionSheetButtonHeight, seView.frame.size.width, 1)];
            view1.backgroundColor = [UIColor blackColor];
            view1.alpha = 0.2;
            [seView addSubview:view1];
            if (buttonTitleArray.count == 1) {
                if (_titleLabel == nil) {
                    seView.alpha = 0;
                }
            }else {
                if (_titleLabel == nil) {
                    seView.frame = CGRectMake(10, k_actionSheetButtonHeight + 1, seView.frame.size.width, (buttonTitleArray.count - 1) *(k_actionSheetButtonHeight + 1));
                    [view1 removeFromSuperview];
                }
            }
            UIView *seViews = [[UIView alloc]initWithFrame:CGRectMake(10,seView.frame.origin.y + seView.frame.size.height + 10, _rootSheetView.frame.size.width - 20, k_actionSheetButtonHeight)];
            seViews.backgroundColor = [UIColor whiteColor];
            seViews.alpha = 0.98;
            seViews.layer.masksToBounds = YES;
            seViews.layer.cornerRadius = 5.0;
            [self.rootSheetView addSubview:seViews];
            for (int i = 0; i < buttonTitleArray.count; i++) {
                if (i == buttonTitleArray.count - 1) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                    button.frame = CGRectMake(0, 0, seViews.frame.size.width, seViews.frame.size.height);
                    button.tag = 1203 + i;
                    [button addTarget:self action:@selector(buttonActionAction:) forControlEvents:UIControlEventTouchDown];
                    [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    [seViews addSubview:button];
                }else {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                    if (buttonTitleArray.count == 1) {
                    }else {
                        if (_titleLabel == nil) {
                            button.frame = CGRectMake(0, (0) + i * (k_actionSheetButtonHeight + 1), seViews.frame.size.width, seViews.frame.size.height);
                            button.tag = 1203 + i;
                            [button addTarget:self action:@selector(buttonActionAction:) forControlEvents:UIControlEventTouchDown];
                            [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
                            [seView addSubview:button];
                            if ((buttonTitleArray.count - 2) != i) {
                                UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, button.frame.origin.y + button.frame.size.height, seView.frame.size.width, 1)];
                                view1.backgroundColor = [UIColor blackColor];
                                view1.alpha = 0.2;
                                [seView addSubview:view1];
                            }
                        }else {
                            button.frame = CGRectMake(0, (k_actionSheetButtonHeight + 1) + i * (k_actionSheetButtonHeight + 1), seViews.frame.size.width, seViews.frame.size.height);
                            button.tag = 1203 + i;
                            [button addTarget:self action:@selector(buttonActionAction:) forControlEvents:UIControlEventTouchDown];
                            [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
                            [seView addSubview:button];
                            if ((buttonTitleArray.count - 2) != i) {
                                UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, button.frame.origin.y + button.frame.size.height, seView.frame.size.width, 1)];
                                view1.backgroundColor = [UIColor blackColor];
                                view1.alpha = 0.2;
                                [seView addSubview:view1];
                            }
                        }
                    }
                }
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark - buttonActionAction
- (void)buttonActionAction:(UIButton *)button {
    [self event];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.buttonblock) {
            self.buttonblock(button.tag - 1203);
        }
    });
}
#pragma mark - setMessage
- (void)setMessage:(NSString *)message {
    _message = message;
    switch (_type) {
        case AlertTypes:{
            _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.rootAlertView.frame.size.width - 10, self.rootAlertView.frame.size.height / 5.0 * 1.8)];
            _messageLabel.center = CGPointMake(self.rootAlertView.frame.size.width / 2.0, self.rootAlertView.frame.size.height / 2.0 - 5);
            _messageLabel.text = message;
            _messageLabel.font = [UIFont systemFontOfSize:13.5];
            _messageLabel.textAlignment = NSTextAlignmentCenter;
            CGFloat red = 100.0 / 255.0;
            _messageLabel.textColor = [UIColor colorWithRed:red green:red blue:red alpha:1];
            _messageLabel.numberOfLines = NO;
            [self.rootAlertView addSubview:_messageLabel];
        }
            break;
        case ActionSheetType:{
            
        }
            break;
        default:
            break;
    }
}
#pragma mark -动画
- (void)showAlertViewAnimationReduce:(UIView *)mainView{
    self.rootView.alpha = 0;
    mainView.alpha = 0;
    mainView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [UIView animateWithDuration:.4 animations:^{
        self.rootView.alpha = 0.4;
        mainView.alpha = 0.98;
        mainView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}
- (void)showAlertViewAnimationIncrease:(UIView *)mainView{
    self.rootView.alpha = 0.4;
    mainView.alpha = 0.98;
    mainView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:.3 animations:^{
        self.rootView.alpha = 0;
        mainView.alpha = 0;
        mainView.transform = CGAffineTransformMakeScale(.8, .8);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showSheetViewAction:(UIView *)view {
    self.rootView.alpha = 0.4;
    [UIView animateWithDuration:0.4 animations:^{
        self.rootView.alpha = 0.4;
        self.rootSheetView.frame = CGRectMake(0, _rootView.frame.size.height - (_rootSheetView.frame.size.height), _rootSheetView.frame.size.width, _rootSheetView.frame.size.height);
    }];
}
- (void)showdidSheetViewAction:(UIView *)view {
    self.rootView.alpha = 0.4;
    [UIView animateWithDuration:0.4 animations:^{
        self.rootView.alpha = 0;
        self.rootSheetView.frame = CGRectMake(0, _rootView.frame.size.height, _rootSheetView.frame.size.width, _rootSheetView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
