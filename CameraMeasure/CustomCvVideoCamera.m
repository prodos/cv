//
//  CustomCvVideoCamera.m
//  CameraMeasure
//
//  Created by Roberto Miranda on 27.05.13.
//  Copyright (c) 2013 Roberto Miranda. All rights reserved.
//

#import "CustomCvVideoCamera.h"

@implementation CustomCvVideoCamera

- (void)updateOrientation {
    // nop
}

- (void)layoutPreviewLayer {
    if (self.parentView != nil) {
        CALayer* layer = customPreviewLayer;
        CGRect bounds = customPreviewLayer.bounds;
        layer.position = CGPointMake(self.parentView.frame.size.width/2., self.parentView.frame.size.height/2.);
        layer.bounds = bounds;
    }
}

@end
