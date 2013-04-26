//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Tarik Djebien on 24/04/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize displayProgram = _displayProgram;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain*) brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = sender.currentTitle;
    if(self.userIsInTheMiddleOfEnteringANumber){
        self.display.text = [self.display.text stringByAppendingString:digit];
    }else{
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}
- (IBAction)pressEnter {
    double digitValue = [self.display.text doubleValue];
    [self.brain pushOperand:digitValue];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *) sender {
    
    if(self.userIsInTheMiddleOfEnteringANumber) [self pressEnter];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}

@end
