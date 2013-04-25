//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Tarik Djebien on 24/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double) operand;
- (double) performOperation:(NSString *)operation;

@property (readonly) id program;

+ (double) runProgram:(id)program;
+ (NSString *) descriptionOfProgram:(id)program;

@end
