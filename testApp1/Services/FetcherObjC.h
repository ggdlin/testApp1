//
//  FetcherObjC.h
//  testApp1
//
//  Created by Sergey Ivanov on 22.11.2021.
//
#import "testApp1-Swift.h"

#ifndef FetcherObjC_h
#define FetcherObjC_h


#endif /* FetcherObjC_h */

@interface FetcherObjC : NSObject <FetcherProtocol>
{
    NSString * imagePath;
    NSString * textPath;

}

@property (nonatomic) id <DataStorerProtocol> storer;   // why need nonatomic attribute?
@property (nonatomic) id <WebRequesterProtocol> webRequester;   // why need nonatomic attribute?
@property (nonatomic, weak) id <FetcherDelegate> delegate;

@end
