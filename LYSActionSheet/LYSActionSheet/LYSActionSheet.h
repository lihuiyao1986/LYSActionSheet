//
//  LYSActionSheet.h
//  LYSActionSheet
//
//  Created by jk on 2017/2/27.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYSActionSheet;

typedef void(^ItemDidSelectedBlock)(LYSActionSheet *actionSheet,NSInteger index);

@interface LYSActionSheet : UIView

#pragma mark - 数据
@property(nonatomic,copy)NSArray *items;

#pragma mark - item字体颜色
@property(nonatomic,strong)UIColor *itemColor;

#pragma mark - item选中时字体的颜色
@property(nonatomic,strong)UIColor *itemHighlightColor;

#pragma mark - item选中时的背景颜色
@property(nonatomic,strong)UIColor *itemSelectedBgColor;

#pragma mark - item没选中时的背景颜色
@property(nonatomic,strong)UIColor *itemNormalBgColor;

#pragma mark - item字体
@property(nonatomic,strong)UIFont *itemFont;

#pragma mark - 分割线的颜色
@property(nonatomic,strong)UIColor *seperatorColor;

#pragma mark - item的高度
@property(nonatomic,assign)CGFloat itemH;

#pragma mark - item被选中时的回调
@property(nonatomic,strong)ItemDidSelectedBlock itemSelected;

#pragma mark - 初始化方法
-(instancetype)initWithItems:(NSArray*)items itemH:(CGFloat)itemH;

#pragma mark - 显示
-(void)showInView:(UIView*)targetView;

#pragma mark -隐藏
-(void)dismiss;

@end
