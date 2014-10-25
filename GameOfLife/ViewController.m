//
//  ViewController.m
//  GameOfLife
//
//  Created by Yahir Vite Lugardo on 10/25/14.
//  Copyright (c) 2014 Yahir Vite. All rights reserved.
//

#import "ViewController.h"
#import "Matrix.h"

@interface ViewController ()
{
    Matrix *matrix;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    matrix = [[Matrix alloc] initOnView:viewMatrix];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonClearMatrixTouchUpInside:(id)sender {
    [matrix clearMatrix];
}

- (IBAction)buttonStopLifeTouchUpInside:(id)sender {
    [matrix killMatrix];
    [buttonStartLife setEnabled:YES];
    [buttonClearMatrix setHidden:NO];
}

- (IBAction)buttonStartLifeTouchUpInside:(id)sender {
    [matrix startLife];
    [buttonStartLife setEnabled:NO];
    [buttonClearMatrix setHidden:YES];
}
@end
