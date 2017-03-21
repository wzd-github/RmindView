//
//  TishiView.h
//  PromaptView
//
//  Created by JSHT on 17/3/13.
//  Copyright © 2017年 JSHT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol remindDelegate <NSObject>

-(void)didConfirmWithView;
-(void)didCancelWithView;

@end

@interface RemindView : UIView
@property(nonatomic,assign)id <remindDelegate> delegate;
-(void)horizontalScreenAdjust;
-(void)verticalScreenAdjust;
-(void)dismissRemindView;
-(instancetype)initTitle:(NSString*)title andMessage:(NSString*)message;
@end
