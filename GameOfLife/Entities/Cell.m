//
//  Cell.m
//  GameOfLife
//
//  Created by Yahir Vite Lugardo on 10/25/14.
//  Copyright (c) 2014 Yahir Vite. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id) initWithPositionColumn:(NSInteger)column andRow:(NSInteger)row
{
    self = [super init];
    if(self)
    {
        self.position = [[Position alloc] init];
        self.position.column = column;
        self.position.row = row;
        self.isLocked = NO;
        [self addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) buttonTouched:(id) sender
{
    if(!self.isLocked)
    {
        if(!self.isAlive)
        {
            [self setBackgroundColor:[UIColor blueColor]];
            self.isAlive = YES;
        }
        else
        {
            [self setBackgroundColor:[UIColor clearColor]];
            self.isAlive = NO;
        }
        if([self.delegate respondsToSelector:@selector(cellTouched:)])
            [self.delegate cellTouched:self];
    }
}

- (void)setAlive
{
    [self setBackgroundColor:[UIColor blueColor]];
    self.isAlive = YES;
}

- (void)kill
{
    [self setBackgroundColor:[UIColor clearColor]];
    self.isAlive = NO;
}

@end
