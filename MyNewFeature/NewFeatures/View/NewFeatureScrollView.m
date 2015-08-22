//
//  NewFeatureScrollView.h
//  MyNewFeature
//
//  Created by 张德荣 on 15/8/10.
//  Copyright (c) 2015年 JsonZhang. All rights reserved.
//

#import "NewFeatureScrollView.h"

@interface NewFeatureScrollView () <UIScrollViewDelegate>
@property (nonatomic,strong) NSArray * myNewFeatureImageArr;
@property (nonatomic,strong) UIImageView * imageView;
@property(nonatomic,strong)UIPageControl * pageControl;

@end

@implementation NewFeatureScrollView

+(UIScrollView *)newWithNewFeatureImageArr:(NSArray *)newFeatureImageArr withFrame:(CGRect)frame
{
    return [[self alloc] initNewWithNewFeatureImageArr:newFeatureImageArr withFrame:frame];
}

- (instancetype)initNewWithNewFeatureImageArr:(NSArray *)newFeatureImageArr withFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //记录数据
        self.myNewFeatureImageArr = newFeatureImageArr;
        
        [self viewPrepare];
        //设置imageView
        [self setupImageView];
        
        [self setupPageControl];
    }
    return self;
}
-(void)setupPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5, 300, 36, 36)];
     self.pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.98);
    self.pageControl.numberOfPages = self.myNewFeatureImageArr.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.0f green:102.0f/255.0f blue:0.0f alpha:1.0f];
    
}
-(void)setupImageView
{
    [self.myNewFeatureImageArr enumerateObjectsUsingBlock:^(UIImage * image, NSUInteger idx, BOOL *stop) {
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
    }];
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
   [self.window addSubview:self.pageControl];

}
/*
 *  视图准备
 */
-(void)viewPrepare
{
    //设置代理
    self.delegate = self;
    
    //开启分页
    self.pagingEnabled = YES;
    
    //隐藏各种条
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    //取消boundce
    self.bounces = NO;
    
}

-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    __block CGRect frame = [UIScreen mainScreen].bounds;
    
    __block NSUInteger count = 0;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
       
        if([subView isKindOfClass:[UIImageView class]]){
            
            CGFloat frameX = frame.size.width * idx;
            
            frame.origin.x = frameX;
            
            subView.frame = frame;
            
            count ++;
        }
    }];
    
    self.contentSize = CGSizeMake(frame.size.width * (count+1), 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   scrollView.bounces = scrollView.contentOffset.x < [UIScreen mainScreen].bounds.size.width?NO:YES;
    double page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //四舍五入计算出页码
    self.pageControl.currentPage = (int)(roundf(page));
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    if (self.contentSize.width == scrollView.contentOffset.x + [UIScreen mainScreen].bounds.size.width)
    {
        [self removeFromSuperview];
        [self.pageControl removeFromSuperview];
        self.pageControl = nil;
    }
   
}

/*
 *  是否应该显示版本新特性页面
 */
+(BOOL)canShowNewFeature{

    NSString * key = @"CFBundleVersion";
    //上一次的使用版本（存进在沙盒中得版本号）
    NSString * lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //当前软件的版本号（从info.plist中获得）
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) { //版本号相同：这次打开和上次打开的是同一个版本//说明有本地版本记录，且和当前系统版本一致 
        
        return NO;
        
    }
    else{//无本地版本记录或本地版本记录与当前系统版本不一致
        
        //将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
}
-(void)dealloc
{
    NSLog(@"newFeatureScrollView Dealloc");
}
@end
