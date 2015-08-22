//
//  ViewController.m
//  MyNewFeature
//
//  Created by 张德荣 on 15/8/10.
//  Copyright (c) 2015年 JsonZhang. All rights reserved.
//

#import "ViewController.h"

#import "NewFeatureScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%d",(117 -117 %40));//
    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    BOOL canShow = [NewFeatureScrollView canShowNewFeature];
    
    if(canShow)
    {
        NSMutableArray * newFeatureImageArr = [NSMutableArray array];
        for (int i = 0; i<4; i++) {
            
            [newFeatureImageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"iphone5_%d",i+1]]];
        }
        [self.view addSubview:[NewFeatureScrollView newWithNewFeatureImageArr:newFeatureImageArr withFrame:[UIScreen mainScreen].bounds]];
    }
   
    self.view.backgroundColor = [UIColor cyanColor];
}

@end
