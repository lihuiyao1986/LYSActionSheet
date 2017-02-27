//
//  DetailViewController.m
//  LYSActionSheet
//
//  Created by jk on 2017/2/27.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "DetailViewController.h"
#import "LYSActionSheet.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
    
    UIButton *_btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 120, CGRectGetWidth(self.view.frame) - 40, 44.f)];
    _btn.backgroundColor = [UIColor greenColor];
    [_btn setTitle:@"选择相片" forState:UIControlStateNormal];
    _btn.layer.cornerRadius = 8;
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

-(void)btnClicked:(UIButton*)sender{
    LYSActionSheet *_actionSheet = [[LYSActionSheet alloc]initWithItems:@[@"拍照",@"相册",@"取消"] itemH:44.f];
    
    _actionSheet.itemFont = [UIFont systemFontOfSize:14];
    _actionSheet.itemHighlightColor = [UIColor redColor];
    _actionSheet.itemH = 44.f;
    _actionSheet.itemSelected = ^(LYSActionSheet *actionSheet,NSInteger index){
        NSLog(@"you click the %lu item",(unsigned long)index);
//        [actionSheet dismiss];
    };
    [_actionSheet showInView:self.view];
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
