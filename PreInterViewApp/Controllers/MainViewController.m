//
//  MainViewController.m
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/23/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import "MainViewController.h"
#import "NetworkHandler.h"
#import <CarbonKit/CarbonKit.h>

@interface MainViewController ()<CarbonTabSwipeNavigationDelegate>
{
    NSArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    items=@[@"Users",@"Setting"];
    // Do any additional setup after loading the view.
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    [self style];
    // get Users
    [[NetworkHandler getInstance] getUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)style {
    
    UIColor *color = [UIColor colorWithRed:24.0/255 green:75.0/255 blue:152.0/255 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    [carbonTabSwipeNavigation setIndicatorColor:color];
    [carbonTabSwipeNavigation setTabExtraWidth:30];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:self.view.frame.size.width/2 forSegmentAtIndex:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:self.view.frame.size.width/2 forSegmentAtIndex:1];
    // Custimize segmented control
    [carbonTabSwipeNavigation setNormalColor:[color colorWithAlphaComponent:0.6]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:color
                                          font:[UIFont boldSystemFontOfSize:14]];
}
# pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"UsersViewController"];
            
        default:
            return [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    }
}

// optional
- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                 willMoveAtIndex:(NSUInteger)index {
    switch(index) {
        case 0:
            self.title = @"Users";
            break;
        default:
            self.title = @"Setting";
            break;
    }
}

- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
    NSLog(@"Did move at index: %ld", index);
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
