//
//  TodoClass.m
//  TodoList
//
//  Created by ayman on 30/08/2023.
//

#import "TodoClass.h"

@implementation TodoClass
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.Description forKey:@"Description"];
    [encoder encodeObject:self.Priorety forKey:@"Priorety"];
    [encoder encodeObject:self.image forKey:@"image"];
    [encoder encodeObject:self.Date forKey:@"Date"];
    [encoder encodeObject:self.State forKey:@"State"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.Name = [decoder decodeObjectForKey:@"Name"];
        self.Description = [decoder decodeObjectForKey:@"Description"];
        self.Priorety = [decoder decodeObjectForKey:@"Priorety"];
        self.image = [decoder decodeObjectForKey:@"image"];
        self.Date = [decoder decodeObjectForKey:@"Date"];
        self.State = [decoder decodeObjectForKey:@"State"];
      
    }
    return self;
}
- (id)init:(NSString *)name withDescription:(NSString *)description withState:(NSNumber *)State andPriorety:(NSNumber *)priorety andDate:(NSDate *)date andImage:(NSString *)image{
    self=[super init];
    self.Name=name;
    self.Description=description;
    self.Priorety=priorety;
    self.image=image;
    self.Date=date;
    self.State=State;
    return  self;
    
}
@end
