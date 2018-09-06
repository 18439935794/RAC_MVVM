//
//  LoginView.m
//  RACDemo
//
//  Created by weifangzou on 2018/8/15.
//  Copyright © 2018年 Ttpai. All rights reserved.
//

#import "LoginView.h"
#import <Masonry.h>
@interface LoginView()
/** 用户img */
@property (nonatomic, strong) UIImageView *userIcon;
/** 密码img */
@property (nonatomic, strong) UIImageView *passwordIcon;


@end

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
        
    }
    return self;
}
- (void)initData {
    
    [self addSubview:self.userNameTextField];
    [self addSubview:self.weChatLab];
    [self addSubview:self.iconImg];
    [self addSubview:self.passwordTextField];
    [self addSubview:self.loginButton];

    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0);
//        make.right.equalTo(self.mas_right).offset(-10);
        make.width.height.equalTo(@(60));
    }];

    [_userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(13);
        make.top.equalTo(self.iconImg.mas_bottom).offset(30);
        make.right.equalTo(self.mas_right).offset(-13);
        make.height.equalTo(@(40));
    }];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameTextField);
        make.top.equalTo(self.userNameTextField.mas_bottom).offset(20);
        make.right.equalTo(self.userNameTextField);
        make.height.equalTo(self.userNameTextField);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_passwordTextField.mas_bottom).offset(20);
        make.height.equalTo(@(45));
        make.left.equalTo(@13);
        make.right.equalTo(self.mas_right).offset(-13);;
    }];
    [_weChatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_passwordTextField.mas_left).offset(0);
        make.top.equalTo(_loginButton.mas_bottom).offset(10);
        make.width.equalTo(self);
        make.height.equalTo(@(30));
        
    }];
    
}
- (UITextField *)userNameTextField {
    
    
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc]init];
        _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        _userNameTextField.placeholder = @"请输入用户名…";
        _userNameTextField.secureTextEntry =  YES;
        _userNameTextField.backgroundColor = [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1.00];
    }
    return _userNameTextField;
}

- (UITextField *)passwordTextField {
    
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc]init];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.placeholder = @"请输入密码…";
        _passwordTextField.secureTextEntry =  YES;
        _passwordTextField.backgroundColor = [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1.00];

        
        
    }
    return _passwordTextField;
}
- (UIButton *)loginButton {
    
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _loginButton.backgroundColor = [UIColor  orangeColor];
        _loginButton.titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _loginButton;
}

- (UILabel *)weChatLab {
    if (!_weChatLab ){
        _weChatLab = [[UILabel alloc]init];
        _weChatLab.text = @"微信登陆";
        _weChatLab.userInteractionEnabled = YES;
        _weChatLab.font = [UIFont systemFontOfSize:12];
        [_weChatLab setTextColor: [UIColor  blueColor]];
    }
    return _weChatLab;
}
- (UIImageView *)iconImg {
    
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.image = [UIImage imageNamed:@"1.png"];
        _iconImg.layer.cornerRadius = 30;
        _iconImg.clipsToBounds = YES;
    }
    return _iconImg;
}
- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc]init];
        _userIcon.image = [UIImage imageNamed:@"page02phone"];
    }
    
    return _userIcon;
}
- (UIImageView *)passwordIcon {
    
    if (!_passwordIcon) {
        _passwordIcon = [[UIImageView alloc]init];
        _passwordIcon.image = [UIImage imageNamed:@"page02password"];

    }
    return _passwordIcon;
}






@end
