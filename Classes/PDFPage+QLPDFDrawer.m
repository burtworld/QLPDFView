//
//  PDFPage+QLPDFDrawer.m
//  QLDemoProject
//
//  Created by Paramita on 2020/5/11.
//  Copyright © 2020 paramita. All rights reserved.
//

#import "PDFPage+QLPDFDrawer.h"

#import <UIKit/UIKit.h>



@implementation PDFAnnotation (QLPDFDrawer)

- (BOOL)containPoint:(CGPoint)point {
    UIBezierPath *path = self.paths.firstObject;
    if (path) {
        CGPathRef pathref = CGPathCreateCopyByStrokingPath(path.CGPath, NULL, 20, kCGLineCapRound, kCGLineJoinRound, 10);
        UIBezierPath *hitPath = [UIBezierPath new];
        hitPath.CGPath = pathref;
        return [hitPath containsPoint:point];
    }
    return NO;
}

@end

@implementation PDFPage (QLPDFDrawer)

- (PDFAnnotation *)annotationWithHitTest:(CGPoint)point {
    PDFAnnotation *annotaion = [self annotationAtPoint:point];
    if (annotaion) {
        return annotaion;
    }
    for (PDFAnnotation *annotation in self.annotations) {
        if ([annotation containPoint:point]) {
            return annotation;
        }
    }
    return nil;
}

@end
