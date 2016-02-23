//
//  UsersViewController.h
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/23/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) IBOutlet UITableView* tableView;

@end
