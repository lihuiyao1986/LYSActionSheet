//
//  LYSActionSheet.m
//  LYSActionSheet
//
//  Created by jk on 2017/2/27.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSActionSheet.h"

#define BASE_BTN_TAG 1000
#define FIRST_ITEM_SPACING 10

@interface LYSActionSheet (){
    UIView *_containerView;
}

@end

@implementation LYSActionSheet


#pragma mark - 初始化方法
-(instancetype)initWithItems:(NSArray*)items itemH:(CGFloat)itemH{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self){
        _itemH = itemH;
        _items = items;
        _itemFont = [UIFont systemFontOfSize:12];
        _itemColor = [self colorWithHexString:@"414141" alpha:1.0];
        _itemNormalBgColor = [UIColor whiteColor];
        _seperatorColor = [self colorWithHexString:@"e3e2e2" alpha:1.0];
        _itemSelectedBgColor = [self colorWithHexString:@"e3e2e2" alpha:1.0];
        [self initConfig];
    }
    return self;
}

#pragma mark - 初始化
-(void)initConfig{
    
    // 设置背景
    self.layer.backgroundColor = [self maskColor].CGColor;
    
    // 容器视图
    _containerView = [[UIView alloc]init];
    _containerView.backgroundColor = [self colorWithHexString:@"f2f2f2" alpha:1.0];
    [self addSubview:_containerView];
    
    // 添加子视图
    for(NSInteger index = 0 ; index <= _items.count - 1 ; index++){
        [_containerView addSubview:[self createItemButton:index title:self.items[index]]];
    }
    
}

-(void)setItemFont:(UIFont *)itemFont{
    for (NSUInteger index = 0 ; index <= self.items.count - 1; index++) {
        UIButton *_itemBtn = [_containerView viewWithTag:BASE_BTN_TAG + index];
        _itemBtn.titleLabel.font = itemFont;
    }
}

-(void)setItemColor:(UIColor *)itemColor{
    for (NSUInteger index = 0 ; index <= self.items.count - 1; index++) {
        UIButton *_itemBtn = [_containerView viewWithTag:BASE_BTN_TAG + index];
        [_itemBtn setTitleColor:itemColor forState:UIControlStateNormal];
    }
}

-(void)setSeperatorColor:(UIColor *)seperatorColor{
    for (NSUInteger index = 0 ; index <= self.items.count - 1; index++) {
        UIButton *_itemBtn = [_containerView viewWithTag:BASE_BTN_TAG + index];
        UIView *_view = [_itemBtn viewWithTag:_itemBtn.tag + 10];
        _view.backgroundColor = seperatorColor;
    }
}

-(void)setItemNormalBgColor:(UIColor *)itemNormalBgColor{
    for (NSUInteger index = 0 ; index <= self.items.count - 1; index++) {
        UIButton *_itemBtn = [_containerView viewWithTag:BASE_BTN_TAG + index];
        [_itemBtn setBackgroundImage:[self createImageWithColor:itemNormalBgColor] forState:UIControlStateNormal];
    }
}

-(void)setItemHighlightColor:(UIColor *)itemHighlightColor{
    for (NSUInteger index = 0 ; index <= self.items.count - 1; index++) {
        UIButton *_itemBtn = [_containerView viewWithTag:BASE_BTN_TAG + index];
        [_itemBtn setTitleColor:itemHighlightColor forState:UIControlStateHighlighted];
    }
}

-(void)setItemSelectedBgColor:(UIColor *)itemSelectedBgColor{
    for (NSUInteger index = 0 ; index <= self.items.count - 1; index++) {
        UIButton *_itemBtn = [_containerView viewWithTag:BASE_BTN_TAG + index];
        [_itemBtn setBackgroundImage:[self createImageWithColor:itemSelectedBgColor] forState:UIControlStateHighlighted];
    }
}

-(void)setItemH:(CGFloat)itemH{
    if (itemH > 0){
        _itemH = itemH;
        [self setNeedsLayout];
    }
}

#pragma mark 将颜色转换成图片
- (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;

}

#pragma mark - 重写layoutSubviews方法
-(void)layoutSubviews{
    [super layoutSubviews];
    _containerView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - [self containerViewH], CGRectGetWidth(self.frame), [self containerViewH]);
    for (NSInteger index = _items.count - 1 ; index >= 0 ; index--) {
        UIButton *btn = [_containerView viewWithTag:BASE_BTN_TAG + index];
        CGFloat yOffset = CGRectGetHeight(_containerView.frame) - (_items.count - 1 - index + 1) * self.itemH;
        if (index < _items.count - 1){
            yOffset = (CGRectGetHeight(_containerView.frame) - (_items.count - 1 - index + 1) * self.itemH  - FIRST_ITEM_SPACING);
        }
        btn.frame = CGRectMake(0, yOffset, CGRectGetWidth(_containerView.frame), self.itemH);
        [btn viewWithTag:btn.tag + 10].frame = CGRectMake(0, CGRectGetHeight(btn.frame) - 0.5f, CGRectGetWidth(btn.frame), 0.5f);
    }
}


#pragma mark - 容器高度
-(CGFloat)containerViewH{
    return self.items.count * self.itemH + FIRST_ITEM_SPACING;
}

#pragma mark - 创建按钮
-(UIButton*)createItemButton:(NSInteger)index title:(NSString*)title{
    UIButton *_itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _itemBtn.tag = BASE_BTN_TAG + index;
    _itemBtn.titleLabel.font = self.itemFont;
    [_itemBtn setTitle:title forState:UIControlStateNormal];
    [_itemBtn setTitle:title forState:UIControlStateHighlighted];
    [_itemBtn setTitleColor:self.itemColor forState:UIControlStateNormal];
    [_itemBtn setTitleColor:self.itemHighlightColor forState:UIControlStateHighlighted];
    [_itemBtn setBackgroundImage:[self createImageWithColor:self.itemSelectedBgColor] forState:UIControlStateHighlighted];
    [_itemBtn setBackgroundImage:[self createImageWithColor:self.itemNormalBgColor] forState:UIControlStateNormal];
    [_itemBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIView *_lineView = [[UIView alloc]init];
    _lineView.backgroundColor = self.seperatorColor;
    _lineView.tag = _itemBtn.tag + 10;
    [_itemBtn addSubview:_lineView];
    return _itemBtn;
}

#pragma mark - 按钮被点击
-(void)btnClicked:(UIButton*)sender{
    NSInteger index = sender.tag - BASE_BTN_TAG;
    if (self.itemSelected) {
        self.itemSelected(self,index);
    }
}

#pragma mark - 隐藏
-(void)dismiss{
    __weak typeof (self) MyWeak = self;
    [UIView animateWithDuration:0.25 animations:^{
        MyWeak.alpha = 0;
        _containerView.frame = CGRectMake(0, CGRectGetHeight(MyWeak.frame), CGRectGetWidth(MyWeak.frame), _containerView.frame.size.height);
    } completion:^(BOOL finished) {
        [MyWeak removeFromSuperview];
    }];
}

#pragma mark - 显示
-(void)showInView:(UIView *)targetView{
    if(self.superview){
        [self removeFromSuperview];
    }
    [targetView addSubview:self];
    self.alpha = 0;
    __weak typeof (self) MyWeak = self;
    [UIView animateWithDuration:0.25 animations:^{
        MyWeak.alpha = 1.0;
        _containerView.transform = CGAffineTransformMakeTranslation(0, -[MyWeak containerViewH]);
    }  completion:nil];
}


#pragma mark - 遮罩颜色
-(UIColor*)maskColor{
    return [self colorWithHexString:@"000000" alpha:0.4];
}


#pragma mark - 生成16进制颜色
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

#pragma mark - 触摸开始
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if (!CGRectContainsPoint(_containerView.frame, touchPoint)) {
        [self dismiss];
    }
}


@end
