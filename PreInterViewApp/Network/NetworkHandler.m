//
//  NetworkHandler.m
//  TrialInoreader
//
//  Created by cao Ky Han on 12/16/15.
//  Copyright © 2015 Cao Ky Han. All rights reserved.
//

#import "NetworkHandler.h"
#import "NetworkConstants.h"
#import "NotiConstants.h"
#import "OtherContants.h"
#import "KeyOfJson.h"
#import "User.h"
#import <AFNetworking/AFNetworking.h>


@implementation NetworkHandler
{
    AFHTTPSessionManager* manager;
    NSString* token;
    NSString* continuation;
}

- (instancetype) initNetworkHandler
{
    self=[super init];
    if (self) {
        manager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    }
    return self;
}

+ (NetworkHandler*) getInstance
{
    static NetworkHandler* instance=nil;
    @synchronized(instance) {
        if (instance==nil) {
            instance=[[NetworkHandler alloc] initNetworkHandler];
        }
        return instance;
    }
}

- (void) signupWithName:(NSString *)name Email:(NSString *)email Password:(NSString *)password
{
    NSMutableDictionary* parameters=[NSMutableDictionary dictionary];
    parameters[KEY_NAME]=name;
    parameters[KEY_EMAIL]=email;
    parameters[KEY_PASS]=password;
    // request to login
    [manager POST:PATH_SIGNUP parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SIGNUP_SUSSCESS object:nil];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSHTTPURLResponse* response=(NSHTTPURLResponse*)operation.response;
        if(response.statusCode!=STATUS_SUCCESS){
            NSDictionary *infor=[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:(int)response.statusCode] forKey:KEY_STATUS_CODE];
            [[NSNotificationCenter defaultCenter] postNotificationName:SIGNUP_FAIL object:nil userInfo:infor];
        }
    }];
}

- (void) loginWithUsername:(NSString *)username Password:(NSString *)password
{
    NSLog(@"loginWithUsername");
    // set parameters for requesting
    NSMutableDictionary* parameters=[NSMutableDictionary dictionary];
    parameters[KEY_EMAIL]=username;
    parameters[KEY_PASS]=password;
    // request to login
    [manager POST:PATH_LOGIN parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSError* error;
        NSString* str=[NSString stringWithUTF8String:[responseObject bytes]];
        NSDictionary* jsonObject=[NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        // get token when login success
        NSString* authToken=jsonObject[KEY_TOKEN];
        // save token
        [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:KEY_TOKEN];
        // send message to LoginController
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUSSCESS object:nil];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSHTTPURLResponse* response=(NSHTTPURLResponse*)operation.response;
        if(response.statusCode!=STATUS_SUCCESS){
            NSDictionary *infor=[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:(int)response.statusCode] forKey:KEY_STATUS_CODE];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAIL object:nil userInfo:infor];
        }
    }];
}

- (void) getUsers
{
    NSString* tokenString=[[NSUserDefaults standardUserDefaults] valueForKey:KEY_TOKEN];
    NSString* headervalue=[NSString stringWithFormat:@"m %@",tokenString];
    [manager.requestSerializer setValue:@"Authorization" forHTTPHeaderField:@"Header-type"];
    [manager.requestSerializer setValue:headervalue forHTTPHeaderField:@"Authorization"];
    [manager GET:PATH_GETUSERS parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSError* error;
        NSString* str=[NSString stringWithUTF8String:[responseObject bytes]];
        NSArray* items=[NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
        NSMutableArray* users=[[NSMutableArray alloc] initWithCapacity:0];
        NSLog(@"Count:%lu",(unsigned long)items.count);
        NSLog(@"Items:%@",items.description);
        for (int k=0; k<items.count; k++) {
            User* user=[[User alloc] init];
            user.nameString=items[k][KEY_NAME];
            user.emailString=items[k][KEY_EMAIL];
            user.urlAvatarString=items[k][KEY_AVATAR];
            [users addObject:user];
        }
        NSDictionary* theinfor=[NSDictionary dictionaryWithObject:users forKey:KEY_LIST_USER];
        [[NSNotificationCenter defaultCenter] postNotificationName:GET_USERS_SUSSESS object:nil userInfo:theinfor];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
    
}
@end
