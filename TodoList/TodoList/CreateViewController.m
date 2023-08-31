//
//  CreateViewController.m
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import "CreateViewController.h"

@interface CreateViewController ()
{
    NSString * image_string;
    NSData *data;
    NSUserDefaults *defaulte ;
    NSMutableArray<TodoClass*> * arr;
    
}
@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Load];

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)AddClicked:(id)sender {
    printf("Entered1");
    if(_Priorety.selectedSegmentIndex==0){
        image_string=[NSString new];
        image_string=@"speaker.badge.exclamationmark";
    }
    else if(_Priorety.selectedSegmentIndex==1){
        image_string=@"exclamationmark";
    }
    else{
        image_string=@"exclamationmark.triangle";
    }
    TodoClass *todo =[[TodoClass alloc] init:_Name.text withDescription:_Description.text withState:[ NSNumber numberWithInteger:_State.selectedSegmentIndex] andPriorety:[ NSNumber numberWithInteger:_Priorety.selectedSegmentIndex] andDate:_Date.date andImage:image_string];
    [arr addObject:todo];
    
    
    
    [self Save];
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
    
    
}
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
    for (int i=0;i<arr.count;++i) {
       
        NSLog(@"%@", arr[i].Name);
       /* printf("\n");
        NSLog(@"%@",arr[i].Description);
        printf("\n");
        NSLog(@"%@",arr[i].State);
        printf("\n");
        NSLog(@"%@",arr[i].Priorety);
        printf("\n");
        NSLog(@"%@",arr[i].Date);
        printf("\n");
        NSLog(@"%@",arr[i].image);*/
    }
}
-(void) Save{
//printf("Entered3");
    NSError * error;
    
    data=[NSKeyedArchiver archivedDataWithRootObject:arr];
   // data=[NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:&error];
    
    [defaulte setObject:data forKey:@"TodoList"];
   // [defaulte synchronize];
   
}
@end
