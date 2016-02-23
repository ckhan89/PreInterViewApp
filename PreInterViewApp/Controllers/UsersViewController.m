//
//  UsersViewController.m
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/23/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import "UsersViewController.h"
#import "NotiConstants.h"
#import "OtherContants.h"
#import "User.h"
#import "UserTableViewCell.h"
#import "NetworkHandler.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UsersViewController ()
{
    NSMutableArray* array;
}

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserList) name:NEW_USER object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUsersSusses:) name:GET_USERS_SUSSESS object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getUserList
{
    [[NetworkHandler getInstance] getUsers];
}

- (void) getUsersSusses: (NSNotification*) noti
{
//    NSLog(@"getUsersSusses:%@",object);
    array=noti.userInfo[KEY_LIST_USER];
    NSLog(@"Count:%ld",(unsigned long)array.count);
    [self.tableView reloadData];
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"table count:%ld",(unsigned long)array.count);
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    User* user=[array objectAtIndex:indexPath.row];
    [cell.nameLabel setText:user.nameString];
    [cell.emailLabel setText:user.emailString];
    [cell.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.urlAvatarString]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}
#pragma UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height/8;
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
