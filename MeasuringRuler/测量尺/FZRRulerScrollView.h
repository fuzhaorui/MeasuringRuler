//
//  FZRRulerScrollView.h
//  MeasuringRuler
//
//  Created by IOS-开发机 on 15/11/10.
//  Copyright © 2015年 IOS-开发机. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FZRRulerViewShowType) {
    /**
     *  水平显示模式
     */
    FZRRulerViewshowHorizontalType=0,
    /**
     *  垂直显示模式
     */
    FZRRulerViewshowVerticalType
};

@interface FZRRulerScrollView : UIScrollView

-(instancetype)initWithMixNuber:(NSInteger)mixNuber maxNuber:(NSInteger)maxNuber showType:(FZRRulerViewShowType)showType rulerMultiple:(CGFloat)rulerMultiple;

@end
