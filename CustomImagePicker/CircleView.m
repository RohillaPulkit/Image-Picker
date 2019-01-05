//
//  CircleView.m
//  CustomImagePicker
//
//  Created by Pulkit Rohilla on 20/04/16.
//  Copyright © 2016 PulkitRohilla. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView{
    
    UIColor *fColor,*bColor;
}

const static CGFloat innerMargin = 0;
const static CGFloat lineWidth = 1;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
    CGRect innerRect = CGRectMake(rect.origin.x + (innerMargin/2 - lineWidth), rect.origin.y + (innerMargin/2 - lineWidth), rect.size.width - innerMargin, rect.size.height - innerMargin);
    
    int radius = innerRect.size.width/2;
    
    CGPoint center = CGPointMake(CGRectGetMidX(innerRect) - radius, CGRectGetMidY(innerRect) - radius);
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                    cornerRadius:radius];
    shape.path = path.CGPath;
    shape.position = center;
    shape.fillColor = bColor.CGColor;
    
    [self.layer addSublayer:shape];
    
    CGPoint upperPoint = CGPointMake(CGRectGetMinX(innerRect) + 0.75000 * CGRectGetWidth(innerRect), CGRectGetMinY(innerRect) + 0.35417 * CGRectGetHeight(innerRect));
    CGPoint middlePoint = CGPointMake(CGRectGetMinX(innerRect) + 0.41667 * CGRectGetWidth(innerRect), CGRectGetMinY(innerRect) + 0.68750 * CGRectGetHeight(innerRect));
    CGPoint lowerPoint = CGPointMake(CGRectGetMinX(innerRect) + 0.27083 * CGRectGetWidth(innerRect), CGRectGetMinY(innerRect) + 0.54167 * CGRectGetHeight(innerRect));

    UIBezierPath * checkMarkPath = [UIBezierPath bezierPath];
    [checkMarkPath moveToPoint: upperPoint];
    [checkMarkPath addLineToPoint:middlePoint];
    [checkMarkPath addLineToPoint:lowerPoint];
    
    CAShapeLayer *drawingLayer = [CAShapeLayer layer];
    drawingLayer.lineWidth = lineWidth;
    drawingLayer.lineJoin = kCALineJoinBevel;
    drawingLayer.fillColor = [UIColor clearColor].CGColor;
    drawingLayer.strokeColor = fColor.CGColor;
    
    [drawingLayer setPath:checkMarkPath.CGPath];
    
    [self.layer addSublayer:drawingLayer];
}

-(void)setForeColor:(UIColor *)foreColor{
    
    fColor = foreColor;
}

-(void)setBackColor:(UIColor *)backColor{
    
    bColor = backColor;
}

@end
