//
//  DoubleSidedView.m
//  DoubleSidedView
//
//  Created by devmac46  on 28/02/13.
//  Copyright (c) 2013 devmac46 . All rights reserved.
//

#import "DoubleSidedView.h"
#import <QuartzCore/QuartzCore.h>

#define animationDuration 2.0
#define zDistance 400.0

@interface DoubleSidedView()

@property (nonatomic,strong) CATransformLayer *doubleSidedLayer;
@property (nonatomic,strong) CALayer *topLayer;
@property (nonatomic,strong) CALayer *bottomLayer;

@property (nonatomic,assign) BOOL isFlipped;

-(void)printFrame:(CALayer *)layer withMessage:(NSString*)message;
@end

@implementation DoubleSidedView

@synthesize topLayer,bottomLayer,isFlipped;
@synthesize doubleSidedLayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [self initWithFrame:frame frontImage:nil backImage:nil];
        
    }
    return self;
}

/*-(id)initWithFrame:(CGRect)frame frontImage:(NSString*)frontImageName backImage:(NSString *)backImageName
{
    NSLog(@"Passed frame = %f %f %f %f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    CGRect containerFrame = CGRectMake(frame.origin.x - frame.size.width,
                                       frame.origin.y,
                                       frame.size.width*2,
                                       frame.size.height);

    NSLog(@"container frame = %f %f %f %f",containerFrame.origin.x,containerFrame.origin.y,containerFrame.size.width,containerFrame.size.height);
    self = [super initWithFrame:containerFrame];
    [self printFrame:self.layer withMessage:@"self"];
    CGRect doubleLayerFrame = CGRectMake(containerFrame.size.width/2,0,containerFrame.size.width/2,frame.size.height);
    
//    CGRect doubleLayerFrame = CGRectMake(0,0,containerFrame.size.width,frame.size.height);
//    CGRect imageLayerFrame = CGRectMake(0,0,containerFrame.size.width,frame.size.height);
    self.backgroundColor = [UIColor grayColor];
        
        //Configuring doubleSidedLayer
        self.doubleSidedLayer  = [CATransformLayer layer];
        [self.doubleSidedLayer setFrame:doubleLayerFrame];
        [self printFrame:self.doubleSidedLayer withMessage:@"DoublesidedLayer"];
        [self printBounds:self.doubleSidedLayer withMessage:@"DoublesidedLayer"];
        NSLog(@"Anchor Points = %f %f",self.doubleSidedLayer.anchorPoint.x, self.doubleSidedLayer.anchorPoint.y);
        NSLog(@"position = %f %f",self.doubleSidedLayer.position.x,self.doubleSidedLayer.position.y);
        
        [self.doubleSidedLayer setAnchorPoint:CGPointMake(0, 0.5)];
        [self.doubleSidedLayer setPosition:CGPointMake(self.doubleSidedLayer.position.x+self.doubleSidedLayer.bounds.size.width*(self.doubleSidedLayer.anchorPoint.x-0.5),self.doubleSidedLayer.position.y+self.doubleSidedLayer.bounds.size.height*(self.doubleSidedLayer.anchorPoint.y-0.5))];
    
        //Configuring top layer
        topLayer = [[CALayer alloc]init];
        [self.topLayer setFrame:doubleSidedLayer.bounds];
        [self.topLayer setContents:(id)[UIImage imageNamed:frontImageName].CGImage];
        [self.topLayer setZPosition:2];
        [self.topLayer setDoubleSided:NO];
        
        //Configuring bottom layer
        bottomLayer = [[CALayer alloc]init];
        [self.bottomLayer setFrame:doubleSidedLayer.bounds];
        [self.bottomLayer setContents:(id)[UIImage imageNamed:backImageName].CGImage];
        [self.bottomLayer setZPosition:1];
        
        [self.doubleSidedLayer addSublayer:topLayer];
        [self.doubleSidedLayer addSublayer:bottomLayer];
        [self.layer addSublayer:doubleSidedLayer];
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(turn:)];
        [self addGestureRecognizer:tap];
        isFlipped = NO;
        return self;
    
}*/

-(id)initWithFrame:(CGRect)frame frontImage:(NSString*)frontImageName backImage:(NSString *)backImageName
{
    CGRect containerFrame = CGRectMake(frame.origin.x - frame.size.width,
                                       frame.origin.y,
                                       frame.size.width*2,
                                       frame.size.height);
    
    self = [super initWithFrame:containerFrame];
    self.backgroundColor = [UIColor clearColor];
    
    //Configuring doubleSidedLayer
    self.doubleSidedLayer  = [CATransformLayer layer];
    [self.doubleSidedLayer setFrame:frame];
    
    //Set the anchor point to the left side of the layer
    [self.doubleSidedLayer setAnchorPoint:CGPointMake(0, 0.5)];
    [self.doubleSidedLayer setPosition:CGPointMake
                                    (self.doubleSidedLayer.position.x+
                                     self.doubleSidedLayer.bounds.size.width*(self.doubleSidedLayer.anchorPoint.x-0.5),
                                     self.doubleSidedLayer.position.y+
                                     self.doubleSidedLayer.bounds.size.height*(self.doubleSidedLayer.anchorPoint.y-0.5))];
    
    //Configuring top layer
    topLayer = [[CALayer alloc]init];
    [self.topLayer setFrame:doubleSidedLayer.bounds];
    [self.topLayer setContents:(id)[UIImage imageNamed:frontImageName].CGImage];
    [self.topLayer setZPosition:2];
    [self.topLayer setDoubleSided:NO];
    
    //Configuring bottom layer
    bottomLayer = [[CALayer alloc]init];
    [self.bottomLayer setFrame:doubleSidedLayer.bounds];
    [self.bottomLayer setContents:(id)[UIImage imageNamed:backImageName].CGImage];
    [self.bottomLayer setZPosition:1];
    
    [self.doubleSidedLayer addSublayer:topLayer];
    [self.doubleSidedLayer addSublayer:bottomLayer];
    [self.layer addSublayer:doubleSidedLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(turn:)];
    [self addGestureRecognizer:tap];
    isFlipped = NO;
    return self;
}


-(void) turn:(UIGestureRecognizer*) gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:self];
    //Flipping the transform layer
    if([self.topLayer containsPoint:[self.topLayer
                                     convertPoint:touchPoint
                                        fromLayer:self.layer]])
    {
        [CATransaction setCompletionBlock:^
         {
             if(self.isFlipped)
                 [self.delegate viewDidTurnedLeft];
             else
                 [self.delegate viewDidTurnedRight];
         }];
        [CATransaction begin];
        [CATransaction setAnimationDuration:animationDuration];
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = 1.0 / -zDistance;
        
        self.doubleSidedLayer.transform = perspective;
        if(!isFlipped)
        {
            [ self.doubleSidedLayer setSublayerTransform :CATransform3DMakeRotation(M_PI, 0, 1, 0)];
        }
        else
            [ self.doubleSidedLayer setSublayerTransform :CATransform3DMakeRotation(0, 0, 1, 0)];
        [CATransaction commit];
    }
    isFlipped = !isFlipped;
}


-(void)printFrame:(CALayer *)layer withMessage:(NSString*)message
{
    NSLog(@"%@ frame = %f %f %f %f",message,layer.frame.origin.x,layer.frame.origin.y,layer.frame.size.width,layer.frame.size.height);
}

-(void)printBounds:(CALayer *)layer withMessage:(NSString*)message
{
    NSLog(@"%@ bounds = %f %f %f %f",message,layer.bounds.origin.x,layer.bounds.origin.y,layer.bounds.size.width,layer.bounds.size.height);
}
@end

