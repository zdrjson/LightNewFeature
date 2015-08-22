//
//  NewFeatureScrollView.h
//  MyNewFeature
//
//  Created by 张德荣 on 15/8/10.
//  Copyright (c) 2015年 JsonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureScrollView : UIScrollView
+(UIScrollView *)newWithNewFeatureImageArr:(NSArray *)newFeatureImageArr withFrame:(CGRect)frame;
/*
 *  是否应该显示版本新特性界面
 */
+(BOOL)canShowNewFeature;

@end
