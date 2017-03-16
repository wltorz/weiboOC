//
//  WLTTabBarViewController.m
//  weiboOC
//
//  Created by 万伶童 on 17/3/15.
//  Copyright © 2017年 万伶童. All rights reserved.
//

#import "WLTTabBarViewController.h"
#import "WLTNavViewController.h"
// 自定义tabBar
#import "WLTtabBar.h"
@interface WLTTabBarViewController ()
//tabBar是UITabBarController的只读成员变量（属性），是不让修改的，在UITabBarController.h文件中的声明如下：
@property(nonatomic,readonly)UITabBar * tabBar;
@end

@implementation WLTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupUI];
    
}

- (void)setupUI{
    
    //针对于这种情况，我们可以使用KVC的方式，更换系统自带的UITabBar，实现代码如下：
    // 创建自定义的tabBar并替换系统的tabBar
    
    WLTtabBar * wltTabBar = [[WLTtabBar alloc]init];
    
    [self setValue:wltTabBar forKey:@"tabar"];
    
    //根据字典生成控制器  tabbar_home_selected
    
    NSDictionary * homeDic = @{@"vcName":@"WLTHomeViewController",@"title":@"首页",@"imgName":@"tabbar_home"};
    NSDictionary * messageDic = @{@"vcName":@"WLTMessageViewController",@"title":@"消息",@"imgName":@"tabbar_message_center"};
    NSDictionary * discoverDic = @{@"vcName":@"WLTDiscoverViewController",@"title":@"发现",@"imgName":@"tabbar_discover"};
    NSDictionary * meDic = @{@"vcName":@"WLTMeViewController",@"title":@"我的",@"imgName":@"tabbar_profile"};
    
    UIViewController * homeVC = [self addChildControllerDic:homeDic];
    UIViewController * msgVc = [self addChildControllerDic:messageDic];
    UIViewController * disVc = [self addChildControllerDic:discoverDic];
    UIViewController * meVc = [self addChildControllerDic:meDic];
    
    self.viewControllers = @[homeVC,msgVc,disVc,meVc];
    
    
    
}
#pragma mark - 重写父类的
#pragma mark - 添加子4个子控制器
- (UIViewController*)addChildControllerDic:(NSDictionary *)dic{
    
    
    
    Class cls = NSClassFromString(dic[@"vcName"]);
    
    UIViewController * vc = [[cls alloc] init];
    
    vc.title = dic[@"title"];
    
    // 设置图片的渲染颜色(不是系统蓝)
    vc.tabBarItem.image = [[UIImage imageNamed:dic[@"imgName"]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",dic[@"imgName"]]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置item的文字颜色
    
      NSDictionary *dicColor = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [vc.tabBarItem setTitleTextAttributes:dicColor forState:UIControlStateSelected];
    
    WLTNavViewController * nav = [[WLTNavViewController alloc]initWithRootViewController:vc];
    
    return nav;
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
