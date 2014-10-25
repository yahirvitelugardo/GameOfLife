//
//  Matrix.m
//  GameOfLife
//
//  Created by Yahir Vite Lugardo on 10/25/14.
//  Copyright (c) 2014 Yahir Vite. All rights reserved.
//

#import "Matrix.h"
#import "Cell.h"
#import "Constants.h"

@interface Matrix()
{
    BOOL isMatrixLive;
    UIView *cview;
    NSTimer *timer;
}

@end

@implementation Matrix

//Constructor
- (id) initOnView:(UIView *)view
{
    self = [super init];
    if(self)
    {
        for(int rowIndex = 0; rowIndex < matrixHeight; rowIndex ++)
        {
            for(int columnIndex = 0; columnIndex < matrixWidth; columnIndex ++)
            {
                Cell *cell = [[Cell alloc] initWithPositionColumn:columnIndex andRow:rowIndex];
                matrix[columnIndex][rowIndex] = cell;
            }
        }
        [self drawMatrixOnView:view];
    }
    return self;
}

//Draws the matrix cells on a specified view
- (void) drawMatrixOnView:(UIView *)view
{
    cview = view;
    CGFloat cellWidth = view.frame.size.width / matrixWidth;
    CGFloat cellHeight = view.frame.size.height / matrixHeight;
    for(int rowIndex = 0; rowIndex < matrixHeight; rowIndex ++)
    {
        for(int columnIndex = 0; columnIndex < matrixWidth; columnIndex ++)
        {
            Cell *cell = matrix[columnIndex][rowIndex];
            [view addSubview:cell];
            [cell setFrame:CGRectMake(columnIndex * cellWidth, rowIndex * cellHeight, cellWidth, cellHeight)];
        }
    }
}

//Stops "life" in the matrix
- (void) killMatrix
{
    isMatrixLive = NO;
    for(int rowIndex = 0; rowIndex < matrixHeight; rowIndex ++)
    {
        for(int columnIndex = 0; columnIndex < matrixWidth; columnIndex ++)
        {
            Cell *cell = matrix[columnIndex][rowIndex];
            [cell setIsLocked:NO];
        }
    }
    [timer invalidate];
    timer = nil;
}

//Starts "life" in the matrix
- (void) startLife
{
    isMatrixLive = YES;
    timer = [NSTimer scheduledTimerWithTimeInterval:cycleInterval
                                     target:self
                                   selector:@selector(checkMatrix)
                                   userInfo:nil
                                    repeats:YES];
}

//Kills all the cells on the matrix
- (void)clearMatrix
{
    for(int rowIndex = 0; rowIndex < matrixHeight; rowIndex ++)
    {
        for(int columnIndex = 0; columnIndex < matrixWidth; columnIndex ++)
        {
            Cell *cell = matrix[columnIndex][rowIndex];
            [cell kill];
        }
    }
}

//Check the cells on the matrix for each life cycle
- (void) checkMatrix
{
    [self performSelectorOnMainThread:@selector(redrawMatrix) withObject:nil waitUntilDone:YES];
}

//Redraws all the cells on the matrix, blue are the alive ones otherwise are clear color
- (void) redrawMatrix
{
    for(int rowIndex = 0; rowIndex < matrixHeight; rowIndex ++)
    {
        for(int columnIndex = 0; columnIndex < matrixWidth; columnIndex ++)
        {
            Cell *cell = matrix[columnIndex][rowIndex];
            [self performSelectorOnMainThread:@selector(redrawCell:) withObject:cell waitUntilDone:YES];
        }
    }
}

//Redraws a specified cell
- (void) redrawCell:(Cell *) cell
{
    [cell setIsLocked:YES];
    if([self willCellBeAlive:cell])
        [cell setAlive];
    else
        [cell kill];
}

//Gets the new state for a specified cell returns YES when the cell must be alive otherwise NO
- (BOOL) willCellBeAlive:(Cell *)cell
{
    int aliveAroundCells = 0;
    if([self isLeftAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if([self isLeftUpAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if([self isUpAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if([self isRightUpAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if([self isRightAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if([self isRightDownAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if([self isDownAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if([self isLeftDownAliveFromPositionX:cell.position.column andPositionY:cell.position.row])
        aliveAroundCells += 1;
    if(aliveAroundCells == 3)
        return YES;
    else if(aliveAroundCells == 2)
        return cell.isAlive;
    else
        return NO;
}


#pragma mark Check cell positions

- (BOOL) isLeftAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionX == 0)
    {
        return NO;
    }
    else
    {
        if (((Cell *)matrix[positionX - 1][positionY]).isAlive)
            return YES;
        else
            return NO;
    }
}

- (BOOL) isLeftUpAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionX == 0)
    {
        return NO;
    }
    else
    {
        if(positionY == 0)
        {
            return NO;
        }
        else
        {
            if (((Cell *)matrix[positionX - 1][positionY - 1]).isAlive)
                return YES;
            else
                return NO;
        }
    }
}

- (BOOL) isUpAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionY == 0)
    {
        return NO;
    }
    else
    {
        if (((Cell *)matrix[positionX][positionY - 1]).isAlive)
            return YES;
        else
            return NO;
    }
}

- (BOOL) isRightUpAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionX == matrixWidth - 1)
    {
        return NO;
    }
    else
    {
        if(positionY == 0)
        {
            return NO;
        }
        else
        {
            if (((Cell *)matrix[positionX + 1][positionY - 1]).isAlive)
                return YES;
            else
                return NO;
        }
    }
}

- (BOOL) isRightAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionX == matrixWidth - 1)
    {
        return NO;
    }
    else
    {
        if (((Cell *)matrix[positionX + 1][positionY]).isAlive)
            return YES;
        else
            return NO;
    }
}

- (BOOL) isRightDownAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionX == matrixWidth - 1)
    {
        return NO;
    }
    else
    {
        if(positionY == matrixHeight - 1)
        {
            return NO;
        }
        else
        {
            if (((Cell *)matrix[positionX + 1][positionY + 1]).isAlive)
                return YES;
            else
                return NO;
        }
    }
}

- (BOOL) isDownAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionY == matrixHeight - 1)
    {
        return NO;
    }
    else
    {
        if (((Cell *)matrix[positionX][positionY + 1]).isAlive)
            return YES;
        else
            return NO;
    }
}

- (BOOL) isLeftDownAliveFromPositionX:(NSInteger)positionX andPositionY:(NSInteger)positionY
{
    if(positionX == 0)
    {
        return NO;
    }
    else
    {
        if(positionY == matrixHeight - 1)
        {
            return NO;
        }
        else
        {
            if (((Cell *)matrix[positionX - 1][positionY + 1]).isAlive)
                return YES;
            else
                return NO;
        }
    }
}

@end
