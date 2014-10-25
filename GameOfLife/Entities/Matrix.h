//
//  Matrix.h
//  GameOfLife
//
//  Created by Yahir Vite Lugardo on 10/25/14.
//  Copyright (c) 2014 Yahir Vite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "Constants.h"

@interface Matrix : NSObject
{
    Cell *matrix[matrixWidth][matrixHeight];
}

- (id) initOnView:(UIView *)view;
- (void) killMatrix;
- (void) startLife;
- (void) clearMatrix;

@end
