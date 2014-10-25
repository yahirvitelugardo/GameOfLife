//
//  ViewController.h
//  GameOfLife
//
//  Created by Yahir Vite Lugardo on 10/25/14.
//  Copyright (c) 2014 Yahir Vite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
    IBOutlet UIView *viewMatrix;
    IBOutlet UIButton *buttonStartLife;
    IBOutlet UIButton *buttonStopLife;
    IBOutlet UIButton *buttonClearMatrix;
}
- (IBAction)buttonClearMatrixTouchUpInside:(id)sender;
- (IBAction)buttonStopLifeTouchUpInside:(id)sender;
- (IBAction)buttonStartLifeTouchUpInside:(id)sender;
@end
