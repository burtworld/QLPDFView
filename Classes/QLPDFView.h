//
//  QLPDFView.h
//  QLDemoProject
//
//  Created by Paramita on 2020/5/9.
//  Copyright © 2020 paramita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PDFKit/PDFKit.h>

#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLPDFView : UIView<PDFViewDelegate,PDFDocumentDelegate>
@property (retain, nonatomic,readonly) PDFView *pdfView;
@property (copy, nonatomic) NSString * pdfPath;


@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

/// 编辑文档
@property (assign, nonatomic) BOOL isEdited;


/// 进行绘制状态
- (void)enterDrawingStatus;


/// 进入擦除状态
- (void)enterEraseStatus;

/// 退出绘制状态
- (void)exiteDrawingStatus;



/// 保存文件
/// @param path 保存路径
- (void)saveToFile:(NSString *)path;

/// 保存文件
/// @param path 文件路径
/// @param block 回调
- (void)saveToFile:(NSString *)path block:(dispatch_block_t)block;

/// PDF下一页
- (void)nextPage;

/// PDF上一页
- (void)previousPage;

/// 前往页数
/// @param index 页数
- (void)gotoPage:(int)index;

/// 获取总页数
- (NSInteger)getPageCount;
@end

NS_ASSUME_NONNULL_END
