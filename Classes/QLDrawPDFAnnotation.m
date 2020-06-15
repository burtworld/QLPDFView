//
//  QLDrawPDFAnnotation.m
//  QLDemoProject
//
//  Created by Paramita on 2020/5/9.
//  Copyright © 2020 paramita. All rights reserved.
//

#import "QLDrawPDFAnnotation.h"

@implementation QLDrawPDFAnnotation

- (void)drawWithBox:(PDFDisplayBox)box inContext:(CGContextRef)context {
    
    [super drawWithBox:box inContext:context];
    UIGraphicsPushContext(context);
    CGContextSaveGState(context);
    
//    self.bounds = rect;
//    CGRect pageBounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    CGContextTranslateCTM(context, 0, pageBounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
    if (self.path) {
        [self.color set];
        self.path.lineCapStyle = kCGLineCapRound;
        self.path.lineJoinStyle = kCGLineJoinRound;
        [self.path stroke];
    }else if (self.image){
        PDFRect rect = [self.page boundsForBox:box];
        CGContextDrawImage(context, rect, [self.image CGImage]);
    }
    
    CGContextRestoreGState(context);
    UIGraphicsPopContext();
    

}

//- (void)drawWithBox:(PDFDisplayBox)box inContext:(CGContextRef)context {
//    [super drawWithBox:box inContext:context];
//    UIGraphicsPushContext(context);
//
//    CGContextSaveGState(context);
//
//    UIBezierPath *path = [UIBezierPath new];
//    path.lineWidth = 10;
//    [path moveToPoint:CGPointMake(10, 10 )];
//    [path addLineToPoint:CGPointMake(100, 100)];
//    [[UIColor purpleColor] set];
//
//    [path stroke];
//    CGContextRestoreGState(context);
//    UIGraphicsPopContext();
//    [super drawWithBox:box inContext:context];
////    self.bounds = CGRectMake(0, 0, 1000, 1000);
//    UIGraphicsPushContext(context);
//    CGContextSaveGState(context);
//
//    PDFRect rect = [self.page boundsForBox:box];
//
//    CGRect pageBounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    CGContextTranslateCTM(context, 0, pageBounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
////    CGContextRotateCTM(context, M_PI_4);
//    NSLog(@"page bounds == %@",NSStringFromCGRect(pageBounds));
//
//    NSLog(@"self bounds == %@",NSStringFromCGRect(self.bounds));
//    NSString *str = @"水印 水印 水印水印 水印 水印水印 水印 水印\n水印 水印 水印水印 水印 水印水印 水印 水印";
//    NSDictionary  *attributes = @{
//                      NSForegroundColorAttributeName: [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5],
//                      NSFontAttributeName: [UIFont systemFontOfSize:64]
//                      };
//
//    [str drawAtPoint:CGPointMake(0, 0) withAttributes:attributes];
////    [[UIColor yellowColor] set];
////    CGContextFillRect(context, pageBounds);
//    CGContextRestoreGState(context);
//    UIGraphicsPopContext();
//}

@end
