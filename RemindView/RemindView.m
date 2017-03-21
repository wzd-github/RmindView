//
//  TishiView.m
//  PromaptView
//
//  Created by JSHT on 17/3/13.
//  Copyright © 2017年 JSHT. All rights reserved.
//

#import "RemindView.h"
#define viewWidth 260
#define viewHeight 260*0.6
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface RemindView ()
@property(nonatomic,weak)UIView * theView;
@property(nonatomic,weak)UIButton * leftButton;
@property(nonatomic,weak)UIButton * rightButton;
@property(nonatomic,weak)UILabel * titleLabel;
@property(nonatomic,weak)UILabel * textLabel;
@end

@implementation RemindView

-(void)dealloc
{
    printf("dealloc--dealloc--dealloc--dealloc--dealloc--dealloc!!!!!!!!!!!!\n");
}

-(instancetype)initTitle:(NSString*)title andMessage:(NSString*)message
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self buildControl];
        [self buildPromptMessage:title andMessage:message];
    }
    return self;
}

-(void)buildControl
{
    UIView *promptView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width - viewWidth)/2.0, (self.frame.size.height - viewHeight)/2.0, viewWidth, viewHeight)];
    promptView.backgroundColor = [UIColor whiteColor];
    promptView.layer.cornerRadius = 5.0;
    promptView.center = self.center;
    [self addSubview:promptView];
    self.theView = promptView;
    
    UIBezierPath *verticalLine = [UIBezierPath bezierPath];
    [verticalLine moveToPoint:CGPointMake(0, viewHeight-41)];
    [verticalLine addLineToPoint:CGPointMake(viewWidth, viewHeight-40)];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor colorWithWhite:0.8 alpha:0.6].CGColor;
    shapeLayer.path = verticalLine.CGPath;
    shapeLayer.lineWidth = 1.0;
    [promptView.layer addSublayer:shapeLayer];
    
    UIBezierPath *horizontalLine = [UIBezierPath bezierPath];
    [horizontalLine moveToPoint:CGPointMake((viewWidth/2.0)-0.5, viewHeight-41)];
    [horizontalLine addLineToPoint:CGPointMake(viewWidth/2.0+0.5, viewHeight)];
    CAShapeLayer *horizontalLayer = [CAShapeLayer layer];
    horizontalLayer.strokeColor = [UIColor colorWithWhite:0.8 alpha:0.6].CGColor;
    horizontalLayer.path = horizontalLine.CGPath;
    horizontalLayer.lineWidth = 1.0;
    [promptView.layer addSublayer:horizontalLayer];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton = leftBtn;
    leftBtn.frame = CGRectMake(0, viewHeight-40, viewWidth/2.0-0.5, 40);
    [leftBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
    leftBtn.layer.cornerRadius = 5.0;
    leftBtn.imageView.layer.cornerRadius = 5.0;
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBezierPath *maskLeft = [UIBezierPath bezierPathWithRoundedRect:leftBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLeftLayer = [CAShapeLayer layer];
    maskLeftLayer.frame = leftBtn.bounds;
    maskLeftLayer.path = maskLeft.CGPath;
    leftBtn.layer.mask = maskLeftLayer;
    [promptView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton = rightBtn;
    rightBtn.frame = CGRectMake(viewWidth/2.0+0.5, viewHeight-40, viewWidth/2.0-0.5, 40);
    [rightBtn setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rightBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = rightBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    rightBtn.layer.mask = maskLayer;
    [promptView addSubview:rightBtn];
}

-(void)buildPromptMessage:(NSString*)title andMessage:(NSString*)message
{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, viewWidth-20, 40)];
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont boldSystemFontOfSize:16.0];
    titleLab.numberOfLines = 0;
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.theView addSubview:titleLab];
    self.titleLabel = titleLab;
    
    UILabel *textLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, viewWidth-20, viewHeight - 100)];
    textLab.backgroundColor = [UIColor clearColor];
    textLab.textColor = [UIColor blackColor];
    textLab.font = [UIFont systemFontOfSize:14.0];
    textLab.numberOfLines = 0;
    textLab.text = message;
    textLab.textAlignment = NSTextAlignmentCenter;
    [self.theView addSubview:textLab];
    self.textLabel = textLab;
}

-(void)leftClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didCancelWithView)]) {
        [self.delegate didCancelWithView];
    }
    [self viewDisshowAnimation];
}

-(void)rightClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didConfirmWithView)]) {
        [self.delegate didConfirmWithView];
    }
    [self viewDisshowAnimation];
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//动画消失效果
-(void)viewDisshowAnimation
{
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.theView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        self.theView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.theView removeFromSuperview];
        self.theView = nil;
        [self removeFromSuperview];
    }];
}

-(void)dismissRemindView
{
    [self viewDisshowAnimation];
}

//屏幕为横屏时的view调整
-(void)horizontalScreenAdjust
{
    CGRect rect = self.frame;
    rect.size.height = screenWidth;
    rect.size.width = screenHeight;
    self.frame = rect;
}

//屏幕为竖屏时的view调整
-(void)verticalScreenAdjust
{
    CGRect rect = self.frame;
    rect.size.height = screenWidth;
    rect.size.width = screenHeight;
    self.frame = rect;
}

-(void)layoutSubviews
{
    NSLog(@"layoutSubviews--layoutSubviews--layoutSubviews!!!!!!!!!\n");
    self.theView.center = self.center;
}

@end
