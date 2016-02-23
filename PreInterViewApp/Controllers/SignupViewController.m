//
//  SignupViewController.m
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/22/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import "SignupViewController.h"
#import "NetworkHandler.h"
#import "OtherContants.h"
#import "NotiConstants.h"
#import "NetworkConstants.h"
#import <Parse/Parse.h>

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // add this class as a observer all event when signup
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signupSucsses) name:SIGNUP_SUSSCESS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signUpFail:) name:SIGNUP_FAIL object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickSignupButton:(id)sender
{
    [self startIndicatorWithEnable:YES];
    [[NetworkHandler getInstance] signupWithName:self.nameTextField.text Email:self.emailTextField.text Password:self.passwordTextField.text];
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
    [_signupButton setEnabled:!enable];
    [_nameTextField setEnabled:!enable];
    [_emailTextField setEnabled:!enable];
    [_passwordTextField setEnabled:!enable];
    if (enable) {
        [_indicatorView startAnimating];
    }else{
        [_indicatorView stopAnimating];
    }
}

// handle when request sucess

- (void) signupSucsses
{
    NSLog(@"signupSucsses");
    // send push notication to the app
    // Create our Installation query
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"deviceType" equalTo:@"ios"];

    // Send push notification to query
    [PFPush sendPushMessageToQueryInBackground:pushQuery
                                   withMessage:@"new user is created"];
    // 
    [self startIndicatorWithEnable:NO];
    //
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// handle when request login fail
- (void) signUpFail:(NSNotification*) noti
{
    NSLog(@"signUpFail");
    [self startIndicatorWithEnable:NO];
    NSString* contentAlert;
    NSNumber* number=noti.userInfo[KEY_STATUS_CODE];
    switch ([number intValue]) {
        case STATUS_INTERNET_FAIL:
            contentAlert=[NSString stringWithFormat:@"The Internet connection appears to be offline."];
            break;
        case STATUS_USERPASS_FAIL:
            contentAlert=[NSString stringWithFormat:@"Your session has expired! Please Sign Up again."];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
