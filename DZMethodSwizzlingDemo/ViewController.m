//
//  ViewController.m
//  DZMethodSwizzlingDemo
//
//  Created by Wenbing Zuo on 4/14/17.
//  Copyright © 2017 Wenbing Zuo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(UIButton *)sender {
    NSLog(@"点击了按钮：%@", sender.titleLabel.text);
}

@end
