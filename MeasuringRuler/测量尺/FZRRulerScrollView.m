//
//  FZRRulerScrollView.m
//  MeasuringRuler
//
//  Created by IOS-开发机 on 15/11/10.
//  Copyright © 2015年 IOS-开发机. All rights reserved.
//

#import "FZRRulerScrollView.h"
#define BTminus(maxNuber,mixNuber)  ABS((maxNuber-mixNuber))
#define FZRColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//每个刻度间距
static  CGFloat rulerScaleWidth ;

static const CGFloat rulerSizeHeightShort = 12;
static const CGFloat rulerSizeHeightIn = 16;
static const CGFloat rulerSizeHeightLong = 24;

static const CGFloat rulerSizeWidth  = 1;



//刻度距离文字的距离


//显示刻度的lable的字体大小
static const CGFloat rulerLableFont = 9;
static const CGFloat rulerLableWidth = 70;
static const CGFloat rulerLableHeigh = 20;




@interface FZRRulerScrollView ()

@property(nonatomic,strong)UIImage *rulerImage;

@property(nonatomic,assign)NSInteger mixNuber;
@property(nonatomic,assign)NSInteger maxNuber;
@property(nonatomic,assign)FZRRulerViewShowType showType;

@end

@implementation FZRRulerScrollView



-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(FZRRulerViewShowType)showType rulerMultiple:(CGFloat)rulerMultiple{
    
    self=[super init];
    if (self) {
        _mixNuber=mixNuber;
        _maxNuber=maxNuber;
        _showType=showType;
        rulerScaleWidth = rulerMultiple;
        
        [self setCanCancelContentTouches:NO];
        self.backgroundColor=[UIColor clearColor];
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator=NO;
        self.bounces=YES;
        self.scrollEnabled = YES;
        self.pagingEnabled = NO;
        self.decelerationRate = 0.7;
        self.clipsToBounds = NO;
        if (_showType==FZRRulerViewshowHorizontalType) {//如果水平放置
            
            self.contentSize=CGSizeMake(rulerScaleWidth * BTminus(_maxNuber, _mixNuber)+1.5+self.frame.size.width, self.frame.size.height);
        }else if (_showType==FZRRulerViewshowVerticalType) {
    
            self.contentSize=CGSizeMake(self.frame.size.width, self.frame.size.height+1.5+rulerScaleWidth*BTminus(_maxNuber, _mixNuber));
        }
        //添加显示刻度ImageView
        [self pictureRuler];
        
    }
    return self;
}



-(void)pictureRuler{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    [path moveToPoint:self.showType==FZRRulerViewshowHorizontalType?CGPointMake( self.frame.size.width/2 , 0.5):CGPointMake(0.5, self.frame.size.width/2)];
    
    CGPoint point = self.showType==FZRRulerViewshowHorizontalType?CGPointMake(self.frame.size.width/2 + BTminus(_maxNuber,_mixNuber)*rulerScaleWidth , 0.5):CGPointMake(0.5, self.frame.size.width/2 + BTminus(_maxNuber,_mixNuber)*rulerScaleWidth);
    [path addLineToPoint:point];


    
    for (NSInteger i=0; i<=BTminus(_maxNuber,_mixNuber); i++) {
        [path moveToPoint: self.showType==FZRRulerViewshowHorizontalType?CGPointMake(self.frame.size.width/2 + i*rulerScaleWidth , 0.5):CGPointMake(0.5, self.frame.size.width/2 + i*rulerScaleWidth)];
        
        int Remainder = (i+_mixNuber)%10;
        CGPoint point;
        if (Remainder==5||Remainder==0) {
            
            UILabel *rulerLable=[[UILabel alloc] init];
            rulerLable.textAlignment=NSTextAlignmentCenter;
            rulerLable.text=[NSString stringWithFormat:@"%zd",_mixNuber+i];
            rulerLable.textColor=FZRColor(100, 100, 100);
            rulerLable.font=[UIFont systemFontOfSize:rulerLableFont];
            rulerLable.frame = self.showType==FZRRulerViewshowHorizontalType?CGRectMake(self.frame.size.width/2 + i*rulerScaleWidth - rulerLableWidth/2, rulerSizeHeightLong+6, rulerLableWidth, rulerLableHeigh):CGRectMake(rulerSizeHeightLong+4, self.frame.size.height/2 + i*rulerScaleWidth - rulerLableHeigh/2, rulerLableWidth, rulerLableHeigh);
            rulerLable.textAlignment = self.showType==FZRRulerViewshowHorizontalType?NSTextAlignmentCenter:NSTextAlignmentLeft;
            
            
            [self addSubview:rulerLable];
            
            if (Remainder==5) {
                point = self.showType==FZRRulerViewshowHorizontalType?CGPointMake(self.frame.size.width/2 + i*rulerScaleWidth , rulerSizeHeightIn):CGPointMake(rulerSizeHeightIn, self.frame.size.width/2 + i*rulerScaleWidth);
                
            }
            else if(Remainder==0)
            {
                point = self.showType==FZRRulerViewshowHorizontalType?CGPointMake(self.frame.size.width/2 + i*rulerScaleWidth , rulerSizeHeightLong):CGPointMake(rulerSizeHeightLong, self.frame.size.width/2 + i*rulerScaleWidth);
            }
        }
        else
        {
             point = self.showType==FZRRulerViewshowHorizontalType?CGPointMake(self.frame.size.width/2 + i*rulerScaleWidth , rulerSizeHeightShort):CGPointMake(rulerSizeHeightShort, self.frame.size.width/2 + i*rulerScaleWidth);
        }
        
        [path addLineToPoint:point];
        
    }
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = rulerSizeWidth;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector
    (strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.1;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [self.layer addSublayer:layer];
}


@end
