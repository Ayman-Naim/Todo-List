//
//  CreateViewController.h
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import "ViewController.h"
#import "TodoClass.h"
NS_ASSUME_NONNULL_BEGIN

@interface CreateViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Description;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Priorety;
@property (weak, nonatomic) IBOutlet UISegmentedControl *State;
@property (weak, nonatomic) IBOutlet UIDatePicker *Date;
- (IBAction)AddClicked:(id)sender;


@end

NS_ASSUME_NONNULL_END
