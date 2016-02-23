//
//  LoginViewController.h
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/22/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITextField* emailTextField;
@property (nonatomic,strong) IBOutlet UITextField* passwordTextField;

@property (nonatomic,strong) IBOutlet UIButton* loginButton;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView* indicatorView;

@end
