//
//  ViewController.m
//  MeasuringRuler
//
//  Created by IOS-开发机 on 15/11/10.
//  Copyright © 2015年 IOS-开发机. All rights reserved.
//

#import "ViewController.h"
#import "FZRRulerView.h"
@interface ViewController ()<FZRRulerViewDelegate>

@property(nonatomic,strong)FZRRulerView *rulerview;
@property(nonatomic,strong)UILabel *valueLable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    CGRect rect1=CGRectMake(20, 200, self.view.frame.size.width-40, 50);
    FZRRulerView *rulerview=[[FZRRulerView alloc]initWithMixNuber:0 maxNuber:1000 showType:FZRRulerViewshowHorizontalType rulerMultiple:10];
    rulerview.round = NO;
    rulerview.defaultVaule=5;
    rulerview.frame=rect1;
    _rulerview=rulerview;
    _rulerview.delegate=self;
    
    [self.view  addSubview:rulerview];
    
    
    UIButton *statusBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    statusBtn.backgroundColor=[UIColor redColor];
    statusBtn.frame=CGRectMake(self.view.frame.size.width-80, 60, 40, 40);
    [statusBtn setTitle:@"垂直" forState:UIControlStateNormal];
    [statusBtn setTitle:@"水平" forState:UIControlStateSelected];
    [statusBtn addTarget:self action:@selector(changeRulerShowType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:statusBtn];
    
    
    UILabel *valueLable=[[UILabel alloc] init];
    _valueLable=valueLable;
    valueLable.font=[UIFont systemFontOfSize:18];
    valueLable.frame=CGRectMake(20, 60, 150, 80);
    valueLable.textColor=[UIColor blackColor];
    valueLable.text=@"0.5";
    [self.view  addSubview:valueLable];
}

-(void)changeRulerShowType:(UIButton *)button{
    button.selected=!button.selected;
    [_rulerview removeFromSuperview];
    
    CGRect rect1=CGRectMake(20,200, self.view.frame.size.width-40, 50);
    CGRect rect2=CGRectMake(150, 50, 50, self.view.frame.size.height-100);
    if ( button.selected) {
        _rulerview= [[FZRRulerView alloc]initWithMixNuber:0 maxNuber:1000 showType:FZRRulerViewshowVerticalType rulerMultiple:10];
        _rulerview.defaultVaule=5;
        _rulerview.frame=rect2;
    }else{
        [_rulerview removeFromSuperview];
        _rulerview=[[FZRRulerView alloc]initWithMixNuber:0 maxNuber:1000 showType:FZRRulerViewshowHorizontalType rulerMultiple:10];
        _rulerview.defaultVaule=5;
        _rulerview.frame=rect1;
    }
    _rulerview.delegate=self;
    _rulerview.round = NO;
    _valueLable.text = @"85";
    [self.view  addSubview:_rulerview];
    
}


#pragma mark FZRRulerViewDelegate
-(void)getRulerValue:(CGFloat)rulerValue withScrollRulerView:(FZRRulerView *)rulerView{
    _valueLable.text=[NSString stringWithFormat:@"%f",rulerValue];
//    NSLog(@"rulerValue %f",rulerValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
