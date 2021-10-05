//
//  ObjCDataStorer.h
//  testApp1
//
//  Created by Sergey Ivanov on 24.09.2021.
//
#import <Foundation/Foundation.h>
//#import "testApp1-Swift.h" // ошибка компиляции ???


#ifndef ObjCDataStorer_h
#define ObjCDataStorer_h

@interface ObjCDataStorer : NSObject
- (instancetype) init;
- (int) load;
@end

#endif /* ObjCDataStorer_h */
