//
//  QLDrawPDFAnnotation.h
//  QLDemoProject
//
//  Created by Paramita on 2020/5/9.
//  Copyright © 2020 paramita. All rights reserved.
//

#import <PDFKit/PDFKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLDrawPDFAnnotation : PDFAnnotation
@property (retain, nonatomic) UIBezierPath *path;
@property (retain, nonatomic) UIImage *image;
@end

NS_ASSUME_NONNULL_END
