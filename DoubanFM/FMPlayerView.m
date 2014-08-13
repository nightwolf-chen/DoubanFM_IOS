//
//  FMPlayerView.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-13.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMPlayerView.h"

typedef enum FMPlayerViewStatus {
    FMPlayerViewStatusBig,
    FMPlayerViewStatusSmall,
    FMPlayerViewStatusMoving
}FMPlayerViewStatus;

@interface FMPlayerView ()
{
    CGPoint _bOrigin;
    CGPoint _sOrigin;
    float _sHeight;
    FMPlayerViewStatus _status;
}

@property (nonatomic,assign) FMPlayerViewStatus status;
@end

@implementation FMPlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sHeight = 60;
        _bOrigin = frame.origin;
        _sOrigin = CGPointMake(0, SCREEN_SIZE.height - _sHeight);
        _status = FMPlayerViewStatusBig;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (_status) {
        case FMPlayerViewStatusBig:
        {
            
        }
            break;
            
        case FMPlayerViewStatusSmall:
        {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 CGRect frame = self.frame;
                                 frame = CGRectMake(_bOrigin.x,_bOrigin.y, frame.size.width, frame.size.height);
                                 self.frame = frame;
                             }
                             completion:^(BOOL isSuccess){
                                 
                             }];
        }
            break;
        case FMPlayerViewStatusMoving:
        {
            //Do nothing.
        }
            break;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
