//
//  QLDrawTool.m
//  QLDemoProject
//
//  Created by Paramita on 2020/5/9.
//  Copyright © 2020 paramita. All rights reserved.
//

#import "QLDrawingTool.h"

//CGPoint midPoint(CGPoint p1, CGPoint p2)
//{
//    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
//}
//
@implementation QLDrawingTool
//
//- (id)init
//{
//    self = [super init];
//    if (self != nil) {
//        self.lineCapStyle = kCGLineCapRound;
//        path = CGPathCreateMutable();
//
//    }
//    return self;
//}
//
//- (CGRect)addPathPreviousPreviousPoint:(CGPoint)p2Point withPreviousPoint:(CGPoint)p1Point withCurrentPoint:(CGPoint)cpoint {
//
//    CGPoint mid1 = midPoint(p1Point, p2Point);
//    CGPoint mid2 = midPoint(cpoint, p1Point);
//    CGMutablePathRef subpath = CGPathCreateMutable();
//    CGPathMoveToPoint(subpath, NULL, mid1.x, mid1.y);
//    CGPathAddQuadCurveToPoint(subpath, NULL, p1Point.x, p1Point.y, mid2.x, mid2.y);
//    CGRect bounds = CGPathGetBoundingBox(subpath);
//
//    CGPathAddPath(path, NULL, subpath);
//    CGPathRelease(subpath);
//
//    return bounds;
//}
//
- (void)draw{
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGContextAddPath(context, path);
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineWidth(context, self.lineWidth);
////    CGFloat red = (arc4random()%255)/255.0;
////    CGFloat green = (arc4random()%255)/255.0;
////    CGFloat blue = (arc4random()%255)/255.0;
////    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
//    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
//    CGContextSetBlendMode(context, kCGBlendModeNormal);
//    CGContextSetAlpha(context, self.lineAlpha);
//    CGContextStrokePath(context);
}


@end
