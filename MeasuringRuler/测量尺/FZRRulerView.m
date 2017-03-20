//
//  FZRRulerView.m
//  MeasuringRuler
//
//  Created by IOS-开发机 on 15/11/10.
//  Copyright © 2015年 IOS-开发机. All rights reserved.
//

#import "FZRRulerView.h"


static  CGFloat rulerScaleWidth;

//rulerView的宽度或高度
static  CGFloat const rulerViewWOH=1.5;
//红色指针的高度
static  CGFloat const pointViewH=35;

@interface FZRRulerView ()<UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger mixNuber;
@property(nonatomic,assign)NSInteger maxNuber;
@property(nonatomic,assign)FZRRulerViewShowType showType;

@property(nonatomic,weak)UIView *pointerView;
@end

@implementation FZRRulerView

-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(FZRRulerViewShowType)showType rulerMultiple:(CGFloat)rulerMultiple{
    
    if (self=[super init]) {
        self.clipsToBounds=YES;
        _round=NO;
        _mixNuber=mixNuber;
        _maxNuber=maxNuber;
        _showType=showType;
        rulerScaleWidth = rulerMultiple;
        
        //添加scroollView
        FZRRulerScrollView *rulerView= [[FZRRulerScrollView alloc] initWithMixNuber:_mixNuber maxNuber:_maxNuber showType:_showType rulerMultiple:rulerScaleWidth];
        rulerView.delegate=self;
        _rulerView=rulerView;
        [self addSubview:rulerView];
        //添加指针view
        UIView *pointerView=[[UIView alloc] init];
        pointerView.backgroundColor=[UIColor redColor];
        _pointerView=pointerView;
        [self addSubview:pointerView];
    }
    return self;
    
}


-(void)setDefaultVaule:(CGFloat)defaultVaule{
    
    CGFloat formlength=rulerScaleWidth;
    CGFloat gapValue=((defaultVaule-_mixNuber)*formlength)+self.frame.size.width/2;
    if (_showType==FZRRulerViewshowHorizontalType) {
        _rulerView.contentOffset=CGPointMake(gapValue, 0);
    }else{
        _rulerView.contentOffset=CGPointMake(0, gapValue);
    }
    
}


-(void)layoutSubviews{
    
    [super layoutSubviews];
    if (_showType==FZRRulerViewshowHorizontalType) {//如果是水平
        CGFloat pointerViewW=rulerViewWOH;
        CGFloat pointerViewH=pointViewH;
        CGFloat pointerViewX=(self.frame.size.width-pointerViewW)/2;
        CGFloat pointerViewY=0;
        _pointerView.frame=CGRectMake(pointerViewX, pointerViewY, pointerViewW, pointerViewH);
        _rulerView.frame=CGRectMake(self.frame.size.width/2, 0, rulerViewWOH, self.frame.size.height);
    }else {
        CGFloat pointerViewW=pointViewH;
        CGFloat pointerViewH=rulerViewWOH;
        CGFloat pointerViewX=0;
        CGFloat pointerViewY=(self.frame.size.height-pointerViewH)/2;
        _pointerView.frame=CGRectMake(pointerViewX, pointerViewY, pointerViewW, pointerViewH);
        _rulerView.frame=CGRectMake(0,self.frame.size.height/2, self.frame.size.width, rulerViewWOH);
    }
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat formlength=rulerScaleWidth;
    //指针指向的刻度
    CGFloat value=0;
    //滑动的刻度值
    CGFloat scrollValue=0;
    
    if ([self.delegate respondsToSelector:@selector(getRulerValue:withScrollRulerView:)]) {
        CGFloat contentOffsetValue=0;
        if (_showType==FZRRulerViewshowHorizontalType) {
            contentOffsetValue=scrollView.contentOffset.x;
        }else{
            contentOffsetValue=scrollView.contentOffset.y;
        }
        scrollValue = contentOffsetValue/formlength;
        
        if (_round) {
            value=_mixNuber+round(scrollValue);
        }else{
            value=_mixNuber+scrollValue;
        }
        
        [self.delegate getRulerValue:value withScrollRulerView:self];
    }
    
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    UIView *view=[super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[FZRRulerView class]]) {
        return _rulerView;
    }else{
        return view;
    }
    
}


@end
