//
//  SignupViewController.h
//  PreInterViewApp
//
//  Created by cao Ky Han on 2/22/16.
//  Copyright © 2016 Cao Ky Han. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITextField* nameTextField;
@property (nonatomic,strong) IBOutlet UITextField* emailTextField;
@property (nonatomic,strong) IBOutlet UITextField* passwordTextField;

@property (nonatomic,strong) IBOutlet UIButton* signupButton;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView* indicatorView;

@end
