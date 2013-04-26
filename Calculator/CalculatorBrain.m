//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Tarik Djebien on 24/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *) programStack {
    if(!_programStack) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (void) pushOperand:(double) operand {
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.programStack addObject:operandObject];
}

- (double) performOperation:(NSString *) operation 
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id) program 
{    
    return [self.programStack copy];
}

+ (double) popOperandOffStack:(NSMutableArray *) stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    if([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]){
        
        NSString *operation = topOfStack;
        
        if([operation isEqualToString:@"+"]){
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]){
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"-" isEqualToString:operation]){
            result = - [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"/" isEqualToString:operation]){
            double divisor = [self popOperandOffStack:stack];
            if(divisor) result = [self popOperandOffStack:stack ] / divisor;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

+ (NSString *) buildDescriptionProgram:(NSMutableArray *) stack
               descriptionProgram:(NSString *)description
{
    id topOfStack = [stack lastObject];
    if(topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        description = [[topOfStack stringValue] stringByAppendingString:description];
    } else if ([topOfStack isKindOfClass:[NSString class]]){
        NSString *operation = topOfStack;
        
        if([operation isEqualToString:@"+"]){
            description = [NSString stringWithFormat:@"%@%@%@%@%@",@"(",[self buildDescriptionProgram:stack descriptionProgram:description],@"+",[self buildDescriptionProgram:stack descriptionProgram:description],@")"];
        } else if ([@"*" isEqualToString:operation]){
            description = [NSString stringWithFormat:@"%@%@%@",[self buildDescriptionProgram:stack descriptionProgram:description],@"*",[self buildDescriptionProgram:stack descriptionProgram:description]];
        } else if ([@"-" isEqualToString:operation]){
            NSString *operande1 = [self buildDescriptionProgram:stack descriptionProgram:description];
            NSString *operande2 = [self buildDescriptionProgram:stack descriptionProgram:description];
            description = [NSString stringWithFormat:@"%@%@%@%@%@",@"(",operande2,@"-",operande1,@")"];
        } else if ([@"/" isEqualToString:operation]){
            NSString *operande1 = [self buildDescriptionProgram:stack descriptionProgram:description];
            NSString *operande2 = [self buildDescriptionProgram:stack descriptionProgram:description];
            description = [NSString stringWithFormat:@"%@%@%@",operande2,@"/",operande1];
        }
    }
    
    return description;
}

+ (NSString *)descriptionOfProgram:(id)program
{
    
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    
    return [NSString stringWithFormat:@"Description du programme : \n %@",[self buildDescriptionProgram:stack descriptionProgram:@""]];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"stack = %@",self.programStack];
}

@end
