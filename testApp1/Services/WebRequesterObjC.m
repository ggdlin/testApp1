//
//  WebRequesterObjC.m
//  testApp1
//
//  Created by Sergey Ivanov on 23.11.2021.
//

#import "WebRequesterObjC.h"

#import <Foundation/Foundation.h>

@implementation WebRequesterObjC


- (void)fetchImageDataWithUrl:(NSURL * _Nonnull)url closure:(void (^ _Nonnull)(NSData * _Nullable))closure {
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            if (data) {
                
                NSString * parsedStringImageUrl = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey: @"url"];
                NSURL * imageUrl = [NSURL URLWithString:parsedStringImageUrl];
                
                NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
                
                closure(imageData);
                
            }
        }] resume];
}


- (NSString * _Nullable)fetchTextWithUrl:(NSURL * _Nonnull)url {
    
    NSData * textJsonData = [[NSData alloc] initWithContentsOfURL:url];
    
    NSMutableDictionary * parsedStringText = [NSJSONSerialization JSONObjectWithData:textJsonData options:NSJSONReadingMutableContainers error:nil];
    
    return [parsedStringText objectForKey:@"quoteText"];
}

@end
