//
//  AuthTypeView.h
//  GoodSweetBeauty
//
//  Created by Eason on 17/5/14.
//  Copyright © 2017年 YLL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AuthTypeBlcok) (NSString *text);
@interface AuthTypeView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,copy)AuthTypeBlcok AuthTypeblcok;

+(instancetype)alertViewWithblock:(AuthTypeBlcok )typeblock;
-(void)show;


-(void)dismiss;
@end
