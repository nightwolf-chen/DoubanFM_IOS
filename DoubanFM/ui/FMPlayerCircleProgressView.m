//
//  FMPlayerCircleProgressView.m
//  DoubanFM
//
//  Created by nirvawolf on 7/9/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayerCircleProgressView.h"

@implementation FMPlayerCircleProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _lineWidth = 5.0f;
        _percent = 0.0f;
        _buttonAttachedTo = [[UIButton alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (id)initWithUIButton:(UIButton *)button
{
    if (self = [self initWithFrame:CGRectZero]) {
        _buttonAttachedTo = [button retain];
        [_buttonAttachedTo addObserver:self
                            forKeyPath:NSStringFromSelector(@selector(frame))
                               options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                               context:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [_buttonAttachedTo removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame))];
    SAFE_DELETE(_buttonAttachedTo);
    [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGPoint arcCenter = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0f);
    CGFloat arcRaduis = (rect.size.width - 2*_lineWidth + _lineWidth) / 2.0f;
   
    [self drawCircle:arcCenter
              raduis:arcRaduis
             percent:100
               width:_lineWidth
               color:[UIColor whiteColor]];
    
    [self drawCircle:arcCenter
              raduis:arcRaduis
             percent:_percent
               width:_lineWidth
               color:[UIColor greenColor]];
    
    
}


static inline double radians (double degrees) { return degrees * M_PI/180; }

- (void) drawCircle:(CGPoint)center raduis:(CGFloat)raduis percent:(CGFloat)percent width:(CGFloat)width color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat arcRadius = raduis;
    CGPoint arcCenter = center;
    CGFloat startAngle = - radians(90);
    CGFloat endAngle = startAngle + (radians(360) * percent * 0.01);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, arcCenter.x, arcCenter.y, arcRadius, startAngle, endAngle, 0);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetLineWidth(context, width);
    
    CGContextAddPath(context, path);
    
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))]){
        
        CGRect newFrame = CGRectZero;
        if (change[@"new"]) {
            newFrame = [change[@"new"] CGRectValue];
        }
        
        newFrame.size.height += _lineWidth*2;
        newFrame.size.width += _lineWidth*2;
        newFrame.origin.x -= _lineWidth;
        newFrame.origin.y -= _lineWidth;
        self.frame = newFrame;
        [self setNeedsDisplay];
        
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}
@end
