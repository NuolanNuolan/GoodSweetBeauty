//
//  MyAuthTableViewCell.m
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//



#import "MyAuthTableViewCell.h"
#import "AuthTypeView.h"

@interface MyAuthTableViewCell()<UITextFieldDelegate>{

    //title
    UILabel *lab_title;
    //text
    UITextField *text_input;
    //认证类型lab
    UILabel *lab_type;
    

    
    
}
//三个text
@property(nonatomic,strong)UITextField *text_name;
@property(nonatomic,strong)UITextField *text_phone;
@property(nonatomic,strong)UITextField *text_email;
@end


@implementation MyAuthTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        lab_title = [UILabel new];
        [lab_title setTextColor:RGB(51, 51, 51)];
        [lab_title setFont:[UIFont systemFontOfSize:16]];
        [lab_title sizeToFit];
        
        if ([reuseIdentifier isEqualToString:@"0"]) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            lab_type = [UILabel new];
            [lab_type setTextColor:RGB(51, 51, 51)];
            [lab_type setFont:[UIFont systemFontOfSize:16]];
            lab_type.userInteractionEnabled =YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choose_type)];
            [lab_type addGestureRecognizer:tap];
            
            [self.contentView addSubview:lab_type];
            lab_type.whc_LeftSpace(100).whc_TopSpace(0).whc_BottomSpace(0).whc_RightSpace(0);
        }else{
        
            self.accessoryType = UITableViewCellAccessoryNone;
            text_input = [UITextField new];
            text_input.delegate = self;
            [text_input setTintColor:GETMAINCOLOR];
            [text_input setFont:[UIFont systemFontOfSize:16]];
            [text_input setTextColor:RGB(51, 51, 51)];
            [self.contentView addSubview:text_input];
            
            text_input.whc_LeftSpace(100).whc_Height(50).whc_TopSpace(0).whc_RightSpace(20);
            
        }
        [self.contentView addSubview:lab_title];
        lab_title.whc_LeftSpace(15).whc_CenterY(0);
        
    }
    return self;
}
-(void)SetSection:(NSInteger )section{

    switch (section) {
        case 0:
            lab_title.text = @"认证类型";
            break;
        case 1:
            lab_title.text = @"姓名";
            text_input.tag= 100;
            [text_input setReturnKeyType:UIReturnKeyNext];
            break;
        case 2:
            lab_title.text = @"联系方式";
            [text_input setReturnKeyType:UIReturnKeyNext];
            text_input.tag= 101;
            break;
        case 3:
            lab_title.text = @"邮箱";
            text_input.tag= 102;
            [text_input setReturnKeyType:UIReturnKeyGo];
            
            break;
    }
}

//选择
-(void)choose_type{

    UIViewController * viewclass;
    viewclass =[BWCommon Superview:self];
    for (int i=100; i<=102; i++) {
        
        if ([[viewclass.view viewWithTag:i] isKindOfClass:[UITextField class]]) {
            
            [[viewclass.view viewWithTag:i] resignFirstResponder];
        }
    }
    AuthTypeView *view = [AuthTypeView alertViewWithblock:^(NSString *text) {
        
        MYLOG(@"%@",text);
        lab_type.text = text;
        if (self.delegateSignal) [self.delegateSignal sendNext:text];
    }];
    [view show];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    UIViewController * viewclass;
    viewclass =[BWCommon Superview:self];
    switch (textField.tag) {
        case 100:{
            
            UITextField *text = [viewclass.view viewWithTag:101];
            [text becomeFirstResponder];
        }
            return NO;
            break;
        case 101:{
            
            UITextField *text = [viewclass.view viewWithTag:102];
            [text becomeFirstResponder];
        }
            return NO;
            break;
        case 102:{
            
            
        }
            return NO;
            break;
    }
    return YES;
}
//设置密码的
-(void)SetPwd:(NSInteger )section{

    switch (section) {
        case 0:
            lab_title.text = @"输入新密码";
            text_input.placeholder = @"请输入密码";
            text_input.tag= 101;
            text_input.secureTextEntry = YES;
            [text_input becomeFirstResponder];
            break;
    }
}
//修改密码的
-(void)ModifyPwd:(NSInteger )section{

    switch (section) {
        case 0:
            lab_title.text = @"旧密码";
            text_input.tag= 100;
            text_input.placeholder = @"输入旧密码";
            text_input.secureTextEntry = YES;
            [text_input becomeFirstResponder];
            break;
        case 1:
            lab_title.text = @"新密码";
            text_input.placeholder = @"输入新密码";
            text_input.tag= 101;
            text_input.secureTextEntry = YES;
            
            break;
        case 2:
            lab_title.text = @"确认密码";
            text_input.placeholder = @"再次输入新密码";
            text_input.tag= 102;
            text_input.secureTextEntry = YES;
            
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
