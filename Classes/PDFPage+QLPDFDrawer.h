//
//  PDFPage+QLPDFDrawer.h
//  QLDemoProject
//
//  Created by Paramita on 2020/5/11.
//  Copyright © 2020 paramita. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PDFKit/PDFKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface PDFAnnotation (QLPDFDrawer)
- (BOOL)containPoint:(CGPoint)point;
@end

@interface PDFPage (QLPDFDrawer)
- (PDFAnnotation *)annotationWithHitTest:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
