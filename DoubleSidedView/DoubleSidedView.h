//
//  DoubleSidedView.h
//  DoubleSidedView
//
//  Created by devmac46  on 28/02/13.
//  Copyright (c) 2013 devmac46 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol DoubleSidedViewDelegate

@optional
-(void) viewDidTurnedLeft;
-(void) viewDidTurnedRight;

@end

@interface DoubleSidedView : UIView

@property (nonatomic,weak) id <DoubleSidedViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame frontImage:(NSString*)frontImageName backImage:(NSString *)backImageName;

@end





