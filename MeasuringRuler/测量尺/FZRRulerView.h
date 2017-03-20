//
//  FZRRulerView.h
//  MeasuringRuler
//
//  Created by IOS-开发机 on 15/11/10.
//  Copyright © 2015年 IOS-开发机. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZRRulerScrollView.h"

@class FZRRulerView;

@protocol FZRRulerViewDelegate <NSObject>

@optional
-(void)getRulerValue:(CGFloat)rulerValue withScrollRulerView:(FZRRulerView *)rulerView;

@end


@interface FZRRulerView : UIView

@property(nonatomic,weak)FZRRulerScrollView *rulerView;
/**
 *  是否对小数四舍五入
 */
@property(nonatomic,assign)BOOL round;
/**
 *  刻度默认值
 */
@property(nonatomic,assign) CGFloat defaultVaule;
@property(nonatomic,weak) id<FZRRulerViewDelegate> delegate;

/**
 *  创建一个rulerView
 *
 *  @param mixNuber 最小刻度
 *  @param maxNuber 最大刻度
 *  @param showType 显示模式
 *  @param rulerMultiple 刻度的倍数
 *  @return rulerView
 */
-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(FZRRulerViewShowType)showType rulerMultiple:(CGFloat)rulerMultiple;
@end
