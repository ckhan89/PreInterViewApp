//
//  OtherContants.h
//  TrialInoreader
//
//  Created by cao Ky Han on 12/19/15.
//  Copyright © 2015 Cao Ky Han. All rights reserved.
//

#ifndef OtherContants_h
#define OtherContants_h

#define KEY_LIST_USER @"list user"
typedef enum : int {
    STATUS_INTERNET_FAIL=0,
    STATUS_USERPASS_FAIL=401,
    STATUS_SUCCESS=200,
    STATUS_SERVICE=503,
    // can implement at this to handle other status codes.
}StatusCode;
#endif /* OtherContants_h */
