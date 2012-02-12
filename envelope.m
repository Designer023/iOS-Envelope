//
//  envelope.m
//
//  Created by Carl Topham on 12/02/2012.
//  Copyright (c) 2012. All rights reserved.
//

#import "envelope.h"

//needed for fancy stuff
#import "QuartzCore/QuartzCore.h"

@implementation envelope

@synthesize envelopeTopView, envelopeTopImage, envelopeBaseImage, openButton;

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

- (id)initWithFrame:(CGRect)superFrame
           topFrame:(CGRect)topFrame
        bottomFrame:(CGRect)bottomFrame
           topImage:(NSString *)topImage
        bottomImage:(NSString *)bottomImage
{
    self = [super initWithFrame:superFrame];
    if (self) {
        // Initialization code
        //Top of envelope
        envelopeTopView = [[UIView alloc] initWithFrame:topFrame];
        [envelopeTopView setBackgroundColor:[UIColor clearColor]];
        
        envelopeTopImage = [[UIImageView alloc] initWithFrame:topFrame];
        envelopeTopImage.image = [UIImage imageNamed:topImage];
        
        //bottom of Evelope
        envelopeBaseImage = [[UIImageView alloc] initWithFrame:bottomFrame];
        envelopeBaseImage.image = [UIImage imageNamed:bottomImage];
        
        //button
        openButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [openButton addTarget:self 
                       action:@selector(openEnvelope:)
         forControlEvents:UIControlEventTouchDown];
        
        openButton.frame = superFrame;
        
        //add them to the view stack
        [self addSubview:envelopeBaseImage];
        [self addSubview:envelopeTopView];
        [envelopeTopView addSubview:envelopeTopImage];
        
        [self addSubview:openButton];
    }
    return self;
}


-(void)removeSelfFromView {
    [self removeFromSuperview];
}


-(IBAction)openEnvelope:(id)sender {
    envelopeTopView.layer.zPosition = 1000;
    
    float zDistance = 200.0f;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0f / -zDistance;
    
    envelopeTopView.layer.anchorPoint = CGPointMake(0.5, 0);
    envelopeTopView.center = CGPointMake(160, 0); // set center
    
    
    //PLAY SOUNDS - NEEDS IMPLEMENTING
    //[self playSoundNamed:@"open"];
    
    // Animate to 90 degrees
    [UIView animateWithDuration:1 animations:^{
        
        envelopeTopView.layer.transform = transform;
        envelopeTopView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS( 0 ), 1, 0, 0);
        
        envelopeTopView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS( 180 ), 1, 0, 0);
        
    } 
                     completion:^(BOOL finished){
                         NSValue *firstPoint = [NSValue valueWithCGPoint:CGPointMake(0, 53)];
                         NSValue *secondPoint = [NSValue valueWithCGPoint:CGPointMake(0, 800)];
                         
                         NSArray *points = [NSArray arrayWithObjects:firstPoint, secondPoint, nil];
                         
                         for (NSValue *pointValue in points) {
                             
                             [UIView beginAnimations:@"UIImage Move" context:NULL];
                             [UIView setAnimationDuration:0.7];
                            
                             CGPoint point = [pointValue CGPointValue];
                             CGSize size = envelopeBaseImage.frame.size;
                             
                             envelopeBaseImage.frame = CGRectMake(point.x, point.y, size.width, size.height);
                             
                             [UIView setAnimationDidStopSelector:@selector(revealHasFinished:finished:context:)];
                             [self performSelector:@selector(animationDone) withObject:nil afterDelay:0.7];
                             [UIView setAnimationDelegate:self];
                             [UIView commitAnimations];
                         }
                         
                         
                         
                         
                     }];
    [openButton setHidden:TRUE];
}

- (void)animationDone
{
        [self removeSelfFromView];
}

@end
