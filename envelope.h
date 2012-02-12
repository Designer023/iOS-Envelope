//
//  envelope.h
//  truelove
//
//  Created by Carl Topham on 12/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface envelope : UIView {
    UIButton *openButton;
    
    UIImageView *envelopeBaseImage, *envelopeTopImage;
   
    UIView *envelopeTopView;
}

@property(nonatomic, retain) UIButton *openButton;
@property(nonatomic, retain) UIImageView *envelopeBaseImage, *envelopeTopImage;
@property(nonatomic, retain) UIView *envelopeTopView;



- (id)initWithFrame:(CGRect)superFrame
           topFrame:(CGRect)topFrame
        bottomFrame:(CGRect)bottomFrame
           topImage:(NSString *)topImage
        bottomImage:(NSString *)bottomImage;

-(IBAction)openEnvelope:(id)sender;
-(void)removeSelfFromView;


- (void)animationDone;

@end
