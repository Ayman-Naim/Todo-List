//
//  DoneViewController.h
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
