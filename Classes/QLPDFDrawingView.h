//
//  QLPDFDrawingView.h
//  QLDemoProject
//
//  Created by Paramita on 2020/5/8.
//  Copyright © 2020 paramita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLDrawingTool.h"
#import <PDFKit/PDFKit.h>

typedef enum : NSUInteger {
    QLPDFDrawingActionDraw = 0, ///! 绘制
    QLPDFDrawingActionErase = 1, ///! 擦除
} QLPDFDrawingAction;

#define kDefaultLineColor       [UIColor blackColor]
#define kDefaultLineWidth       10.0f;
#define kDefaultLineAlpha       1.0f

NS_ASSUME_NONNULL_BEGIN


@interface QLPDFDrawingView : UIView
// public properties
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineAlpha;
@property (assign, nonatomic) QLPDFDrawingAction action;
// get the current drawing
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, strong, readonly) NSMutableArray *pathArray;

@property (retain, nonatomic) PDFView *pdfView;
@property (assign, nonatomic) int addAnnotationCount;
@end

NS_ASSUME_NONNULL_END
