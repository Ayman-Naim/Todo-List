//
//  TodoViewController.h
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TodoViewController : ViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)AddTodo:(id)sender;


@end

NS_ASSUME_NONNULL_END
