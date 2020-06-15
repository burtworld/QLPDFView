//
//  QLPDFView.m
//  QLDemoProject
//
//  Created by Paramita on 2020/5/9.
//  Copyright © 2020 paramita. All rights reserved.
//

#import "QLPDFView.h"
#import <QLCommonUtils/QLCommonUtils.h>
#import "QLPDFDrawingView.h"

@interface QLPDFView ()
@property (retain, nonatomic)UILabel *indicatorLabel;
@property (retain, nonatomic) QLPDFDrawingView *drawingView;
@property (retain, nonatomic) PDFView *pdfView;
@end

@implementation QLPDFView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configuration];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configuration];
    }
    return self;
}

- (void)configuration {
    self.pdfView = [PDFView new];
    self.pdfView.pageBreakMargins = UIEdgeInsetsMake(0, 0, 4.75, 0);
    self.pdfView.backgroundColor = [UIColor grayColor];
    self.pdfView.delegate = self;
    self.pdfView.autoScales = YES;
    [self addSubview:self.pdfView];
    
    
    self.indicatorLabel = [UILabel new];
    self.indicatorLabel.font = [UIFont systemFontOfSize:15.0f];
    self.indicatorLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    self.indicatorLabel.textColor = [UIColor whiteColor];
    self.indicatorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.indicatorLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pdfScrollAction:) name:PDFViewVisiblePagesChangedNotification object:nil];
}


#pragma mark - actions
- (void)saveToFile:(NSString *)path {
    [MBProgressHUD showLoadingToView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = self.pdfView.document.dataRepresentation;
        [data writeToFile:path atomically:YES];
        
        [MBProgressHUD hideHUDForView:self];
        
    });
}

- (void)saveToFile:(NSString *)path block:(dispatch_block_t)block{
    [MBProgressHUD showLoadingToView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = self.pdfView.document.dataRepresentation;
        [data writeToFile:path atomically:YES];
        
        [MBProgressHUD hideHUDForView:self];
        self.drawingView.addAnnotationCount = 0;
        if (block) {
            block();
        }
    });
}

- (void)nextPage {
    if ([self.pdfView canGoToNextPage]) {
        [self.pdfView goToNextPage:nil];
    }
    
}

- (void)previousPage {
    if ([self.pdfView canGoToPreviousPage]) {
        [self.pdfView goToPreviousPage:nil];
    }
}

- (void)enterDrawingStatus {
    if (!self.drawingView) {
        self.drawingView = [QLPDFDrawingView new];
        self.drawingView.pdfView = self.pdfView;
        [self addSubview:self.drawingView];
    }
    self.drawingView.pdfView = self.pdfView;
    self.drawingView.lineWidth = self.lineWidth;
    self.drawingView.lineColor = self.lineColor;
    self.drawingView.action = 0;
    self.drawingView.hidden = NO;
    
}

- (void)exiteDrawingStatus {
//    self.drawingView.userInteractionEnabled = NO;
    self.drawingView.hidden = YES;
}

- (void)enterEraseStatus {
    if (!self.drawingView) {
        self.drawingView = [QLPDFDrawingView new];
        self.drawingView.pdfView = self.pdfView;
        [self addSubview:self.drawingView];
    }
    self.drawingView.hidden = NO;
    self.drawingView.action = QLPDFDrawingActionErase;
}

- (void)gotoPage:(int)index {
    PDFPage *page = [self.pdfView.document pageAtIndex:index];
    if (page) {
        [self.pdfView goToPage:page];
    }
}

- (NSInteger)getPageCount {
    return [self.pdfView.document pageCount];
}

#pragma mark - set
- (void)setPdfPath:(NSString *)pdfPath {
    _pdfPath = pdfPath;
    if (pdfPath.length) {
        PDFDocument *document = [[PDFDocument alloc] initWithURL:[NSURL fileURLWithPath:pdfPath]];
        self.pdfView.document = document;
    }
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    self.drawingView.lineColor = lineColor;
    
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.drawingView.lineWidth = lineWidth;
}

#pragma mark - Notification
- (void)pdfScrollAction:(NSNotification *)noti {
//    NSLog(@"notif:%@",noti);
}

- (BOOL)isEdited {
    return self.drawingView.addAnnotationCount != 0;
}

#pragma mark - system
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.pdfView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    if (self.drawingView) {
        [self.drawingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - PDFDocumentDelegate
- (void)documentDidUnlock:(NSNotification *)notification{
    
}

- (void)documentDidBeginDocumentFind:(NSNotification *)notification{
    
}

- (void)documentDidEndDocumentFind:(NSNotification *)notification{
    
}

- (void)documentDidBeginPageFind:(NSNotification *)notification{
    
}

- (void)documentDidEndPageFind:(NSNotification *)notification{
    
}

- (void)documentDidFindMatch:(NSNotification *)notification{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
