//
//  ViewControllerObjC+ViewControllerObjC_UITableViewDataSource.m
//  testApp1
//
//  Created by Sergey Ivanov on 11.11.2021.
//

#import "ViewControllerObjC+ViewControllerObjC_UITableViewDataSource.h"


@implementation ViewControllerObjC (ViewControllerObjC_UITableViewDataSource)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString * cellIdenifier = @"cell";
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: cellIdenifier];
    if (cell == nil)
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenifier];
    
    // todo - images shown at cells
    NSInteger imageIndex = indexPath.row;
    if (imageIndex < images.count) {
        ImageAndText * cellContent = images[imageIndex];
        cell.imageForMe.image = cellContent.image;
        cell.labelForMe.text = cellContent.text;
        NSLog(@"Cell with id %li is added to table", (long)imageIndex);
    }
        
    return  cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return images.count;
}


// Mark - UITableViewDelegate

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIContextualAction * deleteAction = [UIContextualAction contextualActionWithStyle: UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        NSLog(@"delete row action");
        if (self) {
            ImageAndText * item = self->images[indexPath.row];
            
            [self->images removeObjectAtIndex:indexPath.row];
            [self->fetcher deleteRecord:item];
            
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            [tableView endUpdates];
        };
        
    }];

    
    return  [UISwipeActionsConfiguration configurationWithActions: [NSArray arrayWithObject: deleteAction]];
}

@end
