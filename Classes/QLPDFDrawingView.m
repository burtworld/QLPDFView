//
//  QLPDFDrawingView.m
//  QLDemoProject
//
//  Created by Paramita on 2020/5/8.
//  Copyright © 2020 paramita. All rights reserved.
//

#import "QLPDFDrawingView.h"

#import "QLDrawPDFAnnotation.h"
#import "UIBezierPath+QLPDFDrawing.h"
#import "PDFPage+QLPDFDrawer.h"

@interface QLPDFDrawingView (){
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;
}



@property (nonatomic, strong) NSMutableArray *pathArray;
@property (retain, nonatomic) NSMutableArray *anotationPathArray;
@property (nonatomic, strong) NSMutableArray *bufferArray;
@property (retain, nonatomic) QLDrawingTool *currentTool;
@property (nonatomic, strong) UIImage *image;
@property (retain, nonatomic) UIBezierPath *path;
@property (retain, nonatomic) PDFPage *currentPage;
@property (retain, nonatomic) QLDrawPDFAnnotation *currentAnnotaion;
@end

@implementation QLPDFDrawingView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    // init the private arrays
    self.pathArray = [NSMutableArray array];
    self.bufferArray = [NSMutableArray array];
    
    // set the default values for the public properties
    self.lineColor = kDefaultLineColor;
    self.lineWidth = kDefaultLineWidth;
    self.lineAlpha = kDefaultLineAlpha;
    
    // set the transparent background
    self.backgroundColor = [UIColor clearColor];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    self.currentPage = [self.pdfView pageForPoint:previousPoint1 nearest:YES];
    CGPoint converPoiont = [self.pdfView convertPoint:previousPoint1 toPage:self.currentPage];
    self.path = [UIBezierPath new];
    [self.path moveToPoint:converPoiont];
    self.path.lineWidth = self.lineWidth;

}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    previousPoint2 = previousPoint1;
    previousPoint1 = [touch previousLocationInView:self];
    currentPoint = [touch locationInView:self];
    
    /// pdf drawer
    CGPoint converddPreviousPoint2 = [self.pdfView convertPoint:previousPoint2 toPage:self.currentPage];
    CGPoint converedPreviousPoint1 = [self.pdfView convertPoint:previousPoint1 toPage:self.currentPage];
    CGPoint converedCurrnetPoint = [self.pdfView convertPoint:currentPoint toPage:self.currentPage];
    
    if (self.action == QLPDFDrawingActionErase) {
//        PDFPage *page = [self.pdfView pageForPoint:converedCurrnetPoint nearest:YES];
        [self removeAnnotaionAtPoint:converedCurrnetPoint page:self.currentPage];
        
        return;
    }
    [self.path addPathPreviousPreviousPoint:converddPreviousPoint2 withPreviousPoint:converedPreviousPoint1 withCurrentPoint:converedCurrnetPoint];
    if (self.currentAnnotaion == nil) {
        CGRect bounds = [self.currentPage boundsForBox:self.pdfView.displayBox];
        self.currentAnnotaion = [[QLDrawPDFAnnotation alloc] initWithBounds:bounds forType:PDFAnnotationSubtypeInk withProperties:nil];
    }
    self.currentAnnotaion.color = self.lineColor;
    self.currentAnnotaion.path = self.path;
    [self.currentPage removeAnnotation:self.currentAnnotaion];
    [self.currentPage addAnnotation:self.currentAnnotaion];
}





- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    if (!self.currentAnnotaion) {
        return;
    }

    [self.currentPage removeAnnotation:self.currentAnnotaion];
    
    CGRect bounds = CGRectMake(
                               self.path.bounds.origin.x - 5,
                               self.path.bounds.origin.y - 5,
                               self.path.bounds.size.width + 10,
                               self.path.bounds.size.height + 10
                               );
    UIBezierPath *finalPath = [UIBezierPath new];
    finalPath.CGPath = self.path.CGPath;
    finalPath.lineWidth = self.lineWidth;
//    [finalPath moveToCenter:CGPointMake(bounds.size.width/2, bounds.size.height/2)];
    QLDrawPDFAnnotation *annotion = [[QLDrawPDFAnnotation alloc] initWithBounds:bounds forType:PDFAnnotationSubtypeInk withProperties:nil];
    annotion.color = self.lineColor;
    annotion.path = finalPath;
//    [annotion addBezierPath:finalPath];
    [self.currentPage addAnnotation:annotion];
    self.addAnnotationCount ++;
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // make sure a point is recorded
    [self touchesEnded:touches withEvent:event];
}

- (void)removeAnnotaionAtPoint:(CGPoint)point page:(PDFPage*)page {
    PDFAnnotation *annotaion = [page annotationWithHitTest:point];
    if (annotaion) {
        [annotaion.page removeAnnotation:annotaion];
        self.addAnnotationCount--;
    }else{
        
    }
    
}

- (void)updateCacheImage:(BOOL)redraw
{
    // init a context
//    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
//    
//    if (redraw) {
//        // erase the previous image
//        self.image = nil;
//        
//        // load previous image (if returning to screen)
////        [[self.prev_image copy] drawInRect:self.bounds];
//        
//        // I need to redraw all the lines
//        for (QLDrawingTool * tool in self.pathArray) {
//            [tool draw];
//        }
//        
//    } else {
//        // set the draw point
//        [self.image drawAtPoint:CGPointZero];
//        [self.currentTool draw];
//    }
//    
//    // store the image
//    self.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
}



- (void)clear
{
    self.currentTool = nil;
    [self.bufferArray removeAllObjects];
    [self.pathArray removeAllObjects];
//    self.prev_image = nil;
    [self updateCacheImage:YES];
    [self setNeedsDisplay];
}

- (BOOL)canUndo
{
    return self.pathArray.count > 0;
}

- (void)undoLatestStep
{
    if ([self canUndo]) {
//        [self resetTool];
        QLDrawingTool * tool = [self.pathArray lastObject];
        [self.bufferArray addObject:tool];
        [self.pathArray removeLastObject];
        [self updateCacheImage:YES];
        [self setNeedsDisplay];
    }
}



#pragma mark - drawRect
- (void)drawRect:(CGRect)rect
{
//    [self.image drawInRect:self.bounds];
//    [self.currentTool draw];
}


@end
