//
//  ViewControllerObjC.h
//  testApp1
//
//  Created by Sergey Ivanov on 10.11.2021.
//
#import <UIKit/UIKit.h>
#import "testApp1-Swift.h"

#ifndef ViewControllerObjC_h
#define ViewControllerObjC_h



#endif /* ViewControllerObjC_h */

@interface ViewControllerObjC : UIViewController 
{
    int rowsCount;
    __block NSMutableArray<ImageAndText*> * images;
    id <FetcherProtocol> fetcher;
}
@property (weak, nonatomic) IBOutlet UITableView * tableView;



-(NSMutableArray<ImageAndText*> *) arrayWithImageStubs: (int) itemsAmount;
@end
