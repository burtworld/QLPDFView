//
//  UIBezierPath+QLPDFDrawing.h
//  QLDemoProject
//
//  Created by Paramita on 2020/5/10.
//  Copyright © 2020 paramita. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (QLPDFDrawing)
- (void)moveToCenter:(CGPoint)toPoint;

- (void)addPathPreviousPreviousPoint:(CGPoint)p2Point withPreviousPoint:(CGPoint)p1Point withCurrentPoint:(CGPoint)cpoint;
@end

NS_ASSUME_NONNULL_END
