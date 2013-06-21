//
//  ViewController.m
//  DoubleSidedView
//
//  Created by devmac46  on 28/02/13.
//  Copyright (c) 2013 devmac46 . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //    CGRect coverFrame = CGRectMake(0,0, self.view.bounds.size.height/2 -5, self.view.frame.size.width);
    
//    NSLog(@"parent frame = %f %f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
//    NSLog(@"parent bound = %f %f %f %f",self.view.bounds.origin.x,self.view.bounds.origin.y,self.view.bounds.size.width,self.view.bounds.size.height);
//    float offsetX = 10;
    float offsetY = 0;
    CGRect coverFrame = CGRectMake(self.view.frame.size.height/2,offsetY , self.view.frame.size.height/2 , self.view.frame.size.width);
    DoubleSidedView *secondaryView = [[DoubleSidedView alloc]initWithFrame:coverFrame frontImage:@"1.png" backImage:@"2.png"];
    [self.view addSubview:secondaryView];
    
    secondaryView.delegate = self;

}

-(void)viewDidTurnedLeft
{}

-(void)viewDidTurnedRight
{}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
