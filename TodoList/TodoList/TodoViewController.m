//
//  TodoViewController.m
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import "TodoViewController.h"
#import "CreateViewController.h"
#import "TodoClass.h"
#import "Details_EditViewController.h"
@interface TodoViewController ()
{
    NSMutableArray *Todo;
    NSUserDefaults *defaulte ;
    NSData *myEncodedObject ;
    TodoClass *todo;
   // NSMutableArray<TodoClass*> * arr;
    NSMutableArray<NSNumber*> * todoArray;
    Details_EditViewController *Details;
    NSMutableArray<NSNumber*> * search_index;
    bool search_active;
    NSMutableArray<NSNumber*> * high;
    NSMutableArray<NSNumber*> * low;
    NSMutableArray<NSNumber*> * medium;
    bool sort;
    NSData *data;
}
@property NSMutableArray<TodoClass*> * arr;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;

@end

@implementation TodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arr=[NSMutableArray<TodoClass*> new];
    printf("called");
  //  Todo=[NSMutableArray new];
    _SearchBar.delegate=self;
    search_active=false;
    sort=NO;
    [self Load];
    [self.tableView reloadData];
   
    // Do any additional setup after loading the view.
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
   
    
    if ([searchText isEqualToString:@""]) {
        search_active = false;
    }
    else {
        search_active = true;
    }
    [self Load];
    [self.tableView reloadData];
    
}
- (void)viewDidAppear:(BOOL)animated{
   /* [self.tableView reloadData];
    defaulte=[NSUserDefaults standardUserDefaults];
    myEncodedObject = [defaulte objectForKey:@"TodoList" ];
    todo =[TodoClass new];
   //todo=[NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
    todo= (TodoClass *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    [Todo addObject: todo];*/
   // [_arr removeAllObjects ];
    //[todoArray removeAllObjects];
    [self Load];
    [self.tableView reloadData];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
   /* [self.tableView reloadData];
    defaulte=[NSUserDefaults standardUserDefaults];
    myEncodedObject = [defaulte objectForKey:@"TodoList" ];
    todo =[TodoClass new];
   //todo=[NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
    todo= (TodoClass *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    [Todo addObject: todo];*/
   // [self Load];
   // [self.tableView reloadData];
    
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(sort){
        return 3;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(search_active==true)
    {
        return  search_index.count;
    }
    if(sort){
        switch (section) {
            case 0:
                return  low.count;
                break;
            case 1:
                return medium.count;
                break;
            case 2:
                return high.count;
                break;


        }
    }
    return todoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
    
    /* defaulte=[NSUserDefaults standardUserDefaults];
     myEncodedObject = [defaulte objectForKey:@"TodoList" ];
     TodoClass *todo =[TodoClass new];
     //todo=[NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
     todo= (TodoClass *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
     
     NSLog(@"%@",todo.Name);
     NSLog(@"%@",todo.Description);
     NSLog(@"%@",todo.State);
     NSLog(@"%@",todo.Priorety);
     NSLog(@"%@",todo.Date);
     NSLog(@"%@",todo.image);*/
    if(search_active==true){
        cell.textLabel.text=_arr[[search_index[indexPath.row] integerValue]].Name;
    cell.image=[UIImage systemImageNamed:_arr[[search_index[indexPath.row] integerValue]].image];
    }
    else if(sort==YES){
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text=_arr[[low[indexPath.row] integerValue]].Name;
                cell.image=[UIImage systemImageNamed:_arr[[low[indexPath.row] integerValue]].image];
                break;
            case 1:
                cell.textLabel.text=_arr[[medium[indexPath.row] integerValue]].Name;
                cell.image=[UIImage systemImageNamed:_arr[[medium[indexPath.row] integerValue]].image];
                break;
            case 2:
                cell.textLabel.text=_arr[[high[indexPath.row] integerValue]].Name;
                cell.image=[UIImage systemImageNamed:_arr[[high[indexPath.row] integerValue]].image];
                break;
                
            default:
                break;
        }
    }
    else{
        cell.textLabel.text=_arr[[todoArray[indexPath.row] integerValue]].Name;
    cell.image=[UIImage systemImageNamed:_arr[[todoArray[indexPath.row] integerValue]].image];
        }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Details=[self.storyboard  instantiateViewControllerWithIdentifier:@"Edit" ];
    if(sort){
        switch (indexPath.section){
                
            case 0 :
                Details.From_page=0;
                printf("%d",(int)indexPath.row );
               // Details.index=indexPath.row;
                Details.index=[low[indexPath.row] integerValue];
                [Details Load];
                [self.navigationController pushViewController:Details animated:YES];
                break;
            case 1 :
                printf("%d",(int)indexPath.row );
                Details.From_page=0;
                Details.index=[medium[indexPath.row] integerValue];
                [Details Load];
                [self.navigationController pushViewController:Details animated:YES];
                break;
            case 2 :
                printf("%d",(int)indexPath.row );
                Details.From_page=0;
                Details.index=[high[indexPath.row] integerValue];
                [Details Load];
                [self.navigationController pushViewController:Details animated:YES];
                break;;
        }
      
    }
    else{
        
        
        switch (indexPath.section){
                
            case 0 :
                Details.From_page=0;
                Details.index=indexPath.row;
                [Details Load];
                [self.navigationController pushViewController:Details animated:YES];
                break;;
        }
    }
}

- (IBAction)AddTodo:(id)sender {
   
    CreateViewController *create=[self.storyboard  instantiateViewControllerWithIdentifier:@"Add"];
    [self.navigationController pushViewController:create animated:YES];
}



-(void)Load{
    defaulte=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject ; myEncodedObject = [defaulte objectForKey:@"TodoList" ];
    NSSet * set = [NSSet setWithArray:
                   @[[NSMutableArray class], [TodoClass class]]];
    //arr=(NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:myEncodedObject error:nil];
    
    _arr=[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    
    if(_arr==nil){
        _arr=[NSMutableArray<TodoClass *> new];
    }
    
    todoArray=[NSMutableArray<NSNumber *> new];
    low=[NSMutableArray<NSNumber *> new];
    medium=[NSMutableArray<NSNumber *> new];
    high=[NSMutableArray<NSNumber *> new];
    for (int i=0;i<_arr.count;++i) {
        //NSLog(@"%@",arr[i].State);
        if([_arr[i].State isEqualToNumber:[NSNumber numberWithInt:0 ]]){
            
            //printf("Equla");
            [todoArray addObject:[NSNumber numberWithInt:i]];
            
            if([_arr[i].Priorety isEqualToNumber:[NSNumber numberWithInt: 0]]){
                [low addObject:[NSNumber numberWithInt:i]];
            }
            else if([_arr[i].Priorety isEqualToNumber:[NSNumber numberWithInt: 1]])
            {
                [medium addObject:[NSNumber numberWithInt:i]];
            }
            else if([_arr[i].Priorety isEqualToNumber:[NSNumber numberWithInt: 2]])
            {
                [high addObject:[NSNumber numberWithInt:i]];
            }
        }
    
//        NSLog(@"%@",arr[i].Description);
//        NSLog(@"%@",arr[i].State);
//        NSLog(@"%@",arr[i].Priorety);
//        NSLog(@"%@",arr[i].Date);
//        NSLog(@"%@",arr[i].image);
    }
    search_index = [NSMutableArray<NSNumber*> new];
    if (! [_SearchBar.text isEqualToString:@""]) {
        
        NSMutableString * search_string = [NSMutableString stringWithString: _SearchBar.text];
        
        search_string = [NSMutableString stringWithString:[search_string lowercaseString]];
        

        
        for (int i=0;i<todoArray.count;i++) {
            
            NSString * todo_name = _arr[[todoArray[i] intValue]].Name;
         
            
            if (search_string.length <= todo_name.length) {
                
                if ([search_string isEqualToString:[todo_name substringToIndex:(search_string.length)]]) {
                    
                    [search_index addObject:[NSNumber numberWithInt:[todoArray[i] intValue]]];
                }
                
                
            }
            
        }
        
    }
    
    
    
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(sort){
        switch (section) {
            case 0:
                return @"low Priority";
                break;
            case 1:
                return @"medium Priority";
                break;
            case 2:
                return @"high Priority";
                break;
                
            
        }
    }
    
        return @"Todo List";
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       // printf("Delete1");
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want delete this task?" preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
        
                UIAlertAction* Delete = [UIAlertAction actionWithTitle:@"Delte" style:UISystemAnimationDelete handler:^(UIAlertAction * _Nonnull action) {
                    
                  
                    [self deletee:(int) indexPath.row:(int)indexPath.section];
                   
                        
                    
                }];
            [alert addAction:Cancel];
            [alert addAction:Delete];
        [self presentViewController:alert animated:YES completion:nil];
    }
    //printf("Delete3");
}

-(void )deletee:(int) index:(int)secttion{
    if(sort){
        switch (secttion) {
            case 0:
                [self Load];
                
                for (int i =0 ;i<(int)low.count;i++){
                    if([low[i] integerValue]==index)
                    {
                        index=[low[i] intValue];
                        [low removeObjectAtIndex:i];
                    }
                    
                }
                [self.arr removeObjectAtIndex:index];
                
                [self Save];
                [self Load];
                [self.tableView reloadData];
                break;
            case 1:
                [self Load];
                
                for (int i =0 ;i<(int)medium.count;i++){
                    if([medium[i] integerValue]==index)
                    {
                        index=[medium[i] intValue];
                        [medium removeObjectAtIndex:i];
                    }
                    
                }
                [self.arr removeObjectAtIndex:index];
                
                [self Save];
                [self Load];
                [self.tableView reloadData];
                break;
                
            case 2:
                [self Load];
                
                for (int i =0 ;i<(int)high.count;i++){
                    if([high[i] integerValue]==index)
                    {
                        index=[high[i] intValue];
                        [high removeObjectAtIndex:i];
                    }
                    
                }
                [self.arr removeObjectAtIndex:index];
                
                [self Save];
                [self Load];
                [self.tableView reloadData];
                break;
        }
        
    }
    else{
        [self Load];
        
        for (int i =0 ;i<(int)todoArray.count;i++){
            if([todoArray[i] integerValue]==index)
            {
                [todoArray removeObjectAtIndex:i];
            }
            
        }
        [self.arr removeObjectAtIndex:index];
        
        [self Save];
        [self Load];
        [self.tableView reloadData];
    }
    
}
-(void) Save{
//printf("Entered3");
    NSError * error;
    
    data=[NSKeyedArchiver archivedDataWithRootObject:self.arr];
   // data=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&error];
    
    [defaulte setObject:data forKey:@"TodoList"];
   // [defaulte synchronize];
   
   
}
- (IBAction)sortPressed:(id)sender {
    
    if(sort){
        sort=NO;
    }else{
        sort=YES;
    }
    
    [self.tableView reloadData];
}
@end
