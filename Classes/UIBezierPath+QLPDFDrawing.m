//
//  UIBezierPath+QLPDFDrawing.m
//  QLDemoProject
//
//  Created by Paramita on 2020/5/10.
//  Copyright © 2020 paramita. All rights reserved.
//

#import "UIBezierPath+QLPDFDrawing.h"

#import <UIKit/UIKit.h>

CGPoint ql_midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}


@implementation UIBezierPath (QLPDFDrawing)

- (void)moveToCenter:(CGPoint)toPoint {
    CGRect bound = CGPathGetBoundingBox(self.CGPath);
    CGPoint center = CGPointMake(bound.size.width/2, bound.size.height/2);
    CGPoint zeroedTo = CGPointMake(toPoint.x - bound.origin.x, toPoint.y - bound.origin.y);
    CGVector vector = CGVectorMake(zeroedTo.x - center.x, zeroedTo.y - center.y);
    CGAffineTransform offset = CGAffineTransformMakeTranslation(vector.dx, vector.dy);
    
    CGAffineTransform xform = CGAffineTransformIdentity;
    xform = CGAffineTransformConcat(xform, CGAffineTransformMakeTranslation(-center.x, -center.y));
    xform = CGAffineTransformConcat(xform, offset);
    xform = CGAffineTransformConcat(xform, CGAffineTransformMakeTranslation(center.x, center.y));
    [self applyTransform:xform];

}

- (void)addPathPreviousPreviousPoint:(CGPoint)p2Point withPreviousPoint:(CGPoint)p1Point withCurrentPoint:(CGPoint)cpoint {
    
    CGPoint mid1 = ql_midPoint(p1Point, p2Point);
    CGPoint mid2 = ql_midPoint(cpoint, p1Point);

    [self moveToPoint:mid1];
    [self addQuadCurveToPoint:mid2 controlPoint:mid1];
}

@end
