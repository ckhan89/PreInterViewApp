//
//  ViewController.m
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/22/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import "WelcomeController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface WelcomeController ()

@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickToLoginView:(id)sender
{
    LoginViewController* loginController=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginController animated:YES];
}

- (IBAction)clickToSignUpView:(id)sender
{
    SignupViewController* signupController=[self.storyboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    [self.navigationController pushViewController:signupController animated:YES];
}

@end
