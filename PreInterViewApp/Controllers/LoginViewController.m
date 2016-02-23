//
//  LoginViewController.m
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/22/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import "LoginViewController.h"
#import "NetworkHandler.h"
#import "NotiConstants.h"
#import "NetworkConstants.h"
#import "OtherContants.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // add this class as a observer all event when login
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucsses) name:LOGIN_SUSSCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFail:) name:LOGIN_FAIL object:nil];
    // auto fill email and pass 
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_EMAIL]) {
        _emailTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:KEY_EMAIL];
        _passwordTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:KEY_PASS];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickLoginButton:(id)sender
{
    [self startIndicatorWithEnable:YES];
    [[NetworkHandler getInstance] loginWithUsername:self.emailTextField.text Password:self.passwordTextField.text];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma Handle all event when loginning

- (void) startIndicatorWithEnable:(BOOL) enable
{
    [_loginButton setEnabled:!enable];
    [_emailTextField setEnabled:!enable];
    [_passwordTextField setEnabled:!enable];
    if (enable) {
        [_indicatorView startAnimating];
    }else{
        [_indicatorView stopAnimating];
    }
}

// handle when request sucess

- (void) loginSucsses
{
    NSLog(@"loginSucsses");
    [self startIndicatorWithEnable:NO];
    //
    [[NSUserDefaults standardUserDefaults] setObject:_emailTextField.text forKey:KEY_EMAIL];
    [[NSUserDefaults standardUserDefaults] setObject:_passwordTextField.text forKey:KEY_PASS];
    //
    MainViewController* mainController=[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:mainController animated:NO];
}

// handle when request login fail
- (void) loginFail:(NSNotification*) noti
{
    NSLog(@"loginFail");
    [self startIndicatorWithEnable:NO];
    NSString* contentAlert;
    NSNumber* number=noti.userInfo[KEY_STATUS_CODE];
    switch ([number intValue]) {
        case STATUS_INTERNET_FAIL:
            contentAlert=[NSString stringWithFormat:@"The Internet connection appears to be offline."];
            break;
        case STATUS_USERPASS_FAIL:
            contentAlert=[NSString stringWithFormat:@"Your session has expired! Please Sign In again."];
            break;
        case STATUS_SERVICE:
            contentAlert=[NSString stringWithFormat:@"Service unavailable."];
            break;
        default:
            break;
    }
    
    // show alert
    UIAlertController* alertControler=[UIAlertController alertControllerWithTitle:@"ERROR!" message:contentAlert preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alertControler dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alertControler addAction:ok];
    [self presentViewController:alertControler animated:YES completion:^(void){
        
    }];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma handle keyboard when touch on view
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


@end
