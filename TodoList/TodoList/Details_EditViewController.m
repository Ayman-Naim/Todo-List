//
//  Details_EditViewController.m
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import "Details_EditViewController.h"
#import "TodoClass.h"
@interface Details_EditViewController (){
    NSString * image_string;
    NSData *data;
    NSUserDefaults *defaulte ;
    NSMutableArray<TodoClass*> * arr;
    NSMutableArray<NSNumber*> * todoArray;
    NSMutableArray<NSNumber*> * progress;
    NSMutableArray<NSNumber*> * done;
}
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Description;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *state;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end

@implementation Details_EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Load];
    _date.backgroundColor=[UIColor whiteColor];
    if(_From_page==1){
        _state.selected=0;
        
    }
    else if(_From_page==2){
        [_state setEnabled:NO forSegmentAtIndex:0 ];
        
    }
    else if(_From_page==3){
        [_state setEnabled:NO forSegmentAtIndex:0 ];
        [_state setEnabled:NO forSegmentAtIndex:1 ];
    }
    
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    
   // [arr removeAllObjects ];
    //[todoArray removeAllObjects];
    _date.backgroundColor=[UIColor whiteColor];
    [self Load];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) Load{
    NSError * error;
    
    // printf("Entered0");
    defaulte=[NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject ; myEncodedObject = [defaulte objectForKey:@"TodoList" ];
    NSSet * set = [NSSet setWithArray:
                   @[[NSMutableArray class], [TodoClass class]]];
    //arr=(NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:myEncodedObject error:&error];
    arr=[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    if(arr==nil){
        arr=[NSMutableArray<TodoClass *> new];
    }
    //todo
    todoArray=[NSMutableArray<NSNumber *> new];
    progress=[NSMutableArray<NSNumber *> new];
    
    done=[NSMutableArray<NSNumber *> new];
    for (int i=0;i<arr.count;++i) {
        //NSLog(@"%@",arr[i].State);
        if([arr[i].State isEqualToNumber:[NSNumber numberWithInt:0 ]]){
         
            
            [todoArray addObject:[NSNumber numberWithInt:i]];
        }
        if([arr[i].State isEqualToNumber:[NSNumber numberWithInt:1 ]]){
         
            
            [progress addObject:[NSNumber numberWithInt:i]];
        }
        if([arr[i].State isEqualToNumber:[NSNumber numberWithInt:2 ]]){
         
            
            [done addObject:[NSNumber numberWithInt:i]];
        }
        
    }
    if(_From_page==0){
       _index= [todoArray[_index] intValue ];
    }
    else if (_From_page==1){
        _index= [progress[_index] intValue ];
    }
    

        _Name.text=arr[_index].Name;
        _Description.text=arr[_index].Description;
        _priority.selectedSegmentIndex=[arr[_index].Priorety integerValue];
        _state.selectedSegmentIndex=[arr[_index].State integerValue];
        _date.date=arr[_index].Date;
    [_priority setEnabled:YES forSegmentAtIndex:[arr[_index].Priorety integerValue]];
    [_state setEnabled:YES forSegmentAtIndex:[arr[_index].State integerValue]];
    self.From_page=-1;
    
}
-(void) Save{
//printf("Entered3");
    NSError * error;
    
    data=[NSKeyedArchiver archivedDataWithRootObject:arr];
   // data=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&error];
    
    [defaulte setObject:data forKey:@"TodoList"];
   // [defaulte synchronize];
   
}
-(void)Edit{
    TodoClass * edited=[TodoClass new];
    edited.Name=_Name.text;
    edited.Description=_Description.text;
    edited.Priorety=[NSNumber numberWithInteger: _priority.selectedSegmentIndex];
    edited.State=[NSNumber numberWithInteger: _state.selectedSegmentIndex];
    edited.Date=_date.date;
    image_string=[NSString new];
    if(_priority.selectedSegmentIndex==0){
       
        image_string=@"speaker.badge.exclamationmark";
    }
    else if(_priority.selectedSegmentIndex==1){
        image_string=@"exclamationmark";
    }
    else{
        image_string=@"exclamationmark.triangle";
    }
    edited.image=image_string;
    arr[_index]=edited;
    [self Save];
    
}
- (IBAction)EditButtonClicked:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Edit" message:@"Are you sure you want edit this task?" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction* Edit = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self Edit];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
     
        
 
    
    
    
    [self Edit];
    
    
    [alert addAction:Cancel];
    [alert addAction:Edit];
    [self presentViewController:alert animated:YES completion:nil];
    
   
    
}

@end
