//
//  CamViewController.h
//  CameraMeasure
//
//  Created by Roberto Miranda on 27.05.13.
//  Copyright (c) 2013 Roberto Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>
using namespace cv;

@interface CamViewController : UIViewController

- (IBAction)actionStart:(id)sender;

#ifdef __cplusplus
- (void)processImage:(Mat&)image;
#endif

@end
