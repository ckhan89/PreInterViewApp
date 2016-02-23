//
//  NetworkHandler.h
//  TrialInoreader
//
//  Created by cao Ky Han on 12/16/15.
//  Copyright © 2015 Cao Ky Han. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHandler : NSObject

+ (NetworkHandler*) getInstance;

- (void) signupWithName:(NSString*) name Email:(NSString*) email Password:(NSString*) password;

- (void) loginWithUsername:(NSString*) username Password:(NSString*) password;

- (void) getUsers;

//- (void) getListnewFeeds;
//
//- (void) updateNewsWithData:(id) responseObject;

@end
