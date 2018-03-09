/*
 *    |  ____ \    / ____ \   | |\   | |   / _______|
 *    | |    \ |  / /    \ \  |   \  | |  / /
 *    | |    | |  | |    | |  | |\ \ | |  | |   _____
 *    | |    | |  | |    | |  | | \ \| |  | |  |____ |
 *    | |____/ /  \ \____/ /  | |  \   |  \ \______| |
 *    |_______/    \______/   |_|   \|_|   \_________|
 *
 */

//
//  DONG_AlertShowTool.m
//  DTH Service App
//
//  Created by yesdgq on 2017/4/17.
//  Copyright © 2017年 yesdgq. All rights reserved.
//

#import "DONG_AlertShowTool.h"

//#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController
#define kRootViewController [DONG_AlertShowTool currentViewController]

@implementation DONG_AlertShowTool

/** 单个按键的 alertView */
+ (void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle handler:(void(^)())handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // creat action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        if (handler) {
            handler();
        }
    }];
    
    // add acton
    [alert addAction:cancelAction];
    
    // present alertView on rootViewController
    [kRootViewController presentViewController:alert animated:YES completion:nil];
}

/** 双按键的 alertView */
+ (void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle defaultTitle:(NSString *)defaultTitle distinct:(BOOL)distinct cancel:(void(^)())cancel confirm:(void(^)())confirm {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (distinct) {
        // 左深右浅
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }];
        [alert addAction:cancelAction];
    } else {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }];
        [alert addAction:cancelAction];
    }
    
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:defaultTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        };
    }];
    
    [alert addAction:defaultAction];
    
    
    [kRootViewController presentViewController:alert animated:YES completion:nil];
}

/** Alert  任意多个按键 返回选中的 buttonIndex 和 buttonTitle */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        handler(0, @"取消");
    }];
    [alert addAction:cancelAction];
    
    for (int i = 0; i < actionTitles.count; i ++) {
        
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handler((i + 1), actionTitles[i]);
        }];
        [alert addAction:confimAction];
    }
    
    [kRootViewController presentViewController:alert animated:YES completion:nil];
}

+ (UIViewController *)currentViewController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController *)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

@end
