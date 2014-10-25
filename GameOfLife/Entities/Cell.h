//
//  Cell.h
//  GameOfLife
//
//  Created by Yahir Vite Lugardo on 10/25/14.
//  Copyright (c) 2014 Yahir Vite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Position.h"

@class Cell;

@protocol CellDelegate <NSObject>

@optional
- (void) cellTouched:(Cell *) touchedCell;

@end

@interface Cell : UIButton

@property BOOL isAlive;
@property BOOL isLocked;
@property (nonatomic, retain) Position *position;
@property (nonatomic, retain) id<CellDelegate> delegate;

- (id) initWithPositionColumn:(NSInteger)column andRow:(NSInteger)row;
- (void) setAlive;
- (void) kill;

@end
