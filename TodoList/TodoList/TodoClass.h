//
//  TodoClass.h
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoClass : NSObject<NSCoding>
@property NSString *Name ,*Description;
@property NSNumber *Priorety,*State;
@property NSDate *Date;
@property NSString *image;

-(void)encodeWithCoder:(NSCoder *)encoder ;
- (id)initWithCoder:(NSCoder *)decoder;
-(id)init:(NSString*)name withDescription:(NSString*)description withState:(NSNumber*)State andPriorety:(NSNumber*) priorety andDate:(NSDate*)date andImage:(NSString*)image;
@end

NS_ASSUME_NONNULL_END
