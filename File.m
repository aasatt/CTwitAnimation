//
//  File.m
//
//  Created by Aaron Satterfield on 7/20/14.
//
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


/// In your view did load


UIImageView *greenplaceholder = [[UIImageView alloc] initWithFrame:self.window.frame];
greenplaceholder.image = [UIImage imageNamed:@"greensquare.png"];
[self.window addSubview:greenplaceholder];

UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.window.frame];
imageview.image = [UIImage imageNamed:@"splashscreenloader.png"];
[self.window insertSubview:imageview aboveSubview:greenplaceholder];
[self.window addSubview:imageview];

CALayer *mask = [CALayer layer];
mask.contents = (id)[[UIImage imageNamed:@"user.png"] CGImage];
// mask.frame = CGRectMake((imageview.frame.size.width/2)-35, (imageview.frame.size.height/2)-35, 70, 70);
mask.bounds = CGRectMake(0, 0, 70, 70);
mask.anchorPoint = CGPointMake(.5, .5);
mask.position = CGPointMake(imageview.frame.size.width/2, imageview.frame.size.height/2);
imageview.layer.mask = mask;
imageview.layer.masksToBounds = YES;


[CATransaction begin]; {
    [CATransaction setCompletionBlock:^{
        [greenplaceholder removeFromSuperview];
        [imageview removeFromSuperview];
        
    }];
    CAKeyframeAnimation *keyframanimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    keyframanimation.duration = 1;
    keyframanimation.timingFunctions =  [[NSArray alloc] initWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    CGRect initalbounds = CGRectMake(0, 0, 70, 70);
    CGRect secondbounds = CGRectMake(0, 0, 50, 50);
    CGRect finalbounds = CGRectMake(0, 0, 1800, 1800);
    keyframanimation.values = [[NSArray alloc] initWithObjects:[NSValue valueWithCGRect:initalbounds],[NSValue valueWithCGRect:secondbounds],[NSValue valueWithCGRect:finalbounds], nil];
    keyframanimation.keyTimes = @[@0,@.3,@1];
    [imageview.layer.mask addAnimation:keyframanimation forKey:@"bounds"];
    imageview.layer.mask.bounds = CGRectMake(0, 0, 1800, 1800);
} [CATransaction commit];